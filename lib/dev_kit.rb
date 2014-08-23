require "dev_kit/detector"
require "dev_kit/locations"
require "dev_kit/info_file"

module DevKit
  def self.available
    Detector.new(candidates).available
  end

  def self.candidates
    Locations.new(info_file).all
  end

  def self.info_file
    return @info_file if @info_file

    ruby_root = File.expand_path("../..", Gem.ruby)

    @info_file = InfoFile.new(ruby_root)
  end
end
