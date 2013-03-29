module CssConvertor
  module Convertor
    PROPERTY_MAP = {
      'margin-left'=> 'margin-right',
      'margin-right'=> 'margin-left',

      'padding-left'=> 'padding-right',
      'padding-right'=> 'padding-left',

      'border-left'=> 'border-right',
      'border-right'=> 'border-left',

      'border-left-width'=> 'border-right-width',
      'border-right-width'=> 'border-left-width',

      'border-left-color'=> 'border-right-color',
      'border-right-color'=> 'border-left-color',

      'border-left-style'=> 'border-right-style',
      'border-right-style'=> 'border-left-style',

      'border-radius-bottomleft'=> 'border-radius-bottomright',
      'border-radius-bottomright'=> 'border-radius-bottomleft',
      'border-bottom-right-radius'=> 'border-bottom-left-radius',
      'border-bottom-left-radius'=> 'border-bottom-right-radius',
      '-webkit-border-bottom-right-radius'=> '-webkit-border-bottom-left-radius',
      '-webkit-border-bottom-left-radius'=> '-webkit-border-bottom-right-radius',
      '-moz-border-radius-bottomright'=> '-moz-border-radius-bottomleft',
      '-moz-border-radius-bottomleft'=> '-moz-border-radius-bottomright',

      'border-radius-topleft'=> 'border-radius-topright',
      'border-radius-topright'=> 'border-radius-topleft',
      'border-top-right-radius'=> 'border-top-left-radius',
      'border-top-left-radius'=> 'border-top-right-radius',
      '-webkit-border-top-right-radius'=> '-webkit-border-top-left-radius',
      '-webkit-border-top-left-radius'=> '-webkit-border-top-right-radius',
      '-moz-border-radius-topright'=> '-moz-border-radius-topleft',
      '-moz-border-radius-topleft'=> '-moz-border-radius-topright',

      'left'=> 'right',
      'right'=> 'left'
    }
    FLIP_MAP = {'rtl'=>'ltr', 'ltr'=>'rtl', 'right'=>'left', 'left'=>'right'}
    VALUE_MAP = {
      'padding'=> :quad,
      'margin'=> :quad,
      'border-color'=> :quad, 
      'border-width'=> :quad, 
      'border-style'=> :quad,
      '-webkit-border-radius' => :quad_radius,
      '-moz-border-radius'=> :quad_radius,
      'border-radius'=> :quad_radius,
      'text-align'=> :direction, 
      'float'=> :direction,
      'clear'=> :direction,
      'direction'=> :direction
    }
    def scan_and_replace(str)
      str.gsub(/([a-z\-]+)\s*:\s*(.+?)(?=\s*[;}])/) {"#{property($1)}:#{value($1, $2)}"}
    end
    def property(property_name)
      PROPERTY_MAP[property_name] || property_name
    end
    def value(property_name, property_value)
      VALUE_MAP[property_name] ? new_value(VALUE_MAP[property_name], property_value) : property_value 
    end
    def new_value(type, value)
      full_value = value
      value = get_actual_value(value)
      arr = split_property_value(value)

      if type==:direction && FLIP_MAP[value]
        full_value.gsub!(/#{Regexp.escape(value)}/, FLIP_MAP[value])
      elsif type==:quad && arr.length==4
        arr[1], arr[3] = arr[3], arr[1]
        full_value.gsub!(/#{Regexp.escape(value)}/, arr.join(' '))
      elsif type==:quad_radius && arr.length==4
        arr[0], arr[1], arr[2], arr[3] = arr[1], arr[0], arr[3], arr[2]
        full_value.gsub!(/#{Regexp.escape(value)}/, arr.join(' '))
      end
      full_value
    end
    def get_actual_value(value)
      match_data = %r{(.+?) ?(?=!important|\\9|\\0/)}.match(value)
      match_data ? match_data[1] : value
    end
    def split_property_value(value)
      value.scan(/rgba?\(.*?\)|hsla?\(.*?\)|#[0-9a-f]{3,6}|[\w.%-]+/)
    end
  end
end