module Helper
  class << self

    def tmp_prefix
      "#{Padrino.root}/tmp/repos"
    end

    def clear_all
      clean_repos
      clean_users
    end

    def setup_api(git_path, username = 'apiuser', password = 'password')
      clear_all   
      create_user(username, password)
      Twain::API.new(git: git_path,
                  prefix: tmp_prefix,
                username: username,
                password: password)
    end

    def parse_json(json)
      MultiJson.load(json)
    end
  end
end