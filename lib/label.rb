# Basic wrapper to take text & show format for the label printer
class Label
  DEFAULT_SIZE = 20
  
  attr_reader :text
  attr_reader :size
  
  def initialize(text, size = DEFAULT_SIZE)
    @text = text
    @size = size
  end
end