<script>
import * as d3 from "d3"
import Axis from "./Axis.svelte"

export let data

let xScale = d3.scaleTime()
  .domain(d3.extent(data, d => d.date))
  .range([0, 700])

let yScale = d3.scaleLinear()
  .domain(d3.extent(data, d => d.tank))
  .nice()
  .range([500, 0])

let pathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.tank))
  (data)

let trendPathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.tank))
  ([data[0], data.at(-1)])

let xAxis = d3.axisBottom()
  .scale(xScale)
  .ticks(d3.timeThursday)
  .tickFormat(d3.timeFormat("%b %d"))
let yAxis = d3
  .axisLeft()
  .scale(yScale)
</script>

<h1>Russian Tank Losses</h1>
<svg>
  <g class="graph"><path d={pathData}/></g>
  <g class="trendline"><path d={trendPathData}/></g>
  <g class="x-axis"><Axis axis={xAxis}/></g>
  <g class="y-axis"><Axis axis={yAxis}/></g>
</svg>

<style>
svg {
  height: 600px;
  width: 800px;
}
.graph {
  transform: translate(50px, 20px);
}
.graph path {
  fill: none;
  stroke: red;
  stroke-width: 1.5;
}
.trendline {
  transform: translate(50px, 20px);
}
.trendline path {
  fill: none;
  stroke: red;
  stroke-width: 1.5;
  stroke-dasharray: 3px;
}
.x-axis {
  transform: translate(50px, 520px);
}
.y-axis {
  transform: translate(50px, 20px);
}
</style>
