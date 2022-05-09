<script>
import Slider from "./Slider.svelte"

export let ammoRounds
export let heatPercentage
export let doubleHeatSinksPercentage
export let rangeAtLeast
export let damageValue
export let stabDamageValue
</script>

<form>
  <Slider label="Ammo for how many rounds" bind:value={ammoRounds} min={1} max={30} format={(v) => `${v}`}/>
  <Slider label="Heat to compensate for" bind:value={heatPercentage} min={0} max={100} step={5} format={(v) => `${v}%`}/>
  <Slider label="How many double heat sinks" bind:value={doubleHeatSinksPercentage} min={0} max={100} format={(v) => `${v}%`}/>
  <Slider label="Normal damage value" bind:value={damageValue} min={0} max={1} step={0.01} format={(v) => `${v}`}/>
  <Slider label="Stability damage value" bind:value={stabDamageValue} min={0} max={1} step={0.01} format={(v) => `${v}`}/>
  <Slider label="Range at least" bind:value={rangeAtLeast} min={90} max={720} step={30} format={(v) => `${v}m`}/>
</form>

<style>
form {
  display: grid;
  grid-template-columns: auto auto auto;
  margin-bottom: 1em;
}
</style>
