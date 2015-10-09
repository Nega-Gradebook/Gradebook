# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Teacher.create(name: 'Bill Nye', email: 'billnye@scienceguy.com', password: "password")
Parent.create(name: 'bob', email: 'bob@bob.com', password: 'password', student_id: 1)
Student.create(name: 'Robert', email: 'robert@bob.com', password: 'password', teacher_id: 1)
