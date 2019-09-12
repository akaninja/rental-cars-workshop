require 'rails_helper'

describe RentalByPeriodQuery do 
  describe 'call' do 
    it 'should count rentals by subsidiaries' do 
      customer = create(:company_customer)
      start = 3.days.ago
      finish = 1.days.ago
      subsidiary = create(:subsidiary, name: 'Matriz')
      car = create(:car, subsidiary: subsidiary)
      create_list(:finished_rental, 5, car:car, customer: customer, 
                  started_at: 2.days.ago)
      
      other_subsidiary = create(:subsidiary, name: 'Outra')
      other_car = create(:car, subsidiary: other_subsidiary)
      create_list(:finished_rental, 10, car: other_car, customer: customer,
                  started_at: 2.days.ago) 

      result = described_class.new(start..finish).call

      expect(result[subsidiary.id]).to eq 5
      expect(result[other_subsidiary.id]).to eq 10

    end

    it 'should count subsidiaries with no rentals' do
      customer = create(:company_customer)
      start = 3.days.ago
      finish = 1.days.ago
      subsidiary = create(:subsidiary, name: 'Matriz')
      car = create(:car, subsidiary: subsidiary)
      create_list(:finished_rental, 5, car:car, customer: customer, 
                  started_at: 2.days.ago)
      
      other_subsidiary = create(:subsidiary, name: 'Outra')

      result = described_class.new(start..finish).call

      expect(result[subsidiary.id]).to eq 5
      expect(result[other_subsidiary.id]).to eq nil
    end

  end
end