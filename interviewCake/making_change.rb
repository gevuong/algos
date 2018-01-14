# Write a function that, given:
# 1. an amount of money
# 2. a list of coin denominations

# computes the number of ways to make the amount of money with coins of the available denominations.

# Example: for amount=4 (4¢) and denominations=[1,2,3] (1¢, 2¢ and 3¢), your program would output 4—the number of ways to make 4¢ with those denominations:
#
# 1¢, 1¢, 1¢, 1¢
# 1¢, 1¢, 2¢
# 1¢, 3¢
# 2¢, 2¢

# edge case: if denominations are all greater than amount, return 0.
def making_change(amount_left, denominations, current_idx = 0)
  # base cases:
  # return 1 if no amount is left. return 0 if overshoot amount (used too many coins)
  return 1 if amount_left == 0
  return 0 if amount_left < 0

  # return 0 if current_idx == denominations.length
  puts "checking ways to make #{amount_left} with #{denominations[current_idx..-1]}"

  current_coin = denominations[current_idx]

  while amount_left > 0
    making_change(amount_left, denominations[current_idx..-1], current_idx + 1)
  end
end