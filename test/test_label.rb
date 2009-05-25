require "test/unit"

require "label"

class TestLabel < Test::Unit::TestCase

  DEFAULT_OPTS =
  {
    :text => "This is a test label\nIt has two lines",
    :size => 20
  }

  def setup
    @l = create()
  end

  def test_should_initialize_with_text
    assert_not_nil(@l)
  end
  
  private
  def create(opts = DEFAULT_OPTS)
    opts = DEFAULT_OPTS.merge(opts)
    Label.new(opts[:text], opts[:size])
  end
  
end