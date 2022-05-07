<script>
  import data from "./data.json"
  import Row from "./Row.svelte"
  import {sortBy} from "lodash"

  let round100 = (v) => Math.round(v * 100) / 100

  for (let row of data) {
    row.value = row.shots * row.baseDamage
    row.ammoWeight = round100(10 * row.ammoTonnagePerShot)
    row.cost = round100(row.tonnage + row.ammoWeight + row.heat/3.0)
    row.ratio = round100(row.value / row.cost)
  }

  let sortedData = sortBy(data, [(x) => -x.ratio, (x) => x.name])
</script>

<h1>BATTLETECH Weapons Data</h1>

<table>
  <tr>
    <th>Name</th>
    <th>Damage</th>
    <th>Heat</th>
    <th>Weight</th>
    <th>Ammo Weight</th>
    <th>Range</th>
    <th>Value</th>
    <th>Cost</th>
    <th>Ratio</th>
  </tr>
  {#each sortedData as row}
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
