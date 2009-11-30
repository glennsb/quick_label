require 'rubygems'
require 'sinatra'

require 'label_strip'

require 'tempfile'

get "/barcode_label*" do
  # @strip = LabelStrip.new("")
  erb :new
end

post "/barcode_label*" do
  @strip = LabelStrip.new(params[:labels].gsub(/\r/,"\n"))
  @copies = params[:copies].to_i
  if nil == @copies || @copies <= 0 || @copies > 100 then
    @copies = 1
  end
  case params[:submit]
    when /validate/
      erb :new
    when /print/
      child = fork do
        if @strip && @strip.valid?
          print(@strip.to_s,@copies)
        end
      end
      Process.detach(child)
      erb :new
  end
end

def print(text,copies=1)
  file = Tempfile.new("quick-label")
  copies.times do
    file.puts(text)
  end
  file.flush
  file.close
  cmd = "/usr/bin/lpr #{file.path}"
  system cmd
  file.delete
end