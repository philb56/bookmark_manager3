require 'dm-migrations'
require 'data_mapper'
require 'dm-postgres-adapter'

require './app/data_mapper_setup.rb'

class Tag

  include DataMapper::Resource

  property :id, Serial
  property :name, String

  # has n, :bookmarks, :through => Resource

end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
