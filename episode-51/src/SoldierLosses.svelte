<script>
import SoldierForm from "./SoldierForm.svelte"
import SoldierLossesGraph from "./SoldierLossesGraph.svelte"

export let data

let lossData = data.map(({date, kia}) => ({date, unit: kia}))
</script>

<h1>Russian Soldiers Losses</h1>
<SoldierLossesGraph {lossData} />
<SoldierForm />
