<script>
import * as d3 from "d3"
import TankLosses from "./TankLosses.svelte"
import ArmoredLosses from "./ArmoredLosses.svelte"
import ArtilleryLosses from "./ArtilleryLosses.svelte"
import SoldierLosses from "./SoldierLosses.svelte"
import { dataDays } from "./stores"

let parseRow = (row1, row2) => ({
  date: new Date(row1.date),
  tank: +row1.tank,
  apc: +row1.APC,
  art: +row1["field artillery"] + +row1["MRL"],
  kia: +row2.personnel,
})

let loadData = async () => {
  let data1 = await d3.csv("./russia_losses_equipment.csv")
  let data2 = await d3.csv("./russia_losses_personnel.csv")
  let data = [{date: new Date("2022-02-24"), tank: 0, apc: 0, art: 0, kia: 0}]
  for(let i = 0; i < data1.length; i++) {
    data.push(parseRow(data1[i], data2[i]))
  }
  $dataDays = data.length - 1
  return data
}

let dataPromise = loadData()
</script>

{#await dataPromise then data}
  <TankLosses {data} />
  <ArmoredLosses {data} />
  <ArtilleryLosses {data} />
  <SoldierLosses {data} />
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
