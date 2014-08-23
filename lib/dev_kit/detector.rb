require "rbconfig"

module DevKit
  class Detector
    attr_reader :info_file
    attr_reader :locations

    def initialize(locations, info_file = DevKit.info_file)
      @info_file = info_file
      @locations = Array(locations)
    end

    def available
      locations.select { |location|
        detect(location)
      }
    end

    private

    # for *all* the executables
    # try combinations of path + paths where the executables are found
    def detect(path)
      executables.all? { |executable|
        info_file.paths.any? { |p|
          file = File.join(path, p, executable)

          File.exist?(file) && File.executable?(file)
        }
      }
    end

    def executables
      return @executables if @executables

      exe_ext = RbConfig::CONFIG["EXEEXT"]

      # FIXME: demeter.would.not.like.this
      @executables = info_file.environment.values.collect { |file|
        "#{file}#{exe_ext}"
      }
    end
  end
end
