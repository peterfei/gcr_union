class Api::Location < ActiveResource::Base
  self.site = "http://172.16.100.105:3002/api/"
  #self.site = "http://localhost:3000/"

  def self.search(query={},page=1)
    find(:all, params: {search: query, page: page})
  end
end