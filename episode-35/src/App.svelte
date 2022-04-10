<script>
import * as d3 from "d3"
import TankLosses from "./TankLosses.svelte"

let parseRow = ({date,tank}) => ({date: new Date(date), tank: +tank})

let loadData = async () => {
	let url = "./russia_losses_equipment.csv"
	let data = await d3.csv(url, parseRow)
	data.unshift({date: new Date("2022-02-24"), tank: 0})
	return data
}

let dataPromise = loadData()
</script>

{#await dataPromise then data}
	<TankLosses {data} />
{/await}

<style>
:global(body) {
	margin: 0;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
</style>
