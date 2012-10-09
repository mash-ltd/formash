module ForMash
  class ApplicationController < ActionController::Base
    unless method_defined? :current_entity
      def current_entity
        raise '`current_entity` method has to be overriden to return an object representing an app user.'
      end
    end
    helper_method :current_entity

    unless method_defined? :current_user
      def current_user
        raise '`current_user` method has to be overriden to return the current user'
      end
    end
    helper_method :current_user

    unless method_defined? :authenticate_entity!
      def authenticate_entity!
        raise '`authenticate_entity!` method has to be overriden to return whether the current entity is authenticated or not.'
      end
    end
  end
end
