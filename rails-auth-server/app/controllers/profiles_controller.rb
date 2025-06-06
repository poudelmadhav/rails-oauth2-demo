class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def me
    @user = current_user
  end
end
