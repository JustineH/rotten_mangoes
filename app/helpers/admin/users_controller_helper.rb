module Admin::UsersControllerHelper

  def admin?
    @current_user.admin == true
  end

end
