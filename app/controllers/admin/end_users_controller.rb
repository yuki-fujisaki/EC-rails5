class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def index
    @end_users = EndUser.all
  end

  def show
  end

  def edit
  end
end
