    from pyscript import Element
    def fizzbuzz(i):
      if i % 15 == 0:
        return "FizzBuzz"
      elif i % 3 == 0:
        return "Fizz"
      elif i % 5 == 0:
        return "Buzz"
      else:
        return i
    list = Element("output")
    list.innerHTML = "".join([f"<li><{fizzbuzz(i)}/li>" for s in range(1, 101)])

