module UsersDoc
  extend BaseDoc
  resource :users

  doc_for :sign_up do
    api :POST, '/users/sign_up', 'Create user'
    param :user, Hash, required: true do
      param :email, String, required: true
      param :password, String, required: true
      param :password_confirmation, String, required: true
    end
    error code: 422, desc: 'Unprocessable entity'
  end
end