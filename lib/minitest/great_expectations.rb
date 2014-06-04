require 'minitest/autorun'
require 'minitest/great_expectations/version'

module MiniTest::Assertions

  # Contents must be the same, but order doesn't matter.
  # (In rspec, this is ```.should =~```)
  def assert_equal_contents(expected, actual, message = nil)
    e_ary = expected.to_a
    a_ary = actual.to_a
    error_msgs = []
    missing_from_actual = e_ary - a_ary
    unless missing_from_actual.empty?
      error_msgs << "Missing expected elements:\n #{mu_pp missing_from_actual}"
    end
    missing_from_expected = a_ary - e_ary
    unless missing_from_expected.empty?
      error_msgs << "Extraneous actual elements:\n  #{mu_pp missing_from_expected}"
    end
    unless error_msgs.empty?
      message ||= "Expected:\n  #{mu_pp expected}\nDid not match contents of Actual:\n  #{mu_pp actual}."
      flunk("#{message}\n#{error_msgs.join("\n")}")
    end
  end

  # Hash keys and values must be the same
  def assert_equal_hash(expected, actual, message = nil)
    e_keys = expected.keys
    a_keys = actual.keys
    error_msgs = []
    missing_from_actual = e_keys - a_keys
    unless missing_from_actual.empty?
      error_msgs << "Missing expected keys:\n #{mu_pp missing_from_actual}"
    end
    missing_from_expected = a_keys - e_keys
    unless missing_from_expected.empty?
      error_msgs << "Extraneous actual keys:\n  #{mu_pp missing_from_expected}"
    end
    intersecting_keys = e_keys & a_keys
    intersecting_keys.each do |ea|
      exp = expected[ea]
      act = actual[ea]
      unless exp == act
        error_msgs << "Expected [#{mu_pp ea}]: #{mu_pp exp}\nActual [#{mu_pp ea}]: #{mu_pp act}"
      end
    end
    unless error_msgs.empty?
      message ||= "Expected:\n  #{mu_pp expected}\ndid not equal Actual:\n  #{mu_pp actual}."
      flunk("#{message}\n#{error_msgs.join("\n")}")
    end
  end

  # Every element in actual must be in expected, but expected may have additional elements.
  def assert_includes_all(expected, actual, message = nil)
    missing_from_expected = expected.to_a - actual.to_a
    unless missing_from_expected.empty?
      message ||= "Expected:\n  #{mu_pp expected}\ndid not contain every element in Actual:\n  #{mu_pp actual}."
      flunk("#{message}\nMissing expected elements:\n  #{mu_pp missing_from_expected}")
    end
  end

  def assert_includes_none(expected, actual, message = nil)
    unexpected = expected.to_a & actual.to_a
    unless unexpected.empty?
      message ||= "Expected:\n  #{mu_pp expected}\ncontained elements in Actual:\n  #{mu_pp actual}."
      flunk("#{message}\nUnexpected elements:\n  #{mu_pp unexpected.sort}")
    end
  end

  # The first parameter must be ```true```, not coercible to true.
  def assert_true(obj, msg = nil)
    msg = message(msg) { "<true> expected but was #{mu_pp obj}" }
    assert obj == true, msg
  end

  def assert_truthy(obj, msg = nil)
    msg = message(msg) { "Expected truthy, but was #{mu_pp obj}" }
    assert obj, msg
  end

  # The first parameter must be ```false```, not just coercible to false.
  def assert_false(obj, msg = nil)
    msg = message(msg) { "<false> expected but was #{mu_pp obj}" }
    assert obj == false, msg
  end

  def assert_falsy(obj, msg = nil)
    msg = message(msg) { "Expected falsy but was #{mu_pp obj}" }
    assert !obj, msg
  end
end

module MiniTest::Expectations
  infect_an_assertion :assert_equal_contents, :must_equal_contents
  infect_an_assertion :assert_equal_hash, :must_equal_hash
  infect_an_assertion :assert_includes_all, :must_include_all
  infect_an_assertion :assert_includes_none, :wont_include_any
  infect_an_assertion :assert_true, :must_be_true, :unary
  infect_an_assertion :assert_truthy, :must_be_truthy, :unary
  infect_an_assertion :assert_false, :must_be_false, :unary
  infect_an_assertion :assert_falsy, :must_be_falsy, :unary
end

