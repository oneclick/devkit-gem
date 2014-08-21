require "dev_kit/detector"
require "dev_kit/locations"
require "dev_kit/version_file"

module DevKit
  def self.available
    Detector.new(candidates).available
  end

  def self.candidates
    Locations.new(version_info).all
  end

  def self.version_info
    return @version_info if @version_info

    ruby_root = File.expand_path("../..", Gem.ruby)

    @version_info = VersionFile.new(ruby_root)
  end
end
