class RentalFinisher
  
  def initialize(rental, new_km, mailer = RentalMailer)
    @rental = rental
    @new_km = new_km
    @car = rental.car
    @mailer = mailer
  end
  
  # Separar linhas em métodos separados e validar

  def finish
    car.update(car_km: new_km, status: :available)
    rental.update(status: :finished, finished_at: Time.zone.now)
    mailer.send_return_receipt(rental.id).deliver_now
  end
  
  private
  
  attr_reader :rental, :new_km, :car, :mailer

end