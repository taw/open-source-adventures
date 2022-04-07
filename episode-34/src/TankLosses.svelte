<script>
import * as d3 from "d3"
import Form from "./Form.svelte"
import Graph from "./Graph.svelte"

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
  ([adjustedData[0], adjustedData[adjustedData.length - 1], {tank: totalTanks, date: lastTankDate}])

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
<Graph {pathData} {trendPathData} {tankTotalPathData} {xAxis} {yAxis}/>
<Form bind:adjustmentLoss bind:futureIntensity bind:totalTanks />
<div>Russia will lose its last tank on {d3.timeFormat("%e %b %Y")(lastTankDate)}</div>
