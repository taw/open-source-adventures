<script>
import {sortBy} from "lodash"
import data from "./data.json"
import Form from "./Form.svelte"
import Headers from "./Headers.svelte"
import Row from "./Row.svelte"

let ammoRounds = 10
let heatPercentage = 80
let doubleHeatSinksPercentage = 0
let rangeAtLeast = 90
let damageValue = 1.0
let stabDamageValue = 0.5

$: heatSinkingPerTon = 3.0 + 3.0 * doubleHeatSinksPercentage / 100
$: costPerHeat = (heatPercentage / 100) / heatSinkingPerTon

let sortedData
$: {
  for (let row of data) {
    row.value = row.shots * (row.baseDamage * damageValue + row.baseStabDamage * stabDamageValue)
    row.ammoWeight = ammoRounds * row.ammoTonnagePerShot
    row.cost = row.tonnage + row.ammoWeight + row.heat * costPerHeat
    row.ratio = row.value / row.cost
    row.id = Math.random().toString(36).slice(2)
  }
  sortedData = sortBy(data, [(x) => -x.ratio, (x) => x.name])
}
</script>

<h1>BATTLETECH Weapons Data</h1>

<Form bind:ammoRounds bind:heatPercentage bind:doubleHeatSinksPercentage bind:rangeAtLeast bind:damageValue bind:stabDamageValue />

<table>
  <Headers />
  {#each sortedData as row (row.id)}
    {#if row.maxRange >= rangeAtLeast}
      <Row data={row} />
    {/if}
  {/each}
</table>

<style>
:global(body) {
  margin: 0;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
}
table :global(tr):nth-child(even) {
  background-color: #f2f2f2;
}
table :global(tr):nth-child(odd) {
  background-color: #e0e0e0;
}
</style>
