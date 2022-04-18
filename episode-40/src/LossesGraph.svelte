<script>
import * as d3 from "d3"
import Graph from "./Graph.svelte"
import { lossAdjustment, futureIntensity } from "./stores"

export let lossData, total, label

let adjust = (data, adjustmentLoss) => data.map(({date, unit}) => ({date, unit: Math.round(unit * (1 + adjustmentLoss/100))}))

let [minDate, maxDate] = d3.extent(lossData, d => d.date)

$: adjustedData = adjust(lossData, $lossAdjustment)
$: alreadyDestroyed = d3.max(adjustedData, d => d.unit)
$: unitsMax = Math.max(alreadyDestroyed, total)

$: currentDestroyRate = alreadyDestroyed / (maxDate - minDate)
$: futureDestroyRate = (currentDestroyRate * $futureIntensity / 100.0)
$: unitsTodo = total - alreadyDestroyed
$: lastDestroyedDate = new Date(+maxDate + (unitsTodo / futureDestroyRate))

$: xScale = d3.scaleTime()
  .domain([minDate, lastDestroyedDate])
  .range([0, 700])

$: yScale = d3.scaleLinear()
  .domain([0, unitsMax])
  .nice()
  .range([500, 0])

$: pathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.unit))
  (adjustedData)

$: trendPathData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.unit))
  ([adjustedData[0], adjustedData[adjustedData.length - 1], {unit: total, date: lastDestroyedDate}])

$: totalPathData = d3.line()
  .x(xScale)
  .y(yScale(unitsMax))
  ([minDate, lastDestroyedDate])

$: xAxis = d3.axisBottom()
  .scale(xScale)
  .tickFormat(d3.timeFormat("%e %b %Y"))

$: yAxisL = d3
  .axisLeft()
  .scale(yScale)

$: yScaleR = d3.scaleLinear()
  .domain([0, 100])
  .range([
    yScale(0),
    yScale(unitsMax)
  ])

$: yAxisR =  d3
  .axisRight()
  .scale(yScaleR)
  .tickFormat(n => `${n}%`)
</script>

<Graph {pathData} {trendPathData} {totalPathData} {xAxis} {yAxisL} {yAxisR} />
<div>Russia will lose its last {label} on {d3.timeFormat("%e %b %Y")(lastDestroyedDate)}</div>
