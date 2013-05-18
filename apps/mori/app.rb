module Mori
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers

    enable :sessions
    set :allow_disabled_csrf, true
    set :protect_from_csrf, false
  end
end
