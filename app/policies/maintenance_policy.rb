class MaintenancePolicy

  attr_accessor :car, :user

  def initialize(car, user)
    @car = car
    @user = user
  end

  def authorized?
    return true if @user.admin?
    return true if @user.manager? && @user.subsidiary == @car.subsidiary
    false
  end

end
