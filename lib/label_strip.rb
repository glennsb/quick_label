require 'label'

class Array
  def / len
    a = []
    each_with_index do |x,i|
      a << [] if i % len == 0
      a.last << x
    end
    a
  end
end


class LabelStrip
  DEFAULTS = {:per_page => 7,               # number of labels per page.
              :page_break => "\n\n\n\n",  # code for page break.
              :input_delimeter => '\+',
              :format => 20
             }.freeze
  
  def initialize(label_input,options = {})
    @labels = []
    @options = DEFAULTS.dup.merge options
    @valids = []
    append_input(label_input)
  end

  def <<(input)
    append_input(input)
  end

  def valid?
    self.to_s
    return ! @valids.include?(false)
  end
  
  def errors
    return [] if valid?
    errors = []
    @valids.each_with_index do |validation,label_index|
      next if validation
      errors << {:index => label_index, :errors => @labels[label_index].errors}
    end
    return errors
  end
  
  # output all label string versions of objects according to options.
  def to_s
    @valids = []
    label_str = []
    (@labels/@options[:per_page]).each_with_index do |hunk,offset|
      hunk.each_with_index do |label,index|
        @valids << label.valid?
        label_str << label.formatted_label
      end
      label_str << @options[:page_break] if 0 == label_str.size % @options[:per_page]
    end
    label_str.join("\n")
  end

  private
  
  #
  # Does the work of translating the input text into laabel objects
  #
  def append_input(input)
    input.split(/\n#{@options[:input_delimeter]}\n/).each do |label_part|
      @labels << Label.new(label_part,@options[:format])
    end
  end
end