class Messages
  def login_success
    "logged in successfully"
  end

  def no_user_found
    "user not found"
  end

  def logout_success
    "logged out successfully"
  end

  def account_created
    "account created and logged in"
  end

  def unauthorized_access
    "unauthorized access"
  end

  def invalid_address
    "Invalid address specify a valid endpoint!"
  end

  def no_bucket_found
    "no buckets found"
  end

  def update_message(_list, name)
    "#{name} does not exist"
  end

  def check_user_bucket
    "Not authorized to modify"
  end

  def delete_success_message(_list, name)
    "#{name} destroyed"
  end

  def delete_error_message(_object, name)
    "#{name} was not destroyed"
  end
end
