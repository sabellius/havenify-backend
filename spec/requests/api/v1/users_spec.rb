require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /api/v1/users/:id' do
    let(:user) { create(:user) }

    context 'when the record exists' do
      before { get api_v1_user_path(user) }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the user' do
        expect(response.parsed_body.dig('data', 'id').to_i).to eq(user.id)
      end
    end

    context 'when the record does not exist' do
      non_existent_user_id = 9999
      before { get api_v1_user_path(non_existent_user_id) }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Record not found/)
      end
    end
  end

  describe 'POST /api/v1/users' do
    let(:valid_attributes) { build(:user).attributes }

    context 'when the request is valid' do
      before { post api_v1_users_path, params: valid_attributes }

      it 'creates a user' do
        expect(response).to have_http_status(201)
      end

      it 'returns the user' do
        expect(json['name']).to eq(valid_attributes['name'])
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_users_path, params: { user: { first_name: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expected_errors = {
          email: [
            "can't be blank",
            "can't be blank",
            'is invalid'
          ],
          password: [
            "can't be blank",
            "can't be blank",
            'is too short (minimum is 8 characters)',
            'must include at least one lowercase letter, one uppercase letter, one digit, and one special character'
          ],
          first_name: [
            "can't be blank",
            'is too short (minimum is 2 characters)'
          ],
          last_name: [
            "can't be blank",
            'is too short (minimum is 2 characters)'
          ]
        }
        expect(response.parsed_body.fetch('error').symbolize_keys).to eq(expected_errors)
      end
    end
  end

  describe 'PUT /api/v1/users/:id' do
    let(:user) { create(:user) }
    let(:valid_attributes) { build(:user, first_name: 'John').attributes }

    context 'when the request is valid' do
      before { put api_v1_user_path(user), params: { user: valid_attributes } }

      it 'returns status code 204' do
        debugger
        expect(response).to have_http_status(200)
      end

      it 'updates the requested user' do
        expect(user.reload.first_name).to eq(valid_attributes['first_name'])
      end
    end

    context 'when the request is invalid' do
      before { put "/api/v1/users/#{user.id}", params: { name: '' } }

      it 'returns validation errors' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end
end
