# frozen_string_literal: true

class ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  alias :authenticate_user! :authenticate_api_user!
  alias :current_user :current_api_user
end
