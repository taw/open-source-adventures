import Eye from "./Eye"
import { createSignal } from "solid-js"

function randomColor() {
  let h = Math.random() * 360
  let s = Math.round(50 + Math.random() * 50)
  let l = Math.round(30 + Math.random() * 40)
  return `hsl(${h}, ${s}%, ${l}%)`
}

function eyeDistance(eye1, eye2) {
  let dx = eye1.x - eye2.x;
  let dy = eye1.y - eye2.y;
  return Math.sqrt((dx * dx) + (dy * dy))
}

function canPlaceEye(eyes, newEye) {
  return eyes.every(eye =>
    eyeDistance(eye, newEye) >= eye.sz + newEye.sz + 5
  )
}

function generateEyes() {
  let eyes = []
  let wh = window.innerHeight
  let ww = window.innerWidth
  let mx = Math.random() * ww
  let my = Math.random() * wh
  for(let i=0; i<1000; i++) {
    let sz = 20 + Math.random() * 60
    let x = sz + Math.random() * (ww - 2 * sz)
    let y = sz + Math.random() * (wh - 2 * sz)
    let color = randomColor()
    let newEye = {x, y, sz, color}
    if (canPlaceEye(eyes, newEye)) {
      eyes.push(newEye)
    }
  }
  return eyes
}

function App() {
  let eyes = generateEyes()
  let wh = window.innerHeight
  let ww = window.innerWidth
  // init it to something random if mouse starts outside window
  let [mx, setMx] = createSignal(Math.random() * ww)
  let [my, setMy] = createSignal(Math.random() * wh)

  function onMouseMove() {
    let svg = document.getElementById("eyes")
    let rect = svg.getBoundingClientRect()
    setMx(event.pageX - rect.x)
    setMy(event.pageY - rect.y)
  }

  return (
    <svg id="eyes" onMouseMove={onMouseMove}>
      <For each={eyes}>
        {({x, y, sz, color}) => <Eye x={x} y={y} sz={sz} color={color} mx={mx} my={my} />}
      </For>
    </svg>
  )
}

export default App
