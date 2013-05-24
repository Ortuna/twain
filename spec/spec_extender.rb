module SpecExtender

  def app
    Mori::App.tap { |app|  }
  end
  
  def api_prefix
    Helper.api_prefix
  end

  def setup_api(git_path)
    Helper.setup_api(git_path, User.new)
  end
  
  def get_repo_list
    get_json_from(api_prefix)["books"]
  end

  def get_first_book
    get_json_from("#{api_prefix}/#{get_repo_list.first["id"]}")["book"]
  end

  def get_first_chapter
    get_json_from("#{api_prefix}/#{get_repo_list.first["id"]}/chapters")["chapters"].first
  end

  def get_json_from(url)
    get url
    Helper.parse_json(last_response.body)
  end

  def omniauth_login(opts = {})
    options = {
      'provider'     => 'github', 
      'access_token' => '123', 
      'uid'          => '123545',
      'info' => {
        'name'  => 'test',
        'image' => 'test' 
      }
    }.merge(opts)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = options
    get '/auth/github'
    follow_redirect!
  end


end