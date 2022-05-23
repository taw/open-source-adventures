class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

class Cat < Person
  def to_s
    "Your Majesty, Princess #{super}"
  end
end

cat = Cat.new("Catherine", "Whiskers")
puts "Hello, #{cat}!"
nil
