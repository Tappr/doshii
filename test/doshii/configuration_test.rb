require './test/test_helper'

class ConfigurationTest < Minitest::Test
  def test_that_it_exists
    assert defined?(Doshii::Configuration)
  end

  def test_that_it_sets_valid_options
    Doshii::Configuration::VALID_CONFIG_KEYS.each do |key|
      value = Doshii::Configuration.const_get("DEFAULT_#{key.upcase}")
      Doshii.configure do |config|
        config.send("#{key}=", value)
        assert_same Doshii.send(key), value
      end
    end
  end

  def test_that_it_ignores_invalid_options
    invalid = 'invalid'
    Doshii.configure do |config|
      assert_raises(NoMethodError) { config.send(invalid, invalid) }
    end
  end

  def test_that_it_returns_default_values
    Doshii::Configuration::VALID_CONFIG_KEYS.each do |key|
      assert_same Doshii.send(key), Doshii::Configuration.const_get("DEFAULT_#{key.upcase}")
    end
  end
end
