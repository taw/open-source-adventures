<script>
import Axis from "./Axis.svelte"
export let xAxis, yAxis, kiaData, wiaData, totalData, kiaTrendData, wiaTrendData, totalTrendData
</script>

<svg viewBox="0 0 800 600">
  <g class="graph">
    <path class="kia" d={kiaData} />
    <path class="wia" d={wiaData} />
    <path class="total" d={totalData} />
    <path class="kia trendline" d={kiaTrendData} />
    <path class="wia trendline" d={wiaTrendData} />
    <path class="total trendline" d={totalTrendData} />
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
  transform: translate(60px, 20px);
}
path {
  fill: none;
  stroke-width: 1.5;
}
path.kia {
  stroke: red;
}
path.wia {
  stroke: green;
}
path.total {
  stroke: blue;
}
path.trendline {
  stroke-dasharray: 3px;
}
.x-axis {
  transform: translate(60px, 520px);
}
.y-axis {
  transform: translate(60px, 20px);
}
</style>
