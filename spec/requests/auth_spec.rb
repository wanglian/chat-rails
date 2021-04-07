# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Session", type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:user)          { FactoryBot.create(:user) }

  describe 'Email registration method' do
    let(:signup_params) {
      {
        email: 'user@example.com',
        password: '12345678',
        password_confirmation: '12345678'
      }
    }

    describe 'POST /api/v1/auth/' do
      context 'when signup params is valid' do
        before do
          sign_up(signup_params)
        end

        it 'returns status 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns authentication header with right attributes' do
          expect(response.headers['access-token']).to be_present
        end

        it 'returns client in authentication header' do
          expect(response.headers['client']).to be_present
        end

        it 'returns expiry in authentication header' do
          expect(response.headers['expiry']).to be_present
        end

        it 'returns uid in authentication header' do
          expect(response.headers['uid']).to be_present
        end

        it 'returns status success' do
          expect(response_body['status']).to eq('success')
        end

        it 'creates new user' do
          expect {
            sign_up signup_params.merge({ email: "test@example.com" })
          }.to change(User, :count).by(1)
        end
     end

     context 'when signup params is invalid' do
        it 'returns unprocessable entity 422' do
          invalid_params = { email: "test@example.com" }
          sign_up(invalid_params)
          expect(response.status).to eq 422
        end
      end
    end
  end

  describe 'POST /api/v1/auth/sign_in' do
    context 'when login params is valid' do
      before do
        sign_in(user)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns access-token in authentication header' do
        expect(response.headers['access-token']).to be_present
      end

      it 'returns client in authentication header' do
        expect(response.headers['client']).to be_present
      end

      it 'returns expiry in authentication header' do
        expect(response.headers['expiry']).to be_present
      end

      it 'returns uid in authentication header' do
        expect(response.headers['uid']).to be_present
      end
    end

    context 'when login params is invalid' do
      it 'returns unathorized status 401' do
        user.password = 'wrong pass'
        sign_in(user)
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    before do
      sign_in(user)
      @auth_params = get_auth_params(response)
    end

    it 'returns status 200' do
      sign_out @auth_params
      expect(response).to have_http_status(200)
    end
  end
end
