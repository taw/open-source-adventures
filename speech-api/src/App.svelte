<script>
  let loading = true
  let voices = []
  speechSynthesis.addEventListener("voiceschanged", ev => {
    loading = false
    voices = speechSynthesis.getVoices()
  })
  let text = "Hello, world!"
  let voiceIndex = 0
  $: voice = voices[voiceIndex]

  function sayIt() {
    let u = new SpeechSynthesisUtterance(text)
    u.voice = voice
    speechSynthesis.speak(u)
  }
</script>

<div>
  <label>Text to say:
    <input bind:value={text} />
  </label>
  <button on:click={sayIt}>Say it</button>
</div>

{#if loading}
  <div>Please wait for voices to load</div>
{:else}
  <div>Available Voices:</div>
  <ul>
    {#each voices as v, i}
      <li>
        <label>
          <input type="radio" bind:group={voiceIndex} value={i}>
          {v.name} - {v.lang}
        </label>
      </li>
    {/each}
  </ul>
{/if}

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
