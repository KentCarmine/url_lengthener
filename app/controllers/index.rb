get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/long_url' do
  # Look in app/views/index.erb
  # begin
    @url = Url.new(:long_url => params[:url])
    was_saved = @url.save
    puts "SAVED: " + was_saved.to_s
    unless was_saved
      puts "REDIRECTING TO INVALID URL"
        redirect to "/invalid_url"
    else
      puts "SHOULD NOT BE HERE!"
      lenthened_url = @url.longer_url
      redirect to "/longer_url/#{lenthened_url}"
    end
  # rescue Exception => e
  #   @error = e
  #   redirect to "/invalid_url"
  # end

end

get '/longer_url/:longer_url' do
  # Look in app/views/index.erb
  @lenthened_url = params[:longer_url]

  erb :show_longer_url
end

get '/invalid_url' do
  erb :invalid_url
end

get '/:longer_url' do
  url = Url.where("longer_url = ?", params[:longer_url]).first
  # p Url.all
  url.increment_click_count
  real_url = url.long_url
  redirect to real_url
end

