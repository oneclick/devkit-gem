# RubyInstaller's DevKit - PoC

Proof-of-Concept of simpler RubyInstaller's DevKit activation and detection
mechanism.

It aims to replace current approach of dealing with DevKit installation and
replace by a RubyGems plugin.

**IMPORTANT**

This project is not 100% functional, it implements some of the ideas
mentioned in RubyInstaller's mailing list:

https://groups.google.com/d/topic/rubyinstaller/fZAmPSlz4zM/discussion

Please see the TODO list of things to be completed before this project can
be considered ready.

## TODO

- [ ] Add basic `devkit.rb`
- [ ] Add RubyGems plugin hook
- [ ] Reorganize classes and introduce specs to activation and detection
- [ ] Download, verify and extract DevKit (perhaps bundle 7za?)
- [ ] `devkit.yml` generator
- [ ] CLI

## Internals

The following describes a bit the internal classes of this gem:

```ruby
# obtain list of possible places for DevKit installation
DevKit.candidates
# => ["C:/Ruby200-x64/DevKit", "C:/ProgramData/RubyInstaller/DevKit/mingw64-64-4.7.2"]

# determine real availability (using checks and binaries listed in devkit.yml)
path = DevKit.available.first
# => "C:/ProgramData/RubyInstaller/DevKit/mingw64-64-4.7.2"

# activate the DevKit in path
activator = DevKit::Activator.new(path)
# => #<DevKit::Activator:0x0000000313e860 .... @info_file=#<struct DevKit::InfoFile root="C:/Ruby200-x64">, @path="C:/ProgramData/RubyInstaller/DevKit/mingw64-64-4.7.2">

a.activate!
# => true

a.activated?
# => true
```

## Installation

Use RubyGems to install the gem:

```console
gem install rubyinstaller-devkit
```

And then verify your DevKit installation:

```console
devkit check
```

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/oneclick/devkit-gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
