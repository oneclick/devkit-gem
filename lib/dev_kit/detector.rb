module DevKit
  class Detector < Struct.new(:locations)
    def available
      locations.select { |location|
        detect(location)
      }
    end

    private

    def detect(path)
      msys_bin  = File.join(path, "bin")
      mingw_bin = File.join(path, "mingw", "bin")

      probes = [
        File.join(msys_bin, "make.exe"),
        File.join(mingw_bin, "gcc.exe")
      ]

      probes.all? { |file|
        File.exist?(file) && File.executable?(file)
      }
    end
  end
end
