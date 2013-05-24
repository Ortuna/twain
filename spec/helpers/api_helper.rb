module Helper
  class << self

    def tmp_prefix
      "#{Padrino.root}/tmp/repos"
    end

    def clear_all
      clean_repos
      clean_users
    end

    def setup_api(git_path, username = 'apiuser')
      clear_all   
      create_user(username)
      Mori::API.new(git: git_path,
                  prefix: tmp_prefix,
                  user: User.new)
    end

    def parse_json(json)
      MultiJson.load(json)
    end

    def api_prefix
      '/api/v1/books'
    end
    
  end
end
