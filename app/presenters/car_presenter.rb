class CarPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  attr_reader :user, :policy

  def initialize(car, user, policy = nil)
    super(car)
    @user = user
    @policy = policy || MaintenancePolicy.new(car, @user)
  end

  def maintenance_link
    return '' if rented? 
    return '' unless policy.authorized?
    if available?
      helper.link_to("Enviar para manutenção", new_car_maintenance_path(self))
    end
    helper.link_to("Dar baixa em manutenção", new_return_maintenance_path(current_maintenance))
  end

  private

  def helper
    ApplicationController.helpers
  end

end