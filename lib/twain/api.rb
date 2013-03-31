module Twain
  class API
    attr_reader :git_location, :options, :book, :user

    def initialize(opts = {})
      @options      = defaults.merge(opts)
      @git_location = options[:git] || nil
      @username     = options[:username] || nil
      @password     = options[:password] || nil
      @book         = ::Book

      authenticate!
      setup_datamapper
    end

    def authenticate!(username = @username, password = @password)
      @user = User.authenticate(username, password)
      raise 'Could not authenticate' if !@user || !@user.username
    end

    def clean!
      FileUtils.rm_rf local_path if File.exists? local_path
    end

    def local_path
      digest = Digest::MD5.hexdigest(git_location)
      File.expand_path("#{@options[:prefix]}/#{digest}")
    end

    private
    def setup_datamapper
      DataMapper.setup(:gitfs, "gitfs:://#{local_path}?#{git_location}")
      railse 'Error creating repo' unless File.exists?(local_path)
    end

    def defaults
      { 
        :prefix => '/tmp'
      }
    end

  end #API
end #Twain