require "yaml"

module DevKit
  class VersionFile < Struct.new(:root)
    def environment
      @environment ||= data.fetch("environment", {})
    end

    def version
      data.fetch("version")
    end

    private

    def config_file
      config_file = File.join(root, "devkit.yml")

      File.exist?(config_file) or
        raise "DevKit's version file (`devkit.yml`) not found."

      config_file
    end

    def data
      @data ||= YAML.load_file(config_file)
    end
  end
end
