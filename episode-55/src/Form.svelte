<script>
import Slider from "./Slider.svelte"

export let ammoRounds
export let heatPercentage
export let doubleHeatSinksPercentage
</script>

<form>
  <Slider label="Ammo for how many rounds" bind:value={ammoRounds} min={1} max={30} format={(v) => `${v}`}/>
  <Slider label="Heat to compensate for" bind:value={heatPercentage} min={0} max={100} format={(v) => `${v}%`}/>
  <Slider label="How many double heat sinks" bind:value={doubleHeatSinksPercentage} min={0} max={100} format={(v) => `${v}%`}/>
</form>

<style>
form {
  display: grid;
  grid-template-columns: auto auto auto;
  margin-bottom: 1em;
}
</style>
