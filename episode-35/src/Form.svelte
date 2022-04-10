<script>
import * as d3 from "d3"

export let adjustmentLoss = 0
export let futureIntensity = 100
let activeTanks = 3417
let storageTanks = 10200
let storageGood = 10

export let totalTanks

$: totalTanks = Math.round(activeTanks + storageTanks * storageGood / 100.0)

</script>

<form>
  <div>
    <label for="loss">Adjustment for losses data:</label>
    <input type="range" min="-30" max="50" bind:value={adjustmentLoss} id="loss" />
    <span>{d3.format("+d")(adjustmentLoss)}%</span>
  </div>

  <div>
    <label for="intensity">Predicted future war intensity</label>
    <input type="range" min="50" max="200" bind:value={futureIntensity} id="intensity" />
    <span>{futureIntensity}%</span>
  </div>

  <div>
    <label for="active">Russian tanks at start of war</label>
    <input type="range" min="2500" max="3500" bind:value={activeTanks} id="active" />
    <span>{activeTanks}</span>
  </div>

  <div>
    <label for="storage">Russian tanks in storage</label>
    <input type="range" min="8000" max="12000" bind:value={storageTanks} id="active" />
    <span>{storageTanks}</span>
  </div>

  <div>
    <label for="good">Usable tanks in storage</label>
    <input type="range" min="0" max="100" bind:value={storageGood} id="good" />
    <span>{storageGood}%</span>
  </div>

  <div>
    <span>Total usable tanks</span>
    <span></span>
    <span>{totalTanks}</span>
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
