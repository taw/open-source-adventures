<script>
export let label, min, max, value, format, step = undefined
let id = Math.random().toString(36).slice(2)
</script>

<label for={id}>{label}:</label>
<input type="range" {min} {max} {step} bind:value id={id} />
<span>{format(value)}</span>
