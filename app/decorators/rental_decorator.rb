class RentalDecorator < ApplicationDecorator
  delegate_all
  
  def started_at
    return "---" if object.scheduled?

    return object.started_at if object.active?
  end
end
