require 'rails_helper'

RSpec.describe Api::V1::DoctorsController, type: :request do
  describe 'GET /api/v1/doctors' do
    let!(:user) { User.create(email: 'ex6@example.com', password: '123456') }
    let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }

    before do
      Doctor.create(name: "Juan Muñoz", specialization: "Pediatry", city: "Miami", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 20)
      Doctor.create(name: "Pedro Fuentes", specialization: "Pediatry", city: "New York", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 10)
      get '/api/v1/doctors', headers: headers
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all doctors' do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
    end
  end

  describe 'POST /api/v1/doctors/' do
    let!(:user) { User.create(email: 'ex6@example.com', password: '123456') }
    let(:valid_attributes) do
      { name: "Juan Muñoz", specialization: "Pediatry", city: "Miami", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 20 }
    end
    let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }

    context 'when the request is valid' do
      before do
        post '/api/v1/doctors', params: { doctor: valid_attributes }.to_json, headers: headers
      end

      it 'creates a doctor' do
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eq('Juan Muñoz')
        expect(json_response['specialization']).to eq('Pediatry')
        expect(json_response['city']).to eq('Miami')
        expect(json_response['fee']).to eq("200.0")
        expect(json_response['photo']).to eq('https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg')
        expect(json_response['experience']).to eq("20.0")
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'DELETE /api/v1/doctors/:id' do
    let(:user) { User.create(email: 'ex6@example.com', password: '123456') }
    let(:payload) { { user_id: user.id } }
    let(:token) { JWT.encode(payload, Rails.application.secret_key_base) }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }

    let!(:doctor) do
      Doctor.create(name: "Juan Muñoz", specialization: "Pediatry", city: "Miami", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 20)
    end

    it 'deletes the doctor' do
      expect do
        delete "/api/v1/doctors/#{doctor.id}", headers:
      end.to change(Doctor, :count).by(-1)
    end
  end
end
