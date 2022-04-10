<script>
import Axis from "./Axis.svelte"
export let pathData, trendPathData, totalPathData, xAxis, yAxis
</script>

<svg viewBox="0 0 800 600">
  <g class="graph">
    <path class="data" d={pathData}/>
    <path class="trendline" d={trendPathData}/>
    <path class="total" d={totalPathData}/>
  </g>
  <g class="x-axis"><Axis axis={xAxis}/></g>
  <g class="y-axis"><Axis axis={yAxis}/></g>
</svg>

<style>
svg {
  width: 800px;
  max-width: 100vw;
  display: block;
}
.graph {
  transform: translate(50px, 20px);
}
path {
  fill: none;
}
path.data {
  stroke: red;
  stroke-width: 1.5;
}
path.trendline {
  stroke: red;
  stroke-width: 1.5;
  stroke-dasharray: 3px;
}
path.total {
  stroke: blue;
  stroke-width: 1.5;
}
.x-axis {
  transform: translate(50px, 520px);
}
.y-axis {
  transform: translate(50px, 20px);
}
</style>
