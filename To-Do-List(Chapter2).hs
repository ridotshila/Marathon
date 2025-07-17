-- Chapter 2 Project: Simple To-Do List
import Data.List (delete)

type Task = String

main :: IO ()
main = do
    putStrLn "Welcome to your To-Do List!"
    menu []

menu :: [Task] -> IO ()
menu tasks = do
    putStrLn "\nOptions:"
    putStrLn "1. View tasks"
    putStrLn "2. Add task"
    putStrLn "3. Remove task"
    putStrLn "4. Search task"
    putStrLn "5. Exit"
    putStr "Choose an option: "
    choice <- getLine
    case choice of
        "1" -> do viewTasks tasks
                  menu tasks
        "2" -> do
            putStr "Enter new task: "
            task <- getLine
            let newTasks = addTask task tasks
            putStrLn "Task added!"
            menu newTasks
        "3" -> do
            putStr "Enter task to remove: "
            task <- getLine
            let newTasks = removeTask task tasks
            menu newTasks
        "4" -> do
            putStr "Enter task to search for: "
            task <- getLine
            putStrLn $ if taskExists task tasks
                         then "Task found!"
                         else "Task not found."
            menu tasks
        "5" -> putStrLn "Goodbye!"
        _   -> do
            putStrLn "Invalid option."
            menu tasks

-- Functions with clear types
addTask :: Task -> [Task] -> [Task]
addTask task tasks = task : tasks

removeTask :: Task -> [Task] -> [Task]
removeTask task tasks = delete task tasks

taskExists :: Eq a => a -> [a] -> Bool
taskExists = elem  -- demonstrates polymorphism and infix

viewTasks :: [Task] -> IO ()
viewTasks [] = putStrLn "No tasks yet."
viewTasks tasks = mapM_ putStrLn tasks

