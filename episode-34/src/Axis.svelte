<script>
import * as d3 from "d3"
export let axis

let axisNode

$: {
  d3.select(axisNode).selectAll("*").remove()
  d3.select(axisNode).call(axis)
}
</script>

<g bind:this={axisNode}></g>
