require 'rubygems'
require 'sinatra'

require 'label_strip'

require 'tempfile'

get "/quick_label*" do
  # @strip = LabelStrip.new("")
  erb :new
end

post "/quick_label*" do
  @strip = LabelStrip.new(params[:labels].gsub(/\r/,"\n"))
  case params[:submit]
    when /validate/
      erb :new
    when /print/
      child = fork do
        if @strip && @strip.valid?
          print(@strip.to_s)
        end
      end
      Process.detach(child)
      erb :new
#      content_type('text/plain; charset=utf-8')
#      @strip.to_s
  end
end

def print(text)
  file = Tempfile.new("quick-label")
  file.puts(text)
  file.flush
  file.close
  cmd = "/usr/bin/lpr #{file.path}"
  system cmd
  file.delete
end