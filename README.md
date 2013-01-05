# Minitest::GreatExpectations [![Build Status](https://api.travis-ci.org/mceachen/minitest-great_expectations.png?branch=master)](https://travis-ci.org/mceachen/minitest-great_expectations)

Adds several generally helpful assertions to [minitest](http://docs.seattlerb.org/minitest/) and minitest-spec that you might be used to
having, especially if you're coming from rspec:

``` ruby
[1, 2, 3].must_equal_contents [3, 2, 1]
[1, 2, 3].must_include_all [1, 2]
something.works?.should_be_true
```

These may make it into minitest proper, someday.

## Installation

Add this line to your application's Gemfile (in your "test" gem group, if you have one):

``` ruby
gem 'minitest-great_expectations'
```

Add this to your ```minitest_helper.rb```:

``` ruby
require 'minitest/great_expectations'
```

And then execute:

    $ bundle

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

### 0.0.3

* Added ```assert_includes_none```/```wont_include_any```

### 0.0.2

* Added proper require, and moved into correct subdirectories

### 0.0.1

* First whack
