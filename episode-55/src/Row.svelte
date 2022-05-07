<script>
export let data

let {name, heat, shots, baseDamage, tonnage, minRange, maxRange, value, cost, ratio, ammoWeight} = data
let damage
if (shots == 1) {
  damage = baseDamage
} else {
  damage = `${shots}x${baseDamage}`
}
</script>

<tr>
  <td>{name}</td>
  <td>{damage}</td>
  <td>{heat}</td>
  <td>{tonnage}</td>
  <td>{ammoWeight}</td>
  <td>{maxRange}</td>
  <td>{value}</td>
  <td>{cost}</td>
  <td>{ratio}</td>
</tr>
