require 'rails_helper'

describe RentalFinisher do
  describe '#finish' do 
    it 'should finish the rental and notify customer' do
      car_model = create(:car_model, name: 'Palio')
      customer = create(:personal_customer, email: 'lucas@gmail.com')
      car = create(:car, car_model: car_model, license_plate: 'XLG-1234',
                   car_km: '100')
      rental = create(:rental, car: car, customer: customer)

      #mock para travar timezone
      now = Time.zone.now
      allow(Time.zone).to receive(:now).and_return(now)
      
      #mock para criar double do Mailer
      mailer = double('Mailer')
      allow(RentalMailer).to receive(:send_return_receipt).with(rental.id).and_return(mailer)
      allow(mailer).to receive(:deliver_now)

      described_class.new(rental, 200).finish
      
      expect(car.car_km).to eq 200
      expect(car.available?).to eq true
      expect(rental.finished?).to eq true
      expect(rental.finished_at).to eq now
      expect(mailer).to have_received(:deliver_now)
    end

  end
end