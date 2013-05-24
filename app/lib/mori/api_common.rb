module Mori::Common

  def create_api(repo_location)
    tmp_prefix = "#{Padrino.root}/tmp/repos"
    Mori::API.new(git: repo_location, prefix: tmp_prefix)
  end

  def parse_json(json)
    return json unless json.kind_of? String
    MultiJson::load(json)
  end

  def not_found
    halt 404
  end

  def invalid_entity
    halt 422
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
end #module
