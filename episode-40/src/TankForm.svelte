<script>
import * as d3 from "d3"
import Slider from "./Slider.svelte"
import { lossAdjustment, futureIntensity, activeTanks, storageTanks, storageGood, totalTanks } from "./stores"
</script>

<form>
  <Slider label="Adjustment for losses data" min={-30} max={50} bind:value={$lossAdjustment} format={(v) => d3.format("+d")(v) + "%"} />
  <Slider label="Predicted future war intensity" min={10} max={200} bind:value={$futureIntensity} format={(v) => `${v}%`} />
  <Slider label="Russian tanks at start of war" min={2500} max={3500} bind:value={$activeTanks} format={(v) => v} />
  <Slider label="Russian tanks in storage" min={8000} max={12000} bind:value={$storageTanks} format={(v) => v} />
  <Slider label="Usable tanks in storage" min={0} max={100} bind:value={$storageGood} format={(v) => `${v}%`} />

  <div>
    <span>Total usable tanks</span>
    <span></span>
    <span>{$totalTanks}</span>
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
