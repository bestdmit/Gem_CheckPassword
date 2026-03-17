#!/usr/bin/env ruby
require_relative "../lib/password_strength"

# Создаем проверяльщик
checker = PasswordStrength::Checker.new

# Массив паролей для тестирования
passwords = ["12345", "password", "qwerty123", "Qwerty123", "Qwerty123!@#"]

puts "=" * 50
puts "ПРОВЕРКА ПАРОЛЕЙ"
puts "=" * 50

passwords.each do |pwd|
  puts "\nПароль: #{pwd}"
  result = checker.check(pwd)
  
  puts "  Валидный: #{result[:valid] ? '✅' : '❌'}"
  puts "  Сложность: #{result[:strength]}"
  puts "  Баллы: #{result[:score]}/100"
  
  if result[:errors].any?
    puts "  Ошибки:"
    result[:errors].each { |e| puts "    - #{e}" }
  end
  
  if result[:suggestions].any?
    puts "  Советы:"
    result[:suggestions].each { |s| puts "    - #{s}" }
  end
end