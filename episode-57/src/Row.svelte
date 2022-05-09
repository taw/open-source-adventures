<script>
export let data

let round100 = (v) => Math.round(v * 100) / 100

let {baseName, bonus, category, baseStabDamage, heat, shots, baseDamage, tonnage, maxRange, value, cost, ratio, ammoWeight, indirectFire} = data
let damage, stabDamage
if (shots == 1) {
  damage = baseDamage
  stabDamage = baseStabDamage
} else {
  damage = `${shots}x${baseDamage}`
  stabDamage = `${shots}x${baseStabDamage}`
}
if (heat == 0) {
  heat = ""
}
if (baseStabDamage == 0) {
  stabDamage = ""
}
if (ammoWeight == 0) {
  ammoWeight = ""
}
let typeSymbol = (category == "AntiPersonnel") ? "S" : category.substring(0, 1)
</script>

<tr>
  <td>{baseName}</td>
  <td>{bonus}</td>
  <td>{typeSymbol}</td>
  <td>{damage}</td>
  <td>{stabDamage}</td>
  <td>{heat}</td>
  <td>{tonnage}</td>
  <td>{round100(ammoWeight)}</td>
  <td>
    {maxRange}m
    {#if indirectFire}
      🚀
    {/if}
  </td>
  <td>{round100(value)}</td>
  <td>{round100(cost)}</td>
  <td>{round100(ratio)}</td>
</tr>
