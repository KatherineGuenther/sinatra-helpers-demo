# Just an Example this sample doesn't have a User database
helpers do

  def set_current_user user
    @user = user
    session[:user_id] = @user.id
  end   

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticated?
    !current_user.nil?
  end

  def username
    current_user.username if authenticated?
  end
end
