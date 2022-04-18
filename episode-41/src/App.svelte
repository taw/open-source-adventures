<script>
import * as d3 from "d3"
import TankLosses from "./TankLosses.svelte"
import ArmoredLosses from "./ArmoredLosses.svelte"
import ArtilleryLosses from "./ArtilleryLosses.svelte"
import { dataDays } from "./stores"

let parseRow = (row) => ({
  date: new Date(row.date),
  tank: +row.tank,
  apc: +row.APC,
  art: +row["field artillery"] + +row["MRL"],
})

let loadData = async () => {
  let url = "./russia_losses_equipment.csv"
  let data = await d3.csv(url, parseRow)
  data.unshift({date: new Date("2022-02-24"), tank: 0, apc: 0, art: 0})
  $dataDays = data.length - 1
  return data
}

let dataPromise = loadData()
</script>

{#await dataPromise then data}
  <TankLosses {data} />
  <ArmoredLosses {data} />
  <ArtilleryLosses {data} />
{/await}

<style>
:global(body) {
  margin: 0;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
