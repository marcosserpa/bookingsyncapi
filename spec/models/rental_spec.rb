require 'spec_helper'

describe Rental do
  context 'should not be created' do
    it 'when name is not filled' do
      rental = Rental.create(daily_rate: 1.0)

      expect(rental.persisted?).to be false
      expect(rental.errors[:name]).to match_array ["Name can't be blank"]
    end

    it 'when daily rate is not filled' do
      rental = Rental.create(name: 'Rental Test')

      expect(rental.persisted?).to be false
      expect(rental.errors[:daily_rate]).to match_array ["Daily Rate needs a value"]
    end
  end

  context 'should be created' do
    it 'when name and daily rate are filled' do
      rental = Rental.create(name: 'Rental Test', daily_rate: 1.0)

      expect(rental.persisted?).to be true
    end
  end
end
