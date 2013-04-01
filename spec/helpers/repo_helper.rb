module Helper
  class << self  
    def create_repo(user_id, location)
      Repo.new.tap do |repo|
        repo.user_id  = user_id
        repo.location = location
        repo.save
      end
    end

    def clean_repos
      Repo.all.destroy
    end
  end
end