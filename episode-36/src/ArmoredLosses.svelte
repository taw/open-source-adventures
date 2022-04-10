<script>
import ArmoredForm from "./ArmoredForm.svelte"
import LossesGraph from "./LossesGraph.svelte"

export let data

let lossData = data.map(({date, apc}) => ({date, unit: apc}))

// put some dummy data to avoid issues with initialization order
let adjustmentLoss = 0, futureIntensity = 100, total = 0
</script>

<h1>Russian Armored Vehicle Losses</h1>
<LossesGraph {lossData} {adjustmentLoss} {futureIntensity} {total} label="armored vehicle" />
<ArmoredForm bind:adjustmentLoss bind:futureIntensity bind:total />
