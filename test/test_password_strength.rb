require "minitest/autorun"
require_relative "../lib/password_strength"

class TestPasswordStrength < Minitest::Test
  def setup
    @checker = PasswordStrength::Checker.new
  end
  
  def test_weak_password
    result = @checker.check("12345")
    assert_equal false, result[:valid]
    assert_equal "weak", result[:strength]
  end
  
  def test_medium_password
    result = @checker.check("password123")
    # Проверяем, что есть ошибки (потому что популярный пароль)
    assert result[:errors].length > 0
  end
  
  def test_strong_password
    result = @checker.check("Qwerty123!")
    assert_equal true, result[:valid]
    assert_includes ["strong", "very_strong"], result[:strength]
  end
  
  def test_valid_method
    assert_equal false, @checker.valid?("12345")
    assert_equal true, @checker.valid?("Qwerty123!")
  end
end