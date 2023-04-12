# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Doctor.create(name: "Juan Muñoz", specialization: "Pediatry", city: "Miami", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 20)
Reservation.create(user_id: 1, doctor_id: 1, date: "2023-04-10", time: "14:30:00", city: "Miami")
