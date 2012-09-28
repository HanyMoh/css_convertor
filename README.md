# CssConvertor

Flips the layout of your CSS file. You can use it if you're designing a website that supports both LTR and RTL languages: CssConvertor will create a seperate CSS file of the new layout. 
It was originally based on https://github.com/ded/R2

## Explained

CssConvertor reads your CSS file, and when it finds something like this:

```css
p {
  margin-right: 2px;
  padding: 1px 2px 3px 4px;
  left: 5px;
}
#container {
  float:right;
  text-align: right;
}
```

It will change it to:

```css
p {
  margin-left: 2px;
  padding: 1px 4px 3px 2px;
  right: 5px;
}
#container {
  float:left;
  text-align: left;
}
```

## Installation

Add this line to your application's Gemfile:

    gem "css_convertor"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install css_convertor

## Usage

```
$ css_convertor file.css
```
And if you didn't have this, add it to your CSS file
```css
body {
  direction: rtl;
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
