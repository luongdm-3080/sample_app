class FollowingsController < ApplicationController
  def index
    @user = User.find_by id: params[:id]
    @title = t ".title"
    @pagy, @users = pagy @user.following
    render "users/show_follow"
  end
end
