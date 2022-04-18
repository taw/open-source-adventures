<script>
import * as d3 from "d3"
import Slider from "./Slider.svelte"
import { lossAdjustment, projectionBasis, dataDays, futureIntensity } from "./stores"
</script>

<Slider label="Adjustment for losses data" min={-30} max={50} bind:value={$lossAdjustment} format={(v) => d3.format("+d")(v) + "%"} />
<Slider label="Projection basis in days" min={1} max={$dataDays} bind:value={$projectionBasis} format={(v) => `${v} days`} />
<Slider label="Predicted future war intensity" min={10} max={200} bind:value={$futureIntensity} format={(v) => `${v}%`} />
