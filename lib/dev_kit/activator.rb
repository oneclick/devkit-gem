module DevKit
  class Activator
    DK_KEY = "RI_DEVKIT".freeze

    attr_reader :info_file
    attr_reader :path

    def initialize(path, info_file = DevKit.info_file, env = ENV)
      @env       = env
      @info_file = info_file
      @path      = path
    end

    def activate!
      return false if activated?

      set_path
      set_devkit
      set_environment

      true
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

      paths = info_file.paths.collect { |p|
        File.join(path, p)
      }

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
      info_file.environment.each do |key, value|
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
