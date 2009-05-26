require "test/unit"

require "label_strip"

class TestLabelStrip < Test::Unit::TestCase
  DEFAULT_OPTS =
  {
    :text => "This is a test label\nIt has two lines\n+\nThis is a second lable\nwith two lines two",
  }
  
  ACTUAL = "_/3A_/20F
 This is a test label
 It has two lines
-*-
_/3A_/20F
 This is a second 
 lable
 with two lines two
-*-"

  def setup
    @s = create
  end

  def test_should_accept_text
    assert_not_nil(@s)
  end
  
  def test_should_produce_labels_string
    assert_not_nil(@s)
    assert_equal(@s.to_s, ACTUAL)
  end
  
  private
  
  def create(opts = DEFAULT_OPTS)
    opts = DEFAULT_OPTS.merge(opts)
    LabelStrip.new(opts[:text])
  end
  
end