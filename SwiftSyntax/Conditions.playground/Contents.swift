import UIKit

// Conditions

// if and else dont have parenthesis on parameters
let isHungry = false
let isThirsty = true

if isHungry {
    print("eat")
} else if isThirsty {
    print("drink")
} else {
    print("eat and drink later")
}


// ternary
let shouldEat = isHungry ? "eat" : "dont eat"
print(shouldEat)
