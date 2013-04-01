module Helper
  class << self  
    def create_user(username, password)
      User.new.tap do |user|
        user.username = username
        user.password = password
        user.save
      end
    end

    def clean_users
      User.all.destroy
    end
  end
end