export function calculateCost(storage) {
  const rate = storage <= 10 ? 4 : storage <= 100 ? 2 : 1;

  // multiply by 100 because stripe expects amount to be in pennies
  return rate * storage * 100
}