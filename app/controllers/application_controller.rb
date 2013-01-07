require 'oauth'

class ApplicationController < ActionController::Base
  protect_from_forgery

  HACKPAD_SERVER = URI.parse(ENV['HACKPAD_SERVER'])
  HACKPAD_CLIENT_ID = ENV['HACKPAD_CLIENT_ID']
  HACKPAD_SECRET = ENV['HACKPAD_SECRET']

  def hackpad
    @@hackpad ||= OAuth::Consumer.new HACKPAD_CLIENT_ID, HACKPAD_SECRET, {
      :site => HACKPAD_SERVER,
    }
  end
end
