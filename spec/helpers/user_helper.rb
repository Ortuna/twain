module Helper
  class << self  
    def create_user(username)
      User.new.tap do |user|
        user[:uid]      = username
        user[:name]     = username
        user[:provider] = 'testprovider'
        user.save
      end
    end

    def clean_users
      User.all.destroy
    end
  end
end
