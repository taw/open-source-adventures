<script>
import TankForm from "./TankForm.svelte"
import LossesGraph from "./LossesGraph.svelte"

export let data

let lossData = data.map(({date, tank}) => ({date, unit: tank}))

// put some dummy data to avoid issues with initialization order
let adjustmentLoss = 0, futureIntensity = 100, total = 0
</script>

<h1>Russian Tank Losses</h1>
<LossesGraph {lossData} {adjustmentLoss} {futureIntensity} {total} label="tank" />
<TankForm bind:adjustmentLoss bind:futureIntensity bind:total />
