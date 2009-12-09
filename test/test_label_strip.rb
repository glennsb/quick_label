require "test/unit"

require "label_strip"

class TestLabelStrip < Test::Unit::TestCase
  DEFAULT_OPTS =
  {
    :text => "a\n+\nb",
  }
  
  ACTUAL = "_/0M_/14M_/20F_/3A_/16,2,1,2/_/3ta_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3tb_/0t
-*-"

ELEVEN = ACTUAL + "
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t3_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t4_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t5_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t6_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t7_/0t
-*-





_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t8_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t9_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t10_/0t
-*-
_/0M_/14M_/20F_/3A_/16,2,1,2/_/3t11_/0t
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