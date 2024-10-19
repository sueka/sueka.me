factorial :: (Eq a, Num a) => a -> a
factorial = factorialCps id

factorialCps k 0 = k 1
factorialCps k n = factorialCps (k . (n *)) (n - 1)

main = do
  let a = factorial 5
  print a
