require "dev_kit/version_file"

module DevKit
  class Activator
    DK_KEY = "RI_DEVKIT".freeze

    attr_reader :path
    attr_reader :version_info

    # FIXME: remove external dependency, we only need new ENV variables
    def initialize(path, version_info = DevKit.version_info, env = ENV)
      @env          = env
      @path         = path
      @version_info = version_info
    end

    def activate!
      return if activated?

      set_path
      set_devkit
      set_environment
    end

    def activated?
      devkit_set? || paths_present?
    end

    private

    def devkit_set?
      @env.has_key?(DK_KEY)
    end

    def formatted_paths
      return @formatted_paths if @formatted_paths

      paths = [
        File.join(path, "bin"),
        File.join(path, "mingw", "bin")
      ]

      @formatted_paths = paths.collect { |path|
        path.gsub(File::SEPARATOR, File::ALT_SEPARATOR)
      }
    end

    def formatted_root
      @formatted_root ||= path.gsub(File::SEPARATOR, File::ALT_SEPARATOR)
    end

    def paths_present?
      env_path = @env["PATH"]

      formatted_paths.any? { |path| env_path.include?(path) }
    end

    def set_devkit
      @env[DK_KEY] = formatted_root
    end

    def set_environment
      version_info.each do |key, value|
        @env[key] = value
      end
    end

    def set_path
      @env["PATH"] = [
        formatted_paths,
        @env["PATH"]
      ].flatten.join(File::PATH_SEPARATOR)
    end
  end
end
