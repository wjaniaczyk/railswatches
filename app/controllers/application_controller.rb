class ApplicationController < ActionController::Base
    include Pundit::Authorization
    protect_from_forgery with: :null_session

end
