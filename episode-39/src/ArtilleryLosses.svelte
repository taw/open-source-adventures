<script>
import ArtilleryForm from "./ArtilleryForm.svelte"
import LossesGraph from "./LossesGraph.svelte"

export let data

let lossData = data.map(({date, art}) => ({date, unit: art}))

// put some dummy data to avoid issues with initialization order
let adjustmentLoss = 0, futureIntensity = 100, total = 0
</script>

<h1>Russian Artillery Losses</h1>
<LossesGraph {lossData} {adjustmentLoss} {futureIntensity} {total} label="artillery" />
<ArtilleryForm bind:adjustmentLoss bind:futureIntensity bind:total />
