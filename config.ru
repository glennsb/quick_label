$: << File.expand_path(File.dirname(FILE) + "lib"))

require 'server'

run Sinatra::Application
