require "yaml"

module DevKit
  class InfoFile < Struct.new(:root)
    def environment
      @environment ||= data.fetch("environment", {})
    end

    def paths
      @paths ||= data.fetch("paths", [])
    end

    def version
      data.fetch("version")
    end

    private

    def config_file
      config_file = File.join(root, "devkit.yml")

      File.exist?(config_file) or
        raise "DevKit's info file (`devkit.yml`) not found."

      config_file
    end

    def data
      @data ||= YAML.load_file(config_file)
    end
  end
end
