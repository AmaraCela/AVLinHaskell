# AVL in Haskell

### What does this repository contain?
This repository contains the implementation of AVL trees in Haskell. What is special about it, is the adaptation of this implementation in a pure functional programming language, in which everything revolves around functions. Using this code, you can insert elements into the AVL Tree, in which the time complexity of O (log n) is preserved by ensuring that the tree will always remain balanced. Concretely, this is made possible by using the rotate functions which rotate the tree everytime the difference in heights between left and right nodes reaches 2. The nodes of the tree can be viewed by either of the methods: preorder, inorder, postorder. For a smoother and more efficeint implementation I have created a new type , namely AVLTree. 

### How to run it?
 1. Install GHC:
  Visit the official GHC website: https://www.haskell.org/ghc/
  Download the appropriate GHC installer for your operating system (Windows, macOS, or Linux).
  Run the installer and follow the instructions to complete the installation.
2. Clone the repository.
3. Using command line go to the directory and type ghci.
4. Type :load treestrees.hs
5. Call the methods found in the the file to run and test the ones that are needed.
   

Make sure to follow these steps in order and adjust them based on your specific operating system and repository setup.
