import UIKit

// Tuples

// Defining tuples
let latitude: Double = 23.21
let coords: (Double, Double) = (23.4, 54.22)

// Accessing values with index
print(coords.0)
print(coords.1)

// Defining tuples with keys and accessing by key
let coords2 = (lat: 23.2, lng: 54.22)
print(coords2.lat)
print(coords2.lng)

// desestructuring
let cameraPoints = (x: 10, y: 20, z: 1)
let (x, y, _) = cameraPoints
print(x)
print(y)
