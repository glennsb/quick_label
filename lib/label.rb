# Basic wrapper to take text & show format for the label printer
class Label
  DEFAULT_SIZE = 0
  
  HEADER = "_/3A_/18M_/16,2,2,1/_/2t"
  
  SPACER = "       "
  
  FOOTER = "-*-"
  
  LABEL_FORMATS = 
  {
    0 => {
      :rows => 8,
      :cols => 22,
      :font_size => 18
    }
  }
  
  attr_reader :text
  attr_reader :size
  attr_reader :errors
  
  def initialize(text, size = DEFAULT_SIZE)
    @text = text.chomp
    @size = size.to_i
    @errors = {}
  end
  
  #
  # Test to see if the label is valid, which is to say will it fit
  #
  def valid?()
    @errors = {}
    return validate_format && map_text_for_output && validate_output_text
  end #valid?
  
  #
  # Get the string formatted such that it can be sent to the barcode printer
  # if the input is not valid, will return a blank string
  #
  def formatted_label
    return "" unless self.valid?
    
    str = "#{HEADER}"
    @output.each_with_index do |line,index|
      if 0 == index
        str += "#{line}_/0t_/18F\n"
      end
      str += "#{SPACER}#{line}\n"
    end
    # str += @output.inject("") {|accum, line| accum += "#{line}_/0t\n"}
    str += "#{FOOTER}"
    return str
  end
  
  private
  
  def validate_format
    unless LABEL_FORMATS.keys.include?(@size)
      @errors[:format]  = "Unknown format style #{@size}"
      return false
    end
    return true
  end
  
  def validate_output_text
    if @errors[:text] then
      return false
    elsif @output.size > LABEL_FORMATS[@size][:rows]
      @errors[:text] = "Unable to fit text into output, too many rows (#{@output.size} more than #{LABEL_FORMATS[@size][:rows]})"
      return false
    end
    return true
  end
  
  #
  # Prepare the text for the output label
  # This might change some word wrap
  #
  def map_text_for_output()
    prep_output_text()
    @text.split(/\n/).each do |line|
      break unless add_line_to_output(line.chomp.squeeze(" "))
    end
    return @errors[:text].nil?
  end #map_text_for_output
  
  def prep_output_text
    @output = []
  end
  
  # given a line of text, append it to the output text, wrap it to the 
  # max column size of current format if possible
  def add_line_to_output(line)
    parts = line.split(/\s/)
    parts.each do |part|
      if part.length > LABEL_FORMATS[@size][:cols] then
        @errors[:text] = "Line to long (#{line} more than #{LABEL_FORMATS[@size][:cols]})"
        return false
      end
    end
    
    parts = line.scan(/.{1,#{LABEL_FORMATS[@size][:cols]}}(?:\s|\Z)/) do |short_line|
      short_line.chomp!
      short_line.squeeze!(" ")
      @output << short_line
      if short_line.length > LABEL_FORMATS[@size][:cols] then
        @errors[:text] = "Line to long (#{short_line} more than #{LABEL_FORMATS[@size][:cols]})"
        return false
      end
    end
    return true
  end
end
