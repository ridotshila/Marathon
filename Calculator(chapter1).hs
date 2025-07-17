-- Simple Calculator in Haskell

import Text.Read (readMaybe)  

main :: IO ()
main = do
    putStrLn "Welcome to the Haskell Calculator!"
    calculatorLoop

calculatorLoop :: IO ()
calculatorLoop = do
    putStrLn "\nChoose an operation (+, -, *, /) or type 'exit' to quit:"
    op <- getLine
    if op == "exit"
        then putStrLn "Goodbye!"
        else do
            putStrLn "Enter the first number:"
            num1Str <- getLine
            putStrLn "Enter the second number:"
            num2Str <- getLine
            let maybeResult = do
                    x <- readMaybe num1Str
                    y <- readMaybe num2Str
                    operate op x y
            case maybeResult of
                Just res -> putStrLn ("Result: " ++ show res)
                Nothing  -> putStrLn "Invalid input or operation."
            calculatorLoop

-- Perform operation based on input
operate :: String -> Double -> Double -> Maybe Double
operate "+" x y = Just (add x y)
operate "-" x y = Just (subtract' x y)
operate "*" x y = Just (multiply x y)
operate "/" x y = if y /= 0 then Just (divide x y) else Nothing
operate _ _ _   = Nothing

-- Arithmetic functions
add :: Double -> Double -> Double
add x y = x + y

subtract' :: Double -> Double -> Double
subtract' x y = x - y

multiply :: Double -> Double -> Double
multiply x y = x * y

divide :: Double -> Double -> Double
divide x y = x / y
