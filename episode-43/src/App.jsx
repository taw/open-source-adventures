import { createSignal } from "solid-js"

function App() {
  let [count, setCount] = createSignal(0)

  return (
    <div>
      <div>{ count() }</div>
      <button onClick={() => setCount(count() + 1)}>Click me!</button>
    </div>
  )
}

export default App
