class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new("Alice", "Ruby")
puts "Hello, #{person}!"
nil
