<script>
import * as d3 from "d3"
import Axis from "./Axis.svelte"
import Form from "./Form.svelte"

export let data

let adjust = (data, adjustmentLoss) => data.map(({date, tank}) => ({date, tank: Math.round(tank * (1 + adjustmentLoss/100))}))

// put some dummy data to avoid issues with initialization order
let adjustmentLoss = 0, futureIntensity = 100, totalTanks = 0

let [minDate, maxDate] = d3.extent(data, d => d.date)

$: adjustedData = adjust(data, adjustmentLoss)
$: alreadyDestroyedTanks = d3.max(adjustedData, d => d.tank)
$: tanksMax = Math.max(alreadyDestroyedTanks, totalTanks)

$: currentTankRate = alreadyDestroyedTanks / (maxDate - minDate)
$: futureTankRate = (currentTankRate * futureIntensity / 100.0)
$: tanksTodo = totalTanks - alreadyDestroyedTanks
$: lastTankDate = new Date(+maxDate + (tanksTodo / futureTankRate))

$: xScale = d3.scaleTime()
  .domain([minDate, lastTankDate])
  .range([0, 700])

$: yScale = d3.scaleLinear()
  .domain([0, tanksMax])
  .nice()
  .range([500, 0])

$: pathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.tank))
  (adjustedData)

$: trendPathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.tank))
  ([adjustedData[0], adjustedData.at(-1), {tank: totalTanks, date: lastTankDate}])

$: tankTotalPathData = d3.line()
  .x(xScale)
  .y(yScale(tanksMax))
  ([minDate, lastTankDate])

$: xAxis = d3.axisBottom()
  .scale(xScale)
  .tickFormat(d3.timeFormat("%e %b %Y"))

$: yAxis = d3
  .axisLeft()
  .scale(yScale)
</script>

<h1>Russian Tank Losses</h1>
<svg>
  <g class="graph">
    <path class="data" d={pathData}/>
    <path class="trendline" d={trendPathData}/>
    <path class="tanktotal" d={tankTotalPathData}/>
  </g>
  <g class="x-axis"><Axis axis={xAxis}/></g>
  <g class="y-axis"><Axis axis={yAxis}/></g>
</svg>

<Form bind:adjustmentLoss bind:futureIntensity bind:totalTanks />
<div>Russia will lose its last tank on {d3.timeFormat("%e %b %Y")(lastTankDate)}</div>

<style>
svg {
  height: 600px;
  width: 800px;
}
.graph {
  transform: translate(50px, 20px);
}
path {
  fill: none;
}
path.data {
  stroke: red;
  stroke-width: 1.5;
}
path.trendline {
  stroke: red;
  stroke-width: 1.5;
  stroke-dasharray: 3px;
}
path.tanktotal {
  stroke: blue;
  stroke-width: 1.5;
}
.x-axis {
  transform: translate(50px, 520px);
}
.y-axis {
  transform: translate(50px, 20px);
}
</style>
