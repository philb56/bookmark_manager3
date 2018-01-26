class BookmarkManager < Sinatra::Base

  get '/tags/:name' do
   tag = Tag.first(name: params[:name])
   @links = tag ? tag.bookmarks : []
   erb :'/links'
  end

end
