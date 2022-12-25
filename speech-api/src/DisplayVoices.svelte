<script>
  let voicesPromise = new Promise((resolve) => {
    speechSynthesis.addEventListener("voiceschanged", ev => {
      resolve(speechSynthesis.getVoices())
    })
  })
</script>

<div>Available Voices:</div>
{#await voicesPromise then voices}
  <ul>
    {#each voices as voice}
      <li>{voice.name} - {voice.lang}</li>
    {/each}
  </ul>
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
