<script>
import ArmoredForm from "./ArmoredForm.svelte"
import LossesGraph from "./LossesGraph.svelte"
import { totalArmored } from "./stores"

export let data

let lossData = data.map(({date, apc}) => ({date, unit: apc}))
</script>

<h1>Russian Armored Vehicle Losses</h1>
<LossesGraph {lossData} total={$totalArmored} label="armored vehicle" />
<ArmoredForm />
