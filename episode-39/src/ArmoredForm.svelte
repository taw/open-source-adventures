<script>
import * as d3 from "d3"
import Slider from "./Slider.svelte"

export let adjustmentLoss = 0
export let futureIntensity = 100
let active = 18543
let storage = 15500
let storageGood = 10

export let total

$: total = Math.round(active + storage * storageGood / 100.0)
</script>

<form>
  <Slider label="Adjustment for losses data" min={-30} max={50} bind:value={adjustmentLoss} format={(v) => d3.format("+d")(v) + "%"} />
  <Slider label="Predicted future war intensity" min={10} max={200} bind:value={futureIntensity} format={(v) => `${v}%`} />
  <Slider label="Russian armored vehicles at start of war" min={15000} max={20000} bind:value={active} format={(v) => v} />
  <Slider label="Russian armored vehicles in storage" min={10000} max={20000} bind:value={storage} format={(v) => v} />
  <Slider label="Usable armored vehicles in storage" min={0} max={100} bind:value={storageGood} format={(v) => `${v}%`} />
  <div>
    <span>Total usable armored vehicles</span>
    <span></span>
    <span>{total}</span>
  </div>
</form>

<style>
form {
  display: grid;
  grid-template-columns: auto auto auto;
}
form > div {
  display: contents;
}
</style>
