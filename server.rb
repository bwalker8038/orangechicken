require 'rubygems'
require 'sinatra'
require 'haml'

configure do
  set :haml, :format => :html5
end

get '/' do
  haml :index
end

get '/contact' do
    haml :contact
end
