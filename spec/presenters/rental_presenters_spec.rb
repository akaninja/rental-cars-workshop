require 'rails_helper'
#necessário incluir a linha abaixo para que o teste saiba carregar os helpers de rotas.


RSpec.describe RentalPresenter do
  include Rails.application.routes.url_helpers
  
  describe '#status' do
    it 'should render a green badge for scheduled' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = RentalPresenter.new(rental).status

      expect(result).to match /span/
      expect(result).to match /badge-success/
      expect(result).to match /Agendada/
    end

    it 'should reder a blue badge for active' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:rental, car: car, customer: customer, status: :active)

      result = RentalPresenter.new(rental).status
      
      expect(result).to match /span/
      expect(result).to match /badge-primary/
      expect(result).to match /Em andamento/
    end 
  end

  describe '#withdraw_link' do
    it 'should render a withdraw button' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = RentalPresenter.new(rental).withdraw_link

      expect(result).to match /a/
      expect(result).to include withdraw_rental_path(rental.id)
    end

    it 'should render a withdraw button' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:rental, car: car, customer: customer, status: :active)

      result = RentalPresenter.new(rental).withdraw_link

      expect(result).to eq ""
    end
  end
end