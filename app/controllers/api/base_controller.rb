class Twain::App

  def find_repo(book_id)
    Repo.first(:id => book_id.to_i) || halt(404)
  end

  def create_api(repo_location, user)
    Twain::API.new(git: repo_location, prefix: '/tmp', user: user)
  end

  def parse_json(json)
    MultiJson::load(json)
  end

  def check_login
    halt(403, 'login required') unless session[:user]
  end

  def update_attributes(model, attributes)
    model.attributes.each do |attribute, value|
      key = attribute.to_s
      next unless attributes[key]
      current_value = model.send(attribute)
      if current_value != attributes[key]
        model.send("#{attribute}=", attributes[key]) 
      end #if 
    end #each
  end #def  
end