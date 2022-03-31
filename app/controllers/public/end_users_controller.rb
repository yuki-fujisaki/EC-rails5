class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:top]

  def top
  end

  def mypage
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def confirm
  end

  def withdraw
    @end_user = EndUser.find_by(params[:id])
    @end_user.update(is_unsubscribed: true)
    reset_session
    redirect_to root_path
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(user_params)
      redirect_to end_users_mypage_path(@end_user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:end_user).permit(:first_name)
  end
end
