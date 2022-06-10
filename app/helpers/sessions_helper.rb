module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    user_id ||= session[:user_id] || cookies.signed[:user_id]
    token = cookies[:remember_token]

    @current_user ||= User.find_by id: user_id

    log_in @current_user if @current_user&.authenticated?(:remember, token)

    @current_user
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def current_user? user
    user && user == current_user
  end

  def can_delete_user? user
    current_user.admin? && !current_user?(user)
  end

  def is_admin?
    current_user.admin?
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
