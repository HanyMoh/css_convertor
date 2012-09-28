require "css_convertor/convertor"
require "css_convertor/simple_styler"
require "css_convertor/command"
require "css_convertor/version"

include CssConvertor::Convertor
module CssConvertor
  def self.replace(css)
    scan_and_replace(css)
  end
  def self.style(text,options={:color=>:reset, :bold=>false})
    SimpleStyler.new(text).style_text(options)
  end
  def self.convert(filepath)
    Command.new(filepath).convert
  end
end