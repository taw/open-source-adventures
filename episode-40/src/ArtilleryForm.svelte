<script>
import * as d3 from "d3"
import Slider from "./Slider.svelte"
import { lossAdjustment, futureIntensity, activeArt } from "./stores"
</script>

<form>
  <Slider label="Adjustment for losses data" min={-30} max={50} bind:value={$lossAdjustment} format={(v) => d3.format("+d")(v) + "%"} />
  <Slider label="Predicted future war intensity" min={10} max={200} bind:value={$futureIntensity} format={(v) => `${v}%`} />
  <Slider label="Russian armored vehicles at start of war" min={5000} max={7000} bind:value={$activeArt} format={(v) => v} />
  <div>
    <span>Total usable artillery</span>
    <span></span>
    <span>{$activeArt}</span>
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
