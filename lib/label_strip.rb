require 'label'

class LabelStrip
  DEFAULTS = {:per_page => 7,               # number of labels per page.
              :page_break => "\n\n\n\n\n",  # code for page break.
              :input_delimeter => '+'
             }.freeze
  
  def initialize(label_input,options = {})
    append_input(label_input)
    @options = DEFAULTS.dup.merge options
  end

  def <<(input)
    append_input(input)
  end

  private
  
  #
  # Does the work of translating the input text into laabel objects
  #
  def append_input(input)
    
  end
  
  # # output all label string versions of objects according to options.
  # def to_s
  #   labels = []
  #   in_groups_of options[:per_page] do |objects|
  #     labels << objects.compact.map do |obj|
  #       obj.to_label + options[:delimiter]
  #     end.join
  #   end
  #   labels.join options[:page_break]
  # end
end