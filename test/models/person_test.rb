require "test_helper"

class PersonTest < ActiveSupport::TestCase

  test "should not save person without name" do
    person = Person.new
    person.email = "test@123.com"
    assert_not person.save, "Saved the person without a name"
  end

  test "should not save person without email" do
    person = Person.new
    person.name = "Test"
    assert_not person.save, "Saved the person without an email"
  end

  test "should not save person with invalid email" do
    person = Person.new
    person.name = "Test"
    person.email = "invalid"
    assert_not person.save, "Saved the person with an invalid email"
  end

  test "should save person with valid email" do
    person = Person.new
    person.name = "Akshay"
    person.email = "akahsy@tets.com"
    assert person.save, "Saved the person with a valid email"
  end

  test "should save person with unique email" do
    person = Person.new
    person.name = "Akshay"
    person.email = "akshay@gmail.com"
    assert person.save, "Saved the person with a unique email"
  end


end
