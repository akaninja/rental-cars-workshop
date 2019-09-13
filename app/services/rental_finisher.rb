class RentalFinisher
  
  def initialize(rental, new_km, mailer = RentalMailer)
    @rental = rental
    @new_km = new_km
    @car = rental.car
    @mailer = mailer
  end
  
  # Separar linhas em métodos separados e validar

  def finish
    return false unless return_car
    finish_rental
    notify_customer
  end
  
  private
  
  attr_reader :rental, :new_km, :car, :mailer

  def return_car
    # CarReturner.new(car, new_km).return
    car.update(car_km: new_km, status: :available)
  end

  def finish_rental
    rental.update(status: :finished, finished_at: Time.zone.now)
  end

  def notify_customer
    # RentalFinisherNotifier.new(rental.id).notify
    mailer.send_return_receipt(rental.id).deliver_now
  end

end