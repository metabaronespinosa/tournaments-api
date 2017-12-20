require 'rails_helper'

RSpec.describe 'Players', type: :request do
  authenticate(:john_smith)

  describe 'POST /players' do
    let(:round) { rounds(:discworld_one) }

    it 'assigns Players to Round' do
      expect do
        post players_path,
             headers: auth_headers,
             params: {
               round_id: round.id
             }
      end.to change(Player, :count)
      expect(response).to have_http_status(:created)
      expect(response.body).to match_json_expression(players_json)
    end
  end

  describe 'PATCH /players/:id' do
    let(:player) { players(:discworld_one1) }

    context 'when params are valid' do
      it 'returns Player' do
        patch player_path(player.id),
              headers: auth_headers,
              params: {
                player: {
                  result_values: [1, 100]
                }
              }
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_expression(player_json)
      end
    end

    context 'when params are not valid' do
      it 'returns validation errors' do
        patch player_path(player.id),
              headers: auth_headers,
              params: {
                player: {
                  result_values: nil
                }
              }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_expression(errors_json)
      end
    end
  end
end
