class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Bookmark.all
    erb :links
  end

  get '/links/new' do
    erb :new
  end

  post '/links' do
    bookmark = Bookmark.first_or_create(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      bookmark.tags << Tag.first_or_create(name: tag)
    end
    bookmark.save
    redirect '/links'
  end

end
