require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "se debe poder crear el usuario" do
    u = User.new(username: "alexlecco", email: "alexmaximilianovillecco@gmail.com", password: "12345678")
    assert u.save
  end

  test "se debe poder crear un usuario sin email" do
    u = User.new(username: "alexlecco", password: "12345678")
    assert u.save
  end

end
