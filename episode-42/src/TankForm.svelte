<script>
import Slider from "./Slider.svelte"
import CommonSliders from "./CommonSliders.svelte"
import { activeTanks, storageTanks, storageGood, totalTanks } from "./stores"
</script>

<form>
  <CommonSliders />
  <Slider label="Russian tanks at start of the war" min={2500} max={3500} bind:value={$activeTanks} format={(v) => v} />
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
