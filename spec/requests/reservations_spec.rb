RSpec.describe Api::V1::ReservationsController, type: :request do
  let(:user) { User.create(name: 'John', email: 'john6@email.com', password: '123456') }
  let(:doctor) do
    Doctor.create(name: 'Juan Muñoz', specialization: 'Pediatry', city: 'Miami', fee: 200,
                  photo: 'https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg',
                  experience: 20)
  end

  before(:each) do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get '/api/v1/reservations'
      expect(response).to have_http_status(:success)
    end

    it 'returns all reservations' do
      reservation = Reservation.create(user_id: user.id, doctor_id: doctor.id, date: '2023-04-11', city: 'New York')
      get '/api/v1/reservations'
      json_response = JSON.parse(response.body)
      expect(json_response['reservations'].size).to eq(1)
      expect(json_response['reservations'][0]['id']).to eq(reservation.id)
    end
  end

  describe 'POST #create' do
    it 'creates a new reservation with valid params' do
      expect do
        post '/api/v1/reservations',
             params: { reservation: { doctor_id: doctor.id, date: '2023-04-11', city: 'New York' } }
      end.to change(Reservation, :count).by(1)

      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(json_response['reservation']['user_id']).to eq(user.id)
      expect(json_response['success']).to be_truthy
      expect(json_response['message']).to eq("Doctor's appointment created successfully!")
    end

    it 'returns an error with invalid params' do
      post '/api/v1/reservations', params: { reservation: { doctor_id: nil, date: '2023-04-11', city: 'New York' } }

      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response['message']).to include('Doctor must exist, Doctor does not exist')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys a reservation' do
      reservation = Reservation.create(id: 1, user_id: user.id, doctor_id: doctor.id, date: '2023-04-11',
                                       city: 'New York')
      expect do
        delete "/api/v1/reservations/#{reservation.id}"
      end.to change(Reservation, :count).by(-1)

      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response['reservation']['id']).to eq(reservation.id)
      expect(json_response['success']).to be_truthy
      expect(json_response['message']).to eq("Doctor's appointment was successfully destroyed!")
    end
  end
end
