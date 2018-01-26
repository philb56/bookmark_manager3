
require 'database_cleaner'

require './app/models/bookmark.rb'
require './app/models/tag.rb'

  get '/' do
    "Hello"
  end

  run! if app_file == $0

end
