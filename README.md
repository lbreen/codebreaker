# Ruby word unscrambler

## Aim
  To create a ruby-based program to unscramble words

## Description
  By passing a scrambled word, or sentence, as a parameter the program will rearrange the letter order to reveal the possible combinations and thus the unscrambled word. The program will also make an api request to an online dictionary, in order to retrieve a definition for the possible words. Those words which successfully respond with a definition will be ranked higher on the assumption that those words are more likely to be correct.

## Process

1) User inputs scrambled word => `"cairh"`

2) Compute possible combinations => `['archi', 'chair', 'chari', 'chria', 'richa']`

3) Retrieve definitions from an online dictionary, unless there is already a definition in the local dictionary

4) Display possible words with definitions

> 1) chair -> A separate seat for one person, typically with a back and four legs.
> 2) archi -> No definition found - Not in the dictionary
> 3) chari -> No definition found - Not in the dictionary
> 4) chria -> No definition found - Not in the dictionary
> 5) richa -> No definition found - Not in the dictionary

## Goals

- [X] Unscramble a word
- [ ] Unscramble a sentence
- [X] Provide definitions for the unscrambled words
- [X] Sort word combinations from most likely to least likely
- [X] Allow users to add new words to the dictionary
- [X] Allow users to add definitions for their new words
- [X] Allow users to update definitions for existing words
- [X] Display the time taken for the program to unscramble a word


## Installation

1) Clone this repository to your computer `git clone`
2) Open the repository locally and move to the `lib` folder
3) Run `ruby app.rb` in your terminal (working to transiton from command-line to GUI)



