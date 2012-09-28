module CssConvertor
  class Command
    def initialize(filepath)
      @filepath = filepath
    end
    def rtl_filename
      @filepath.gsub(/(.*?).css/) {"#{$1}-rtl.css"}
    end 
    def convert
      css = ''

      puts CssConvertor.style("\nOpening file..", :color=>:yellow)
      File.open(@filepath, 'r') {|f| css = f.read}
      puts CssConvertor.style("Opening file..OK", :color=>:green)

      puts CssConvertor.style("\nScanning and replacing..", :color=>:yellow)
      css = CssConvertor.replace(css)
      puts CssConvertor.style("Scanning and replacing..OK", :color=>:green)

      puts CssConvertor.style("\nWriting to new file..", :color=>:yellow)
      new_filename = rtl_filename
      File.open(new_filename, 'w') {|f| f << css}
      puts CssConvertor.style("Writing to new file..OK", :color=>:green)
      puts CssConvertor.style("\nDONE. Check: #{new_filename}", 
                             :color=>:green, :bold=>true)
    rescue Exception => e
      puts CssConvertor.style("\nTerminating because of these errors:", :color=>:red)
      puts CssConvertor.style(e.message, :color=>:red)
      puts e.backtrace
    end
  end
end