# Это главный файл, который подключает всю библиотеку
require_relative "password_strength/version"
require_relative "password_strength/checker"

# Главный модуль
module PasswordStrength
  # Создаем и возвращаем новый экземпляр Checker
  def self.new_checker
    Checker.new
  end
end