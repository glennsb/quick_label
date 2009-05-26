require 'rubygems'
require 'sinatra'

require 'label_strip'


get "/quick_label" do
  # @strip = LabelStrip.new("")
  erb :new
end

post "/quck_label" do
  @strip = LabelStrip.new(params[:labels].gsub(/\r/,"\n"))
  case params[:submit]
    when /validate/
      erb :new
    when /print/
      content_type('text/plain; charset=utf-8')
      @strip.to_s
  end
end
