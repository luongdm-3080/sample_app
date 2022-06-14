class FollowersController < ApplicationController
  def index
    @user = User.find_by id: params[:id]
    @title = t ".title"
    @pagy, @users = pagy @user.followers
    render "users/show_follow"
  end
end
