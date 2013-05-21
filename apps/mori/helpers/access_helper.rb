module Padrino
  module Admin
    module AccessHelpers
      def allow_paths(paths)
        access_control.roles_for :any do |role|
          paths.each { |path| role.allow path }
        end
      end

      def protect_paths(paths)
        access_control.roles_for :any do |role|
          paths.each { |path| role.protect path }
        end
      end
    end
  end
end