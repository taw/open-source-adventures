<script>
import {sortBy} from "lodash"
import data from "./data.json"
import Form from "./Form.svelte"
import Headers from "./Headers.svelte"
import Row from "./Row.svelte"

let ammoRounds = 10
let heatPercentage = 80
let doubleHeatSinksPercentage = 0

let round100 = (v) => Math.round(v * 100) / 100

$: heatSinkingPerTon = 3.0 + 3.0 * doubleHeatSinksPercentage / 100
$: costPerHeat = (heatPercentage / 100) / heatSinkingPerTon

let sortedData
$: {
  for(let row of data) {
    row.value = row.shots * row.baseDamage
    row.ammoWeight = round100(ammoRounds * row.ammoTonnagePerShot)
    row.cost = round100(row.tonnage + row.ammoWeight + row.heat * costPerHeat)
    row.ratio = round100(row.value / row.cost)
    row.id = Math.random().toString(36).slice(2)
  }
  sortedData = sortBy(data, [(x) => -x.ratio, (x) => x.name])
}
</script>

<h1>BATTLETECH Weapons Data</h1>

<Form bind:ammoRounds bind:heatPercentage bind:doubleHeatSinksPercentage />

<table>
  <Headers />
  {#each sortedData as row (row.id)}
    <Row data={row} />
  {/each}
</table>

<style>
:global(body) {
  margin: 0;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
table :global(tr):nth-child(even) {
  background-color: #f2f2f2;
}
table :global(tr):nth-child(odd) {
  background-color: #e0e0e0;
}
</style>
