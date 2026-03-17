module PasswordStrength
  class Checker
    # Конструктор (как __init__ в Python)
    def initialize
      # Список самых популярных плохих паролей
      @common_passwords = [
        "123456", "password", "123456789", "12345", "12345678",
        "qwerty", "1234567", "111111", "1234567890", "123123",
        "abc123", "admin", "letmein", "welcome", "monkey"
      ]
      
      # Настройки проверки (можно менять)
      @min_length = 8
      @require_digit = true
      @require_lowercase = true
      @require_uppercase = true
      @require_symbol = true
    end
    
    # Главный метод - проверяет пароль и возвращает результат
    def check(password)
      # Создаем пустой результат
      result = {
        valid: true,                # прошел ли проверку
        score: 0,                   # баллы от 0 до 100
        strength: "weak",           # weak, medium, strong, very_strong
        errors: [],                  # что не так
        suggestions: []              # советы по улучшению
      }
      
      # Проверка длины
      if password.length < @min_length
        result[:valid] = false
        result[:errors] << "Пароль должен быть не меньше #{@min_length} символов"
      else
        result[:score] += 20
      end
      
      # Проверка на наличие цифр
      if @require_digit && password !~ /\d/
        result[:valid] = false
        result[:errors] << "Пароль должен содержать хотя бы одну цифру"
      else
        result[:score] += 20 if password =~ /\d/
      end
      
      # Проверка на маленькие буквы
      if @require_lowercase && password !~ /[a-z]/
        result[:valid] = false
        result[:errors] << "Пароль должен содержать хотя бы одну маленькую букву"
      else
        result[:score] += 20 if password =~ /[a-z]/
      end
      
      # Проверка на большие буквы
      if @require_uppercase && password !~ /[A-Z]/
        result[:valid] = false
        result[:errors] << "Пароль должен содержать хотя бы одну заглавную букву"
      else
        result[:score] += 20 if password =~ /[A-Z]/
      end
      
      # Проверка на спецсимволы (!@#$%^&*)
      if @require_symbol && password !~ /[^a-zA-Z0-9]/
        result[:valid] = false
        result[:errors] << "Пароль должен содержать хотя бы один спецсимвол (!@#$%^&*)"
      else
        result[:score] += 20 if password =~ /[^a-zA-Z0-9]/
      end
      
      # Проверка на популярные пароли
      if @common_passwords.include?(password.downcase)
        result[:valid] = false
        result[:errors] << "Этот пароль слишком популярный, выберите другой"
        result[:score] = 0
      end
      
      # Добавляем советы в зависимости от баллов
      if result[:score] < 40
        result[:suggestions] << "Очень слабый пароль, добавьте больше разных символов"
      elsif result[:score] < 60
        result[:suggestions] << "Неплохо, но можно усилить (добавьте спецсимволы)"
      elsif result[:score] < 80
        result[:suggestions] << "Хороший пароль!"
      else
        result[:suggestions] << "Отличный пароль!"
      end
      
      # Определяем уровень надежности
      if result[:score] < 40
        result[:strength] = "weak"
      elsif result[:score] < 60
        result[:strength] = "medium"
      elsif result[:score] < 80
        result[:strength] = "strong"
      else
        result[:strength] = "very_strong"
      end
      
      # Возвращаем результат
      result
    end
    
    # Простой метод - только проверяет, валидный или нет
    def valid?(password)
      result = check(password)
      result[:valid]
    end
    
    # Метод, который показывает только ошибки
    def errors(password)
      result = check(password)
      result[:errors]
    end
    
    # Метод для изменения настроек
    def configure(min_length: nil, require_digit: nil, require_uppercase: nil)
      @min_length = min_length if min_length
      @require_digit = require_digit unless require_digit.nil?
      @require_uppercase = require_uppercase unless require_uppercase.nil?
    end
  end
end