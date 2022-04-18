<script>
import Slider from "./Slider.svelte"
import CommonSliders from "./CommonSliders.svelte"
import { activeArt } from "./stores"
</script>

<form>
  <CommonSliders />
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
