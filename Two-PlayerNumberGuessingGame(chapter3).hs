import Text.Read (readMaybe)

main :: IO ()
main = do
    putStrLn "🎯 Player 1: Enter a secret number between 1 and 100."
    putStr "Secret number: "
    secretInput <- getLine
    let maybeSecret = readMaybe secretInput :: Maybe Int
    case maybeSecret of
        Just secret -> do
            putStrLn "\n✅ Secret number saved. Now hand over to Player 2!"
            putStrLn "Player 2: Try to guess the number!"
            guessLoop secret
        Nothing -> do
            putStrLn "❌ Invalid input. Please enter a valid number."
            main

guessLoop :: Int -> IO ()
guessLoop secret = do
    putStr "\nYour guess: "
    input <- getLine
    let maybeGuess = readMaybe input :: Maybe Int
    case maybeGuess of
        Just guess ->
            if guess == secret
                then putStrLn "🎉 Correct! You guessed the number!"
                else do
                    putStrLn $ feedback guess secret
                    guessLoop secret
        Nothing -> do
            putStrLn "❌ That's not a valid number."
            guessLoop secret

feedback :: Int -> Int -> String
feedback guess secret
    | diff == 0  = "Correct!"
    | diff < 0   = "Too low! Try a higher number."
    | otherwise  = "Too high! Try a lower number."
    where diff = guess - secret
