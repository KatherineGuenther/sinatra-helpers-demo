require 'bundler/setup'

Bundler.require(:default)

# Import .env VARs
begin
  require 'dotenv'
  Dotenv.load(".env.#{ENV['RACK_ENV']}", '.env')
rescue LoadError
  puts 'Skipping Dotenv load since dotenv is not available'
end

# Prepend Load Path
$LOAD_PATH.unshift(File.expand_path('.'))

# [deprecated] I18n.enforce_available_locales will default to true in the future
# If you really want to skip validation of your locale you can
# set I18n.enforce_available_locales = false to avoid this message.
I18n.enforce_available_locales = true

set :database, ENV['DATABASE_URL']
enable :sessions

# Load All the ruby files in helpers and models
%w(models helpers).each do |directory_to_preload|
  Dir["#{directory_to_preload}/*.rb"].each do |file_to_load|
    p "Loading #{file_to_load}"
    require file_to_load
  end
end

get '/' do
  @sentance = 'The quick brown fox jumped over the lazy dog'
  erb :sentance
end

post '/login' do
  user = User.authenticate(params['username'], params['password'])
  set_current_user user unless user.nil?
  redirect '/'
end

get '/login' do
  redirect '/'
end

get '/logout' do
  session.delete :user_id
  redirect '/'
end
