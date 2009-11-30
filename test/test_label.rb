require "test/unit"

require "label"

class TestLabel < Test::Unit::TestCase

  TEST_LABEL = "_/3A_/16,2,1,1/_/2tabcdefghijklm_/0t
-*-"

  DEFAULT_OPTS =
  {
    :text => "abcdefghijklm",
    :size => 0
  }

  def setup
    @l = create()
  end

  def test_should_initialize_with_text_and_size
    assert_not_nil(@l)
  end
  
  def test_should_default_size
    l = Label.new(DEFAULT_OPTS[:text])
    assert_not_nil(l)
    assert_equal(l.size, Label::DEFAULT_SIZE)
  end
  
  def test_should_be_valid_with_short_text_and_proper_size
    assert(@l.valid?, "The default label is not valid!")
  end
  
  def test_should_not_be_valid_on_bad_size
    l = create(:size => -1)
    assert_not_nil(l)
    assert(!l.valid?)
    assert(l.errors[:format], "No error on format")
  end
  
  def test_should_not_be_valid_with_too_many_lines
    text = ("this is a line\n"*10).chomp
    l = create(:text => text)
    assert_not_nil(l)
    assert(!l.valid?)
    assert(l.errors[:text], "No error on size")
  end
  
  def test_should_not_be_valid_on_too_many_columns
    text = ("#{"a"*52}\n"*5).chomp
    l = create(:text => text)
    assert_not_nil(l)
    assert(!l.valid?,'The label should be invalid since it has too many columns')
    assert(l.errors[:text], "No error on size")    
  end
  
  def test_should_produce_label_when_valid
    assert_equal(@l.formatted_label, TEST_LABEL)
  end
  
  private
  def create(opts = DEFAULT_OPTS)
    opts = DEFAULT_OPTS.merge(opts)
    Label.new(opts[:text], opts[:size])
  end
  
end