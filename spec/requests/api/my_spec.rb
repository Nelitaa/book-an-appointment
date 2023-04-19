require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
  path '/api/v1/doctors' do
    get 'Retrieves all doctors' do
      tags 'Get doctors'
      produces 'application/json', 'application/xml'
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'blog found' do
        schema type: :object,
          properties: {
            name: { type: :string },
            specialization: { type: :string },
            city: { type: :string },
            fee: { type: :decimal },
            photo: { type: :string },
            experience: { type: :decimal}
          },
          required: [ 'name', 'specialization', 'city', 'fee', 'photo', 'experience' ]
      end

      response '404', 'doctors not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/api/v1/doctors/{id}' do
    delete 'Deletes a doctor by ID' do
      tags 'Delete doctors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '204', 'doctor deleted' do
        let(:doctor) { create(:doctor) }
        let(:id) { doctor.id }
        run_test!
      end

      response '404', 'doctor not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/doctors' do
    post 'Add a doctor' do
      tags 'Add a doctor'
      consumes 'application/json'
      parameter name: :name, in: :query, type: :string
      parameter name: :specialization, in: :query, type: :string
      parameter name: :city, in: :query, type: :string
      parameter name: :fee, in: :query, type: :decimal
      parameter name: :experience, in: :query, type: :decimal
      parameter name: :photo, in: :query, type: :string
      parameter name: :doctor, in: :body, schema: {
        type: :object,
        properties: {
          doctor: {
            type: :object,
            properties: {
              name: { type: :string },
              specialization: { type: :string },
              city: { type: :string },
              fee: { type: :number, format: :float },
              photo: { type: :string },
              experience: { type: :number, format: :float }
            },
            required: ['name', 'specialization', 'city', 'fee', 'photo', 'experience']
          }
        },
        required: ['doctor']
      }

      response '201', 'doctor created' do
        let(:doctor) { { doctor: { name: 'John Doe', specialization: 'Neurologist', city: 'New York', fee: 150.0, photo: 'https://img.freepik.com/foto-gratis/apuesto-joven-medico-bata-laboratorio-estetoscopio-usando-tableta-verificar-historial-paciente_662251-2962.jpg?size=626&ext=jpg', experience: 5 } } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:doctor) { { doctor: { name: '', specialization: '', city: '', fee: '', photo: '', experience: '' } } }
        run_test!
      end

      response '422', 'doctor already exists' do
        let(:doctor) { { doctor: { name: 'John Doe', specialization: 'Neurologist', city: 'New York', fee: 150.0, photo: 'https://img.freepik.com/foto-gratis/apuesto-joven-medico-bata-laboratorio-estetoscopio-usando-tableta-verificar-historial-paciente_662251-2962.jpg?size=626&ext=jpg', experience: 5 } } }
        before { post '/api/v1/doctors', params: doctor.to_json, headers: { 'CONTENT_TYPE' => 'application/json' } }
        run_test!
      end
    end

    path '/api/v1/reservations' do
      get 'Retrieves all reservations' do
        tags 'Get reservations'
        produces 'application/json', 'application/xml'
        parameter name: :reservation, in: :query, type: :object, properties: {
          doctor_id: { type: :integer },
          date: { type: :string },
          city: { type: :string }
        }, required: true, description: 'Reservation parameters'

        response '200', 'reservations found' do
          schema type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                doctor_id: { type: :integer },
                date: { type: :string },
                city: { type: :string }
              },
              required: [ 'id', 'doctor_id', 'date', 'city' ]
            }
          run_test!
        end

        response '400', 'missing reservation parameters' do
          let(:reservation) { nil }
          run_test!
        end

        response '404', 'reservations not found' do
          let(:reservation) { { doctor_id: -1, date: '2023-04-11', city: 'New York' } }
          run_test!
        end
      end
    end

    path '/api/v1/reservations' do
      post 'Creates a reservation' do
        tags 'Add a reservation'
        produces 'application/json'
        request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'
        parameter name: :doctor_id, in: :query, type: :number
        parameter name: :date, in: :query, type: :date
        parameter name: :city, in: :query, type: :string
        response '201', 'reservation created' do
          let(:reservation) { { doctor_id: 1, date: '2023-04-11', city: 'New York' } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:reservation) { { doctor_id: nil, date: nil, city: nil } }
          run_test!
        end
      end
    end
  end
end
