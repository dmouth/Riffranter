require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  should "be valid" do
    assert Persona.new.valid?
  end
end

# == Schema Information
#
# Table name: personas
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  title      :string(255)
#  image      :text
#  created_at :datetime
#  updated_at :datetime
#

