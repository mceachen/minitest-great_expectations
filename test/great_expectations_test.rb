require 'minitest_helper'

describe "assert_equal_contents" do
  it "passes for same order" do
    a = [1, 2, 3]
    b = a.dup
    assert_equal_contents(a, b)
  end
  it "passes for different order" do
    a = [1, 2, 3]
    b = a.shuffle
    assert_equal_contents(a, b)
  end
  it "complains about missing actual" do
    l = lambda { assert_equal_contents([1, 2, 3], [1, 2]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /missing expected.*\[3\]/im
  end
  it "complains about extra actual" do
    l = lambda { assert_equal_contents([1, 2], [1, 2, 3]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /extraneous actual.*\[3\]/im
  end
end

describe "must_equal_contents" do
  it "passes for same order" do
    a = [1, 2, 3]
    b = a.dup
    a.must_equal_contents b
  end
  it "passes for different order" do
    a = [1, 2, 3]
    b = a.shuffle
    a.must_equal_contents b
  end
  it "complains about missing actual" do
    l = lambda { assert_equal_contents([1, 2, 3], [1, 2]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /missing expected.*\[3\]/im
  end
  it "complains about extra actual" do
    l = lambda { assert_equal_contents([1, 2], [1, 2, 3]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /extraneous actual.*\[3\]/im
  end
end

describe "assert_includes_all" do
  it "passes on empty expected" do
    assert_includes_all([], [])
    assert_includes_all([], [1, 2, 3])
  end
  it "passes on non-empty exptected" do
    assert_includes_all([1, 2], [1, 2, 3])
  end
  it "fails with missing expected" do
    l = lambda { assert_includes_all([1, 2, 3], [1, 2]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /missing expected.*\[3\]/im
  end
end

describe "must_include_all" do
  it "passes on empty expected" do
    [].must_include_all []
    [1, 2, 3].must_include_all []
  end
  it "passes on non-empty exptected" do
    [1, 2, 3].must_include_all [1, 2]
  end
  it "fails with missing expected" do
    l = lambda { [1, 2].must_include_all [1, 2, 3] }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /missing expected.*\[3\]/im
  end
end

describe "assert_includes_none" do
  it "passes on empty expected" do
    assert_includes_none([], [])
    assert_includes_none([], [1, 2, 3])
  end
  it "passes on empty actual" do
    assert_includes_none([1, 2, 3], [])
  end
  it "passes on non-empty exptected" do
    assert_includes_none([1, 2], [3, 4])
  end
  it "fails with expected" do
    l = lambda { assert_includes_none([3, 2], [1, 2, 3]) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /unexpected elements.*\[2\, 3\]/im
  end
end

describe "wont_include_any" do
  it "passes on empty expected" do
    [].wont_include_any []
    [].wont_include_any [1, 2, 3]
  end
  it "passes on empty actual" do
    [1, 2, 3].wont_include_any []
  end
  it "passes on non-empty exptected" do
    [1, 2].wont_include_any [3, 4]
  end
  it "fails with expected" do
    l = lambda { [3, 2].wont_include_any [1, 2, 3] }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /unexpected elements.*\[2\, 3\]/im
  end
end


describe "assert_true" do
  it "passes for true" do
    assert_true(true)
  end
  it "fails for truthy" do
    l = lambda { assert_true(1) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /<true> expected/im
  end
end

describe "must_be_true" do
  it "passes for true" do
    true.must_be_true # < certainly my proudest coding moment
  end
  it "fails for truthy" do
    l = lambda { 1.must_be_true }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /<true> expected/im
  end
end

describe "assert_truthy" do
  it "passes for truthy" do
    assert_truthy(true)
    assert_truthy(1)
    assert_truthy("")
  end

  def assert_not_truthy(value)
    l = lambda { assert_truthy(value) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /Expected truthy/im
  end

  it "fails properly for falsy values" do
    assert_not_truthy(false)
    assert_not_truthy(nil)
  end
end

describe "must_be_truthy" do
  it "passes for truthy" do
    true.must_be_truthy
    1.must_be_truthy
    "".must_be_truthy
  end

  def assert_not_truthy(value)
    l = lambda { assert_truthy(value) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /Expected truthy/im
  end

  it "fails properly for falsy values" do
    assert_not_truthy(false)
    assert_not_truthy(nil)
  end
end

describe "assert_false" do
  it "passes for false" do
    assert_false(false)
  end
  it "fails for falsy" do
    l = lambda { assert_false(nil) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /<false> expected/im
  end
end

describe "must_be_false" do
  it "passes for false" do
    false.must_be_false
  end
  it "fails for falsy" do
    l = lambda { nil.must_be_false }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /<false> expected/im
  end
end

describe "assert_falsy" do
  it "passes for falsy" do
    assert_falsy(false)
    assert_falsy(nil)
  end

  def assert_not_falsy(value)
    l = lambda { assert_falsy(value) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /Expected falsy/im
  end

  it "fails properly for falsy values" do
    assert_not_falsy(true)
    assert_not_falsy(1)
    assert_not_falsy("")
  end
end

describe "must_be_falsy" do
  it "passes for falsy" do
    false.must_be_falsy
    nil.must_be_falsy
  end

  def assert_not_falsy(value)
    l = lambda { assert_falsy(value) }
    error = assert_raises(MiniTest::Assertion, &l)
    error.message.must_match /Expected falsy/im
  end

  it "fails properly for falsy values" do
    assert_not_falsy(true)
    assert_not_falsy(1)
    assert_not_falsy("")
  end
end