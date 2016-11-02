require 'date'
class MakersBnb < Sinatra::Base
  get '/spaces' do
    @properties = Property.all
    erb :'spaces/index'
  end

  post '/spaces' do
    if params[:start_date] > params[:end_date]
      flash.now[:errors] = "Please enter valid dates."
      erb :'spaces/new'
    else
      property = Property.create(name: params[:name],
      location: params[:location],
      description: params[:description],
      price: params[:price], user_id: current_user.id)

      if property.save
        (Date.parse(params[:start_date])..Date.parse(params[:end_date])).map(&:to_s).each do |day|
          property.days << Day.first_or_create(date: day)
        end
        property.save
        redirect '/spaces'
      else
        flash.now[:errors] = property.errors.full_messages
        erb :'spaces/new'
      end
    end
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end
end