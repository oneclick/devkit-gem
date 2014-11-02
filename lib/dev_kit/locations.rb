require "dev_kit/info_file"

module DevKit
  class Locations
    attr_reader :ruby_root

    def initialize(info_file = nil, ruby_exe = Gem.ruby)
      # path/bin/ruby.exe
      @ruby_root = File.expand_path("../..", ruby_exe)
      @info_file = info_file
    end

    def all
      [
        ruby_relative,
        default_dir
      ]
    end

    def default_dir
      return @default_dir if @default_dir

      base_dir = File.expand_path(ENV["ProgramData"] || ENV["ALLUSERSPROFILE"])
      required_version = info_file.version

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

    def info_file
      @info_file ||= InfoFile.new(ruby_root)
    end
  end
end
