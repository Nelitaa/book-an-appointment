RSpec.describe Api::V1::ReservationsController, type: :request do
  describe 'GET /api/v1/reservations' do
    let(:user) { User.create(email: 'ex6@example.com', password: '123456') }
    let(:payload) { { user_id: user.id } }
    let(:token) { JWT.encode(payload, Rails.application.secrets.secret_key_base) }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }
    let(:doctor) do
      Doctor.create(name: 'Juan Muñoz', specialization: 'Pediatry', city: 'Miami', fee: 200,
                    photo: 'https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg',
                    experience: 20)
    end

    before do
      Reservation.create(user_id: user.id, doctor_id: doctor.id, date: '2023-04-11', city: 'New York')
      get '/api/v1/reservations', headers:
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all reservations' do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(1)
    end
  end
end
