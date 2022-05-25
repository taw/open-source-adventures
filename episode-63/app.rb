win = `window`
document = win.JS[:document]
summary = document.JS.querySelector("#summary")
button = document.JS.querySelector("button")

count = 0

button.JS.addEventListener("click") do
  count += 1
  summary.JS[:innerText] = "You clicked #{count} times"
end
