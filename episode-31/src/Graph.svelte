<script>
import * as d3 from "d3"

export let data

let xScale = d3.scaleTime()
    .domain(d3.extent(data, d => d.date))
    .range([0, 600])

let yScale = d3.scaleLinear()
  .domain(d3.extent(data, d => d.tank))
  .range([400, 0])

let pathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.tank))
  (data)

let xAxis, yAxis

$: {
  d3.select(xAxis).selectAll("*").remove()
  d3.select(xAxis).call(d3.axisBottom(xScale))
}
$: {
  d3.select(yAxis).selectAll("*").remove()
  d3.select(yAxis).call(d3.axisLeft(yScale))
}
</script>

<h1>Russian Tank Losses</h1>
<svg>
  <g class="graph">
    <path d={pathData}/>
  </g>
  <g class="x-axis" bind:this={xAxis}></g>
  <g class="y-axis" bind:this={yAxis}></g>
</svg>

<style>
svg {
  height: 600px;
  width: 800px;
}
.graph {
  transform: translate(100px, 100px);
}
path {
  fill: none;
  stroke: red;
  stroke-width: 1.5;
}
.x-axis {
  transform: translate(100px, 500px);
}
.y-axis {
  transform: translate(100px, 100px);
}
</style>
