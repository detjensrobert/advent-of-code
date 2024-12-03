import Data.List

-- take 2 repeatedly
group2 (a:b:rs) = [(a, b)] ++ group2 rs
group2 _ = []
-- group2 _ = []

-- parse input colums into two lists
parse :: String -> ([Int], [Int])
parse = unzip . group2 . map (\i -> read i :: Int) . words


-- part 1 - sum the differences between the minimum

part1 :: ([Int], [Int]) -> Int
part1 (a, b) = sum $ p1diff $ zip (sort a) (sort b) -- zip minimum values together

-- find difference between minimum values in list of tuples
p1diff :: [(Int, Int)] -> [Int]
p1diff ((a', b'):rest) = [abs (a' - b')] ++ p1diff rest
p1diff [] = []


-- -- part 2 - count how many times the left numbers appear in the right list

part2 :: ([Int], [Int]) -> Int
part2 (left, right) = sum . map (\l -> l * occurrances right l) $ left

-- find how many times `needle` appears in list `haystack`
occurrances :: Ord a => [a] -> a -> Int
occurrances haystack needle =
  case find (\(i, ct) -> i == needle) $ countItems haystack
  of Just (i, ct) -> ct
     Nothing -> 0

-- count occurences of items in list as (item, count)
countItems :: Ord a => [a] -> [(a, Int)]
countItems = map (\l@(x:xs) -> (x, length l)) . group . sort


-- ghci> run "test"
run file = do
  input <- readFile file

  putStr "Part 1: "
  putStrLn $ show . part1 . parse $ input

  putStr "Part 2: "
  putStrLn $ show . part2 . parse $ input
