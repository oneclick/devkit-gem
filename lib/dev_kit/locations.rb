require "dev_kit/version_file"

module DevKit
  class Locations
    attr_reader :ruby_root

    def initialize(version_file = nil, ruby_exe = Gem.ruby)
      # path/bin/ruby.exe
      @ruby_root    = File.expand_path("../..", ruby_exe)
      @version_file = version_file
    end

    def all
      paths = []
      paths << ruby_relative
      paths << default_dir
      paths
    end

    def default_dir
      return @default_dir if @default_dir

      base_dir = File.expand_path(ENV["ProgramData"] || ENV["ALLUSERSPROFILE"])
      required_version = version_file.version

      path = [
        base_dir,
        "RubyInstaller",
        "DevKit",
        required_version
      ]

      @default_dir = File.join(path)
    end

    def ruby_relative
      File.join(ruby_root, "DevKit")
    end

    private

    def version_file
      @version_file ||= VersionFile.new(ruby_root)
    end
  end
end
