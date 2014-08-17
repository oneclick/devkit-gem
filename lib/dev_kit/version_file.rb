require "yaml"

module DevKit
  class VersionFile < Struct.new(:root)
    def version
      return @version if @version

      data = YAML.load_file(config_file)

      @version = data["version"]
    end

    private

    def config_file
      config_file = File.join(root, "devkit.yml")

      File.exist?(config_file) or
        raise "DevKit's version file (`devkit.yml`) not found."

      config_file
    end
  end
end
