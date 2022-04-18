<script>
import Slider from "./Slider.svelte"
import CommonSliders from "./CommonSliders.svelte"
import { activeArmored, storageArmored, storageGood, totalArmored } from "./stores"
</script>

<form>
  <CommonSliders />
  <Slider label="Russian armored vehicles at start of war" min={15000} max={20000} bind:value={$activeArmored} format={(v) => v} />
  <Slider label="Russian armored vehicles in storage" min={10000} max={20000} bind:value={$storageArmored} format={(v) => v} />
  <Slider label="Usable armored vehicles in storage" min={0} max={100} bind:value={$storageGood} format={(v) => `${v}%`} />
  <div>
    <span>Total usable armored vehicles</span>
    <span></span>
    <span>{$totalArmored}</span>
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
