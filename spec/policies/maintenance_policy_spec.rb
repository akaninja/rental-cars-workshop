require 'rails_helper'

describe MaintenancePolicy do
  describe 'authorized?' do 
    it 'should be true if admin' do
      user = build(:user, :admin)
      car = build(:car)

      result = MaintenancePolicy.new(car, user).authorized?

      expect(result).to eq true
    end

    it 'should be false if employee' do
      user = build(:user, role: :employee)
      car = build(:car)

      result = MaintenancePolicy.new(car, user).authorized?

      expect(result).to eq false
    end

    it 'should be false if manager and diff subsidiary' do
      subsidiary = create(:subsidiary, name: 'Tolocos')
      sub = create(:subsidiary, name: 'TacoBell')
      user = build(:user, role: :manager, subsidiary: subsidiary)
      car = build(:car, subsidiary: sub)

      result = MaintenancePolicy.new(car, user).authorized?

      expect(result).to eq false
    end

    it 'should be true if manager and same subsidiary' do
      subsidiary = create(:subsidiary)
      user = build(:user, role: :manager, subsidiary: subsidiary)
      car = build(:car, subsidiary: subsidiary)

      result = MaintenancePolicy.new(car, user).authorized?

      expect(result).to eq true
    end

    it 'should be false if guest' do 
      guest = NilUser.new
      car = build(:car)

      result = MaintenancePolicy.new(car, guest).authorized?
      expect(result).to eq false
    end

  end
end
