<h1>Ruby word unscrambler</h1>

<strong>Aim:</strong> To create a ruby-based program to unscramble words

<strong>Description:</strong> By passing a scrambled word or sentence as a parameter the program will rearrange the letter order to reveal the possible combinations and thus the unscrambled word. The program will also make an api request to an online dictionary, in order to retrieve a definition for the possible words. Those words which successfully respond with a definition will be ranked higher on the assumption that those words are more likely to be correct.

<strong>Process:</strong>

1) User inputs scrambled word => "cairh"

2) Compute possible combinations => ['archi', 'chair', 'chari', 'chria', 'richa']

3) Retrieve definitions from an online dictionary, if there is no definition already in the local dictionary

4) Display possible words with definitions

> 1) chair -> A separate seat for one person, typically with a back and four legs.
> 2) archi -> No definition found - Not in the dictionary
> 3) chari -> No definition found - Not in the dictionary
> 4) chria -> No definition found - Not in the dictionary
> 5) richa -> No definition found - Not in the dictionary



<strong>Goals:</strong>

<s>1) Unscramble a word</s>
<p>2) Unscramble a sentence</p>
<s>3) Provide definitions for the unscrambled words</s>
<p>4) Sort word combinations from most likely to least likely</p>
<s>5) Allow users to add new words to the dictionary</s>
<s>6) Allow users to add definitions for their new words</s>
<s>7) Allow users to update definitions for existing words</s>
<s>8) Display the time taken for the program to unscramble a word</s>

