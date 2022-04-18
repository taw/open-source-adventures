<script>
import * as d3 from "d3"
import Slider from "./Slider.svelte"

export let adjustmentLoss = 0
export let futureIntensity = 100
let active = 3417
let storage = 10200
let storageGood = 10

export let total

$: total = Math.round(active + storage * storageGood / 100.0)

</script>

<form>
  <Slider label="Adjustment for losses data" min={-30} max={50} bind:value={adjustmentLoss} format={(v) => d3.format("+d")(v) + "%"} />
  <Slider label="Predicted future war intensity" min={-50} max={200} bind:value={futureIntensity} format={(v) => `${v}%`} />
  <Slider label="Russian tanks at start of war" min={2500} max={3500} bind:value={active} format={(v) => v} />
  <Slider label="Russian tanks in storage" min={8000} max={12000} bind:value={storage} format={(v) => v} />
  <Slider label="Usable tanks in storage" min={0} max={100} bind:value={storageGood} format={(v) => `${v}%`} />

  <div>
    <span>Total usable tanks</span>
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
