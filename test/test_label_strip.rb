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

ELEVEN = ACTUAL + "
_/3A_/20F
 3
-*-
_/3A_/20F
 4
-*-
_/3A_/20F
 5
-*-
_/3A_/20F
 6
-*-
_/3A_/20F
 7
-*-





_/3A_/20F
 8
-*-
_/3A_/20F
 9
-*-
_/3A_/20F
 10
-*-
_/3A_/20F
 11
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
  
  def test_should_split_at_seven_per_page
    assert_not_nil(@s)
    %w/3 4 5 6 7 8 9 10 11/.each do |a|
      @s << a
    end
    assert_equal(@s.to_s, ELEVEN)
  end
  
  def test_should_report_validations
    assert(@s.valid?, "Was not valid")
  end
  
  def test_should_be_invalid_with_single_invalid
    @s << "a"*50
    assert(!@s.valid?, "Was valid")
  end
  
  def test_should_report_errrors
    @s << "a" * 50
    errors = @s.errors
    assert_not_nil(errors)
    assert(!errors.empty?, "There were no errors")
    assert_equal(1, errors.size)
    assert_equal(2, errors.first[:index])
  end
  
  private
  
  def create(opts = DEFAULT_OPTS)
    opts = DEFAULT_OPTS.merge(opts)
    LabelStrip.new(opts[:text])
  end
  
end