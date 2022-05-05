<script>
export let label, min, max, value, format
let id = Math.random().toString(36).slice(2)
</script>

<label for={id}>{label}:</label>
<input type="range" {min} {max} bind:value id={id} />
<span>{format(value)}</span>
