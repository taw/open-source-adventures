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

let round100 = (x) => Math.round(x / 100) * 100

let formatEoy = (x) => d3.format(".1f")(x / 1000.0) + "k"

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
$: graphTime = lastDate - maxDate

// How many KIA+WIA by lastDate
$: unitsMax = Math.round(graphTime * futureTotalRate) + totalSoFar

$: kiaSoFar = d3.max(adjustedData, d => d.kia)
$: wiaSoFar = d3.max(adjustedData, d => d.wia)
$: eoyKia = round100(graphTime * futureKiaRate + kiaSoFar)
$: eoyWia = round100(graphTime * futureWiaRate + wiaSoFar)
$: eoyTotal = eoyKia + eoyWia

$: eoyIKia = round100(eoyKia / $kiaRegular * (100 - $kiaRegular))
$: eoyIWia = round100(eoyWia / $kiaRegular * (100 - $kiaRegular))
$: eoyITotal = eoyIKia + eoyIWia

$: trendData = [
  adjustedData[0],
  at(adjustedData, -1),
  {
    date: lastDate,
    kia: Math.round(graphTime * futureKiaRate) + d3.max(adjustedData, d => d.kia),
    wia: Math.round(graphTime * futureWiaRate) + d3.max(adjustedData, d => d.wia),
    total: Math.round(graphTime * futureTotalRate) + d3.max(adjustedData, d => d.total),
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
<div>
  <span class="box kia"></span> Killed
  <span class="box wia"></span> Wounded
  <span class="box total"></span> Total
</div>
<div>By end of the year, Russia will lose {formatEoy(eoyTotal)} ({formatEoy(eoyKia)} killed, {formatEoy(eoyWia)} wounded) regular soldiers.</div>
<div>As well as {formatEoy(eoyITotal)} ({formatEoy(eoyIKia)} killed, {formatEoy(eoyIWia)} wounded) irregulars (separatists, PMCs etc.)</div>

<style>
  .box {
    display: inline-block;
    height: 10px;
    width: 10px;
    border: 1px solid black;
  }
  .box.kia {
    background-color: red;
  }
  .box.wia {
    background-color: green;
  }
  .box.total {
    background-color: blue;
  }
</style>
