require 'label'
require 'date'

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


class EisaiSet
  DEFAULTS = {:per_page => 200,               # number of labels per page.
              :page_break => "\n",  # code for page break.
              :input_delimeter => '\+',
              :format => 0
             }.freeze
  
  TUBES = {
    "Plasma" => 1,
    "W1AT" => 4,
    "W2AT" => 4,
    "W3AT" => 4,
    "W4AT" => 4,
    "W5AT" => 4,
    "W6AT" => 4,
  }
  def initialize(label_input,options = {})
    @labels = []
    @options = DEFAULTS.dup.merge options
    @valids = []
    @now = DateTime.now.new_offset(0).strftime("%Y%m%d")
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
  
  def raw_input
    @labels.map{|l| l.text}.join("\n#{@options[:input_delimeter].gsub(/\\/,'')}\n").squeeze("\n")
  end

  private
  
  #
  # Does the work of translating the input text into laabel objects
  #
  def append_input(input)
    input.each do |sid|
      TUBES.keys.sort.each do |tid|
        TUBES[tid].times do |c|
          suffix = if TUBES[tid] > 1
                     "#{c+1}"
                   else
                     ""
                   end
          label_part = "#{sid}-#{tid}#{suffix}\n#{@now}"
          @labels << Label.new(label_part,@options[:format])
        end
      end
    end
  end
end
