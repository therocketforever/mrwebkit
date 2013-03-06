    framework 'Cocoa'
    framework 'MacRuby'

    def deployed?
      !NSBundle.allFrameworks.find { |x|
        x.bundleIdentifier == 'org.macruby' &&
        x.bundlePath.match(/^\/Library\/Frameworks/)
      }
    end

    # Loading all the Ruby project files.
    main = File.basename(__FILE__, File.extname(__FILE__))
    dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
    dir_path += '/lib/'
    Dir.glob(File.join(dir_path, '*.{rb,rbo}')).map { |x| File.basename(x, File.extname(x)) }.uniq.each do |path|
      if path != main
        require File.join(dir_path, path)
      end
    end

    # Starting the Cocoa main loop.
    NSApplicationMain(0, nil)
