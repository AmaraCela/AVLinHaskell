data AVLTree a = EmptyTree | Node a (AVLTree a) (AVLTree a) Int deriving (Show)

max' :: (Num a,Ord a) => a -> a -> a
max' a b = if a<b then b else a 

height :: AVLTree a -> Int
height EmptyTree = -1 
height (Node _ _ _ h) = h 


rotateWithRight :: AVLTree a -> AVLTree a
rotateWithRight (Node a left (Node r1 left1 right1 h1) h) = Node r1 (Node a left left1 (((max' (height left) (height left1))) +1)) right1 ((max' ((max' (height left) (height left1)) +1) (height(right1)))+1)


rotateWithLeft :: AVLTree a -> AVLTree a
rotateWithLeft (Node a (Node l1 left1 right1 h1) right h) = Node l1 (left1) (Node a right1 right ((max' (height right1) (height right)) +1 )) ((max' (height (left1)) (((max' (height right1) (height right))+1)))+1)

rotateLeftThenRight :: AVLTree a-> AVLTree a 
rotateLeftThenRight (Node a left right h) = rotateWithRight (Node a left (rotateWithLeft right) h)

rotateRightThenLeft :: AVLTree a -> AVLTree a
rotateRightThenLeft (Node a left right h) = rotateWithLeft (Node a (rotateWithRight left) right h)

rotate::AVLTree a-> AVLTree a
rotate EmptyTree = EmptyTree
rotate (Node a (EmptyTree) (Node a2 left2 right2 h2) h)
                |(height(Node a2 left2 right2 h2) == 1) = rright
                |otherwise = Node a (EmptyTree) (Node a2 left2 right2 h2) h
                where 
                rright
                        |(height(left2) - height(right2) == 1) = rotateLeftThenRight(Node a (EmptyTree) (Node a2 left2 right2 h2) h)
                        |otherwise = rotateWithRight(Node a (EmptyTree) (Node a2 left2 right2 h2) h)  

rotate (Node a (Node a1 left1 right1 h1) (EmptyTree) h)   
                |height(Node a1 left1 right1 h1) == 1 = rleft
                |otherwise = (Node a (Node a1 left1 right1 h1) (EmptyTree) h)  
                where 
                rleft 
                        |(height(left1)-height(right1) == 1) = rotateWithLeft(Node a (Node a1 left1 right1 h1) (EmptyTree) h)
                        |otherwise = rotateRightThenLeft(Node a (Node a1 left1 right1 h1) (EmptyTree) h) 

rotate (Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h) 
                            |(height (Node a1 left1 right1 h1) - height(Node a2 left2 right2 h2))==2 = rleft
                            |(height (Node a1 left1 right1 h1) - height(Node a2 left2 right2 h2))==(-2) = rright
                            |otherwise =  Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h
                            where 
                            rleft 
                                |(height(left1)-height(right1) == 1) = rotateWithLeft(Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h)
                                |otherwise = rotateRightThenLeft(Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h) 
                            rright
                                |(height(left2) - height(right2) == 1) = rotateLeftThenRight(Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h)
                                |otherwise = rotateWithRight(Node a (Node a1 left1 right1 h1) (Node a2 left2 right2 h2) h)  

insertAVL :: (Ord a) => a -> AVLTree a -> AVLTree a
insertAVL a EmptyTree = Node a EmptyTree EmptyTree 0 
insertAVL a (Node x left right h) 
                                |a < x  = rotate $ Node x  leftInsert right (max' (height (leftInsert)) (height(right))+1)
                                |a > x  = rotate $ Node x left rightInsert (max' (height (left)) (height(rightInsert)) +1)
                                |otherwise = Node a left right h

                                where 
                                leftInsert = (insertAVL a left)
                                rightInsert = (insertAVL a right) 


inorder:: (Show a) => AVLTree a -> [a] 
inorder EmptyTree = []
inorder (Node a left right) = (inorder left) ++ [a] ++ (inorder right)
    
preorder :: (Show a) => AVLTree a -> [a] 
preorder EmptyTree = []
preorder (Node a left right) = [a] ++ (preorder left) ++ (preorder right)

postorder :: (Show a) => AVLTree a -> [a]
postorder EmptyTree = []
postorder (Node a left right) = (postorder left) ++ (postorder right)  ++ [a]
