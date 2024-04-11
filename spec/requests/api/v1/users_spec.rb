require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET #show' do
    let(:user) { create(:user) }

    context 'when the record exists' do
      before { get api_v1_user_path(user) }

      it 'returns status code ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user' do
        expect(json.dig('data', 'id').to_i).to eq(user.id)
      end
    end

    context 'when the record does not exist' do
      before { get api_v1_user_path('non existent user id') }

      it 'returns status code not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq('Record not found')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:user) }
    let(:invalid_attributes) { { first_name: '', last_name: '', email: '', password: '' } }

    context 'when the request is valid' do
      before { post api_v1_users_path, params: { user: valid_attributes } }

      it 'returns status code created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the user' do
        expect(json.dig('data', 'attributes', 'first_name')).to eq(valid_attributes[:first_name])
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_users_path, params: { user: invalid_attributes } }

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expected_errors = <<~ERRORS.squish
          First name can't be blank,
          First name is too short (minimum is 2 characters),
          Last name can't be blank,
          Last name is too short (minimum is 2 characters),
          Email can't be blank,
          Email is invalid,
          Password can't be blank,
          Password is too short (minimum is 8 characters),
          Password must include at least one lowercase letter, one uppercase letter, one digit, and one special character
        ERRORS
        expect(json['error']).to eq(expected_errors)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:valid_attributes) { attributes_for(:user, first_name: 'John') }

    context 'when the request is valid' do
      before { patch api_v1_user_path(user), params: { user: valid_attributes } }

      it 'returns status code ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the requested user' do
        expect(user.reload.first_name).to eq(valid_attributes[:first_name])
      end
    end

    context 'when the request is invalid' do
      before { put api_v1_user_path(user), params: { user: { first_name: '' } } }

      it 'returns status code unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['error']).to eq("First name can't be blank, First name is too short (minimum is 2 characters)")
      end
    end
  end
end
