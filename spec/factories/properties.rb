FactoryBot.define do
  factory :property do
    name { '123 Main St' }
    description { 'Modern 3 bedroom condo in heart of the city' }
    address { '123 Main St' }
    city { 'New York' }
    zipcode { '10001' }
    type { 1 }
    price { 500_000.00 }
    bedrooms { 3.0 }
    bathrooms { 2.0 }
    square_meters { 250 }
    user { nil }
  end
end

