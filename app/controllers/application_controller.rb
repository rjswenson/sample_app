class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper  #includes SessionHelper module in all controllers
end


#REMINDER: All helpers are available in views but not in controllers