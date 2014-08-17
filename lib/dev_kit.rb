require "dev_kit/detector"
require "dev_kit/locations"

module DevKit
  def self.available
    Detector.new(candidates).available
  end

  def self.candidates
    Locations.new.all
  end
end
