<script>
import * as d3 from "d3"
import SoldierGraph from "./SoldierGraph.svelte"
import { lossAdjustment, projectionBasis, wiaToKia, kiaRegular, futureIntensity } from "./stores"

export let lossData

let adjustRow = ({date, unit}, totalLossAdjustment, wiaToKia) => {
  let kia = Math.round(unit * totalLossAdjustment)
  let wia = Math.round(kia * wiaToKia / 100)
  let total = kia + wia
  return {date, kia, wia, total}
}
let adjust = (data, totalLossAdjustment, wiaToKia) => data.map(row => adjustRow(row, totalLossAdjustment, wiaToKia))

let at = (array, idx) => ((idx < 0) ? array[array.length + idx] : array[idx])

let [minDate, maxDate] = d3.extent(lossData, d => d.date)

$: adjustedData = adjust(lossData, ($kiaRegular/100) * (1 + $lossAdjustment / 100.0), $wiaToKia)
$: totalSoFar = d3.max(adjustedData, d => d.total)

$: timeInProjection = at(adjustedData, -$projectionBasis-1).date - at(adjustedData, -1).date
$: kiaInProjection = at(adjustedData, -$projectionBasis-1).kia - at(adjustedData, -1).kia
$: wiaInProjection = at(adjustedData, -$projectionBasis-1).wia - at(adjustedData, -1).wia
$: currentKiaRate = kiaInProjection / timeInProjection
$: currentWiaRate = wiaInProjection / timeInProjection

$: futureKiaRate = (currentKiaRate * $futureIntensity / 100.0)
$: futureWiaRate = (currentWiaRate * $futureIntensity / 100.0)
$: futureTotalRate = futureKiaRate + futureWiaRate

// Just hardcode as there's no obvious "finish date"
$: lastDate = new Date("2023-01-01")

// How many KIA+WIA by lastDate
$: unitsMax = Math.round((lastDate - maxDate) * futureTotalRate) + totalSoFar

$: trendData = [
  adjustedData[0],
  at(adjustedData, -1),
  {
    date: lastDate,
    kia: Math.round((lastDate - maxDate) * futureKiaRate) + d3.max(adjustedData, d => d.kia),
    wia: Math.round((lastDate - maxDate) * futureWiaRate) + d3.max(adjustedData, d => d.wia),
    total: Math.round((lastDate - maxDate) * futureTotalRate) + d3.max(adjustedData, d => d.total),
  },
]

$: xScale = d3.scaleTime()
  .domain([minDate, lastDate])
  .range([0, 700])

$: yScale = d3.scaleLinear()
  .domain([0, unitsMax])
  .nice()
  .range([500, 0])

$: yAxis = d3
  .axisLeft()
  .scale(yScale)

$: xAxis = d3.axisBottom()
  .scale(xScale)
  .tickFormat(d3.timeFormat("%e %b %Y"))

$: kiaData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.kia))
  (adjustedData)

$: wiaData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.wia))
  (adjustedData)

$: totalData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.total))
  (adjustedData)

$: kiaTrendData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.kia))
  (trendData)

$: wiaTrendData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.wia))
  (trendData)

$: totalTrendData = d3.line()
  .x(d => xScale(d.date))
  .y(d => yScale(d.total))
  (trendData)
</script>

<SoldierGraph {xAxis} {yAxis} {kiaData} {wiaData} {totalData} {kiaTrendData} {wiaTrendData} {totalTrendData} />
