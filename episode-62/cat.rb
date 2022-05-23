class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def toString()
    return "#{@first_name} #{@last_name}"
  end
end

class Cat < Person
  def toString()
    return "Your Majesty, Princess #{super}"
  end
end

cat = Cat.new("Catherine", "Whiskers")
puts "Hello, #{cat}!"
