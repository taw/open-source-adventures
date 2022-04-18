import { writable, derived } from "svelte/store"

export let lossAdjustment = writable(0)
export let futureIntensity = writable(100)

export let activeTanks = writable(3417)
export let activeArmored = writable(18543)
export let activeArt = writable(5919)

export let storageTanks = writable(10200)
export let storageArmored = writable(15500)
export let storageGood = writable(10)

export let totalTanks = derived(
  [activeTanks, storageTanks, storageGood],
  ([$activeTanks, $storageTanks, $storageGood]) => Math.round($activeTanks + $storageTanks * $storageGood / 100.0)
)
export let totalArmored = derived(
  [activeArmored, storageArmored, storageGood],
  ([$activeArmored, $storageArmored, $storageGood]) => Math.round($activeArmored + $storageArmored * $storageGood / 100.0)
)

export let totalArt = activeArt
