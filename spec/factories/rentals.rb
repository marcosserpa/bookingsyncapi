FactoryGirl.define do
  factory :rental_one, class: 'Rental' do
    name 'Rental One'
    daily_rate 1.5
  end

  factory :rental_two, class: 'Rental' do
    name 'Rental Two'
    daily_rate 10.0
  end
end
