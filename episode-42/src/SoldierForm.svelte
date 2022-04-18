<script>
import Slider from "./Slider.svelte"
import CommonSliders from "./CommonSliders.svelte"
import { kiaRegular, wiaToKia } from "./stores"
</script>

<form>
  <CommonSliders />
  <Slider label="Percentage of KIA that are regular troops" min={50} max={100} value={$kiaRegular} format={(v) => `${v}%`} />
  <Slider label="Wounded to Killed Ratio" min={100} max={1000} value={$wiaToKia} format={(v) => `${v/100.0}x`} />
</form>

<style>
form {
  display: grid;
  grid-template-columns: auto auto auto;
}
</style>
