class WatchPolicy < ApplicationPolicy
    attr_reader :user, :watch

    def initialize(user, watch)
        @user = user
        @watch = watch
    end

    

end