<script>
import TankForm from "./TankForm.svelte"
import LossesGraph from "./LossesGraph.svelte"
import { totalTanks } from "./stores"

export let data

let lossData = data.map(({date, tank}) => ({date, unit: tank}))
</script>

<h1>Russian Tank Losses</h1>
<LossesGraph {lossData} total={$totalTanks} label="tank" />
<TankForm />
