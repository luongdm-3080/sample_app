class UsersController < ApplicationController
  before_action :find_by_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(create new)
  before_action :user_correct, only: %i(edit update)
  before_action :can_is_admin?, only: :destroy

  def index
    @pagy, @users = pagy User.sort_name
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".success_message"
      redirect_to @user
    else
      flash.now[:danger] = t ".failure_message"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".edit_success_message"
      redirect_to @user
    else
      flash.now[:danger] = t ".edit_failure_message"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted_message"
    else
      flash[:danger] = t ".delete_failed_message"
    end

    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def find_by_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".not_logged"
    store_location
    redirect_to login_url
  end

  def user_correct
    return if current_user? @user

    danger_message
  end

  def can_is_admin?
    return if current_user.admin?

    danger_message
  end

  def danger_message
    flash[:danger] = t ".unauthorization"
    redirect_to root_url
  end
end
