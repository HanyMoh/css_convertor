require 'test/unit'
require 'css_convertor'

class ConvertorTest < Test::Unit::TestCase
  include CssConvertor::Convertor

  # get_actual_value(value)
  def test_must_get_value_without_additions
    assert_equal '3px 5px 3px 10px', get_actual_value('3px 5px 3px 10px !important')
    assert_equal 'rgba(255,0,0)', get_actual_value('rgba(255,0,0) \0/')
    assert_equal '#fff #000 #fff #000', get_actual_value('#fff #000 #fff #000\9')
  end
  # split_property_value(value)
  def test_must_split_hex_values
    assert_equal ['#eeeeee', '#fff'], split_property_value('#eeeeee #fff')
    assert_equal ['#fff','#000','#fff','#000'], split_property_value('#fff #000 #fff #000')
  end
  def test_must_split_rgba_values
    assert_equal ['rgb(0, 0, 0)','rgba(0, 0, 0, 0.15)'], split_property_value('rgb(0, 0, 0) rgba(0, 0, 0, 0.15)')
    assert_equal ['rgba(0, 0, 0, 0.15)','rgb(0, 0, 0)','rgba(0, 0, 0, 0.15)','rgb(0, 0, 0)'], split_property_value('rgba(0, 0, 0, 0.15)rgb(0, 0, 0)rgba(0, 0, 0, 0.15)rgb(0, 0, 0)')
  end
  def test_must_split_hlsa_values
    assert_equal ['hsl(10%, 40%, 20%)'], split_property_value('hsl(10%, 40%, 20%)')
    assert_equal ['hsl(10%, 40%, 20%)','hsla(10%, 40%, 20%,0)', 'hsla(10%, 40%, 20%,0)'], split_property_value('hsl(10%, 40%, 20%) hsla(10%, 40%, 20%,0) hsla(10%, 40%, 20%,0)')
  end
  def test_must_split_length_values
    assert_equal ['10px', '20%', '1.3em'], split_property_value('10px 20% 1.3em')
  end
  def test_must_split_word_values
    assert_equal ['right'], split_property_value('right')
    assert_equal ['red','blue','green','yellow'], split_property_value('red blue green yellow')
  end
  def test_must_split_mixed_values
    assert_equal ['#ffff','rgba(0,0,0,0)','red','hsl(10%,10%,10%)'], split_property_value('#ffff rgba(0,0,0,0) red hsl(10%,10%,10%)')
  end
  # new_value(type, value)
  def test_must_get_correct_new_value_with_quad
    assert_equal '1px 2px 3px', new_value(:quad,'1px 2px 3px')
    assert_equal '1px 4px 3px 2px', new_value(:quad,'1px 2px 3px 4px')
    assert_equal '1px 4px 3px 2px !important', new_value(:quad,'1px 2px 3px 4px !important')
  end
  def test_must_get_correct_new_value_with_quad_radius
    assert_equal '10% 20%', new_value(:quad_radius,'10% 20%')
    assert_equal '10% 20% 3.3em 10px', new_value(:quad_radius,'20% 10% 10px 3.3em')
    assert_equal '10% 20% 3.3em 10px\9', new_value(:quad_radius,'20% 10% 10px 3.3em\9')
  end
  def test_must_get_correct_new_value_with_direction
    assert_equal 'left', new_value(:direction,'right')
    assert_equal 'rtl !important', new_value(:direction,'ltr !important')
  end
  # value(property_name, property_value)
  def test_must_get_correct_value
    assert_equal 'justify', value('text-align','justify')
    assert_equal '10px 30px 10px', value('margin','10px 30px 10px')
    assert_equal 'right', value('float','left')
    assert_equal '10px 25.5% 3.0em 20% !important', value('padding','10px 20% 3.0em 25.5% !important')
  end
  # property(property_name)
  def test_must_get_correct_property_name
    assert_equal 'margin', property('margin')
    assert_equal 'margin-right', property('margin-left')
  end
  # scan_and_replace(str)
  def test_must_scan_and_replace_correctly_or_else!
    assert_equal 'p {margin-left: 10px;float: right}', scan_and_replace('p {margin-right: 10px;float: left}')
  end
end