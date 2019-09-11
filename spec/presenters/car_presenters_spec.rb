require 'rails_helper'

describe CarPresenter do
  include Rails.application.routes.url_helpers
  
  describe '#maintenance_link' do 
    context 'admin' do
      
      it 'should render start maintenance ' do
        subsidiary = create(:subsidiary)
        user = create(:user, :admin, subsidiary: subsidiary)
        car = create(:car, subsidiary: user.subsidiary, status: :available)

        result = CarPresenter.new(car, user).maintenance_link

        expect(result).to include(new_car_maintenance_path(car.id))
      end

      it 'should render end maintenance if car on maintenance' do
        subsidiary = create(:subsidiary)
        user = create(:user, :admin, subsidiary: subsidiary)
        car = create(:car, subsidiary: user.subsidiary, status: :on_maintenance)
        maintenance = create(:maintenance, car: car)

        result = CarPresenter.new(car, user).maintenance_link

        expect(result).to include(new_return_maintenance_path(car.current_maintenance.id))
      end

      it 'should render nothing if car rented' do
        subsidiary = create(:subsidiary)
        user = create(:user, :admin, subsidiary: subsidiary)
        car = create(:car, subsidiary: user.subsidiary, status: :rented)

        result = CarPresenter.new(car, user).maintenance_link

        expect(result).to eq ''
      end
    end
  end
end
