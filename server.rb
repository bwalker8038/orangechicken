require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'

configure do
    set :haml, :format => :html5
    DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')
end

class Contact
    include DataMapper::Resource
    property :id,    Serial
    property :name,  String
    property :email, String
    property :disc,  Text
end

get '/' do
    haml :index
end

get '/contact' do
    haml :contact
end

post '/contact' do
    @contact = Contact.new(:name  => params[:name], 
                           :email => params[:email],
                           :disc  => params[:disc])
    if @contact.save
        status 201
        redirect '/contact/successful'
    else
        status 412
        redirect '/contact'
    end
end

