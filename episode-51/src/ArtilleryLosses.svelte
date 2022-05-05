<script>
import ArtilleryForm from "./ArtilleryForm.svelte"
import LossesGraph from "./LossesGraph.svelte"
import { totalArt } from "./stores"

export let data

let lossData = data.map(({date, art}) => ({date, unit: art}))
</script>

<h1>Russian Artillery Losses</h1>
<LossesGraph {lossData} total={$totalArt} label="artillery" />
<ArtilleryForm />
