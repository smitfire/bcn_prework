# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

u = User.create(name: 'nick', email: 'n@n.com', password: 'n', password_confirmation: 'n')

Exercise.create(title: 'Fizz Buzz', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Array Sum', description: 'Define a method by the name of total and let total take one argument, which would be an array. Calculate the sum of this array')
Exercise.create(title: 'Credit Card Validator', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Simple Guessing Game', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Array Mean', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Array Median', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Array Mode', description: 'define a method called mode that takes one argument, an array. It should return the most frequent occurring value in the array for both numbers and strings. If there are multiple values that occur of equal frequency it should return an array of both.')
Exercise.create(title: 'Longest String In Array', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')
Exercise.create(title: 'Calculate Letter Grade', description: 'replace the multiple of 3 with the string fizz and multiples of 5 with the string buzz and the multiple of both with fizzbuzz')

Exercise.all.each do |ex|
  u.exercises << ex
end