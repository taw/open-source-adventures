<script>
  import data from "./data.json"
</script>

<h1>Weapons Data</h1>

<table>
  {#each data as row}
    <tr>
      <td>{row.name}</td>
    </tr>
  {/each}
</table>

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
