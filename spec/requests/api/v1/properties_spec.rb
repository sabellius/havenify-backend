require 'rails_helper'

RSpec.describe "Api::V1::Properties", type: :request do
  describe 'GET #index' do
    let!(:user) { create(:user) }
    let!(:properties) { create_list(:property, 5) }

    before { get api_v1_properties_path }

    it 'returns all properties' do
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let(:property) { create(:property) }

    before { get api_v1_property_path(property) }

    context 'when the record exists' do
      it 'returns the property' do
        expect(json.dig('data', 'id')).to eq(property.id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get api_v1_property_path('non existent_id') }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { build(:property_attributes).except(:user_id) }

    context 'when the request is valid' do
      before { post api_v1_properties_path, params: valid_attributes.to_json, headers: api_headers }

      it 'creates a property' do
        expect(Property.count).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_properties_path, params: { name: '' }.to_json, headers: api_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['error']).to eq('Validation failed')
      end
    end
  end

  describe 'PUT #update' do
    let(:property) { create(:property) }
    let(:new_attributes) { { name: 'New Name' } }

    context 'when the record exists' do
      before { put api_v1_property_path(property), params: new_attributes.to_json, headers: api_headers }

      it 'updates the property' do
        expect(property.reload.name).to eq('New Name')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { put api_v1_property_path('non existent_id'), params: new_attributes.to_json, headers: api_headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:property) { create(:property) }

    before { delete api_v1_property_path(property), headers: api_headers }

    it 'deletes the property' do
      expect(Property.count).to eq(0)
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end


