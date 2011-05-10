require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  should "be valid" do
    assert Persona.new.valid?
  end
end
