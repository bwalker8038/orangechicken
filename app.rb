require 'compass'
require 'sinatra'
require 'haml'
#require 'datamapper'


# connect to database
#DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')

configure do
    set :haml, :format => :html5
    Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

#class Contact
#    include DataMapper::Resource
#    property :id,    Serial
#    property :name,  String
#    property :email, String
#    property :disc,  Text
#end


# views
get '/css/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"css/#{params[:name]}", Compass.sass_engine_options)
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

get '/contact/successful' do
    haml :success
end
