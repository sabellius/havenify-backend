class ProperySerializer
  include JSONAPI::Serializer

  attributes :name, :description, :address, :city, :zipcode, :type, :price, :bedrooms, :bathrooms, :square_meters, :user_id
end
