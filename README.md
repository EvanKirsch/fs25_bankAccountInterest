# FS25 Bank Account Interest
Adds interest calculations so that a farm's bank balance earns interest at the beginning of every month. The default rate is 1% APY.

Two dev console commands have been added to control the interest rate:
`biSetInterestRate <interest_rate>` - allows the modification of the interest rate. ex: `biSetInterestRate 0.01` would set the interest rate to the default.
`biGetInterestRate` - prints the current interest rate to the console.

### Manual build instructions
`git archive -o FS25_bankAccountInterest.zip HEAD`

