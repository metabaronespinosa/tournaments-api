require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #sign_up' do
    context 'params are valid' do
      it 'returns User', :show_in_doc do
        expect do
          process :sign_up,
                  method: :post,
                  params: {
                    user: {
                      email: 'sign.up@mail.co',
                      password: 'password',
                      password_confirmation: 'password'
                    }
                  }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status :created
        expect(response.body).to match_json_expression user_json
      end
    end

    context 'params are not valid' do
      it 'returns validation errors', :show_in_doc do
        expect do
          process :sign_up,
                  method: :post,
                  params: {
                    user: {
                      email: ''
                    }
                  }
        end.to_not change(User, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to match_json_expression validation_errors_json
      end
    end
  end

  context 'when authenticated' do
    authenticate(:one)

    describe 'GET #show' do
      it 'returns authenticated User', :show_in_doc do
        process :show,
                method: :get
        expect(response).to have_http_status :ok
        expect(response.body).to match_json_expression user_json
      end
    end

    describe 'PUT #update' do
      it 'updates authenticated User', :show_in_doc do
        process :update,
                method: :put,
                params: {
                  user: {
                    email: 'one.updated@mail.co'
                  }
                }
        expect(response).to have_http_status :ok
        expect(response.body).to match_json_expression user_json
        expect(current_resource_owner.attributes).to_not eq(current_resource_owner.reload.attributes)
      end
    end
  end
end
