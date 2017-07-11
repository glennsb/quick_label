require 'rubygems'
require 'sinatra'

require 'eisai-set'

require 'tempfile'

get "/eisai-label*" do
  erb :new
end

post "/eisai-label*" do
  @strip = EisaiSet.new(params[:ids].split(/\s+/).map(&:strip).reject(&:empty?))
  case params[:submit]
    when /print/
      child = fork do
        if @strip && @strip.valid?
          print(@strip.to_s)
        end
      end
      Process.detach(child)
      erb :new
  end
end

def print(text,copies=1)
  file = Tempfile.new("eisai-label")
  copies.times do
    file.puts(text)
  end
  file.flush
  file.close
  cmd = "/usr/bin/lpr #{file.path}"
  system cmd
  file.delete
end
