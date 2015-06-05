Bash Scripting for Dummies
==========================

Introduction
------------

- I'm Mike Hoyle, AKA Peaches
- I like Bash scripting because it allows me to automate and abstract all of the disparate commands I use between projects
- I'm not an expert, so if I say anything that you know to be false, feel free to speak up and educate us all.
- Get to know the audience:
  - Who's heard of Bash?
  - Who's used a little bit of Bash scripting? (sript kiddie-ing, not authored your own)
  - Who's written your own scripts?
  - Who considers themselves profficient or an expert?

Basics
------

- Bash is (you guessed it) A scripting language for the Bash shell
- Anything you can do by typing things at CLI, you can do in bash
- Note: Whitespace is VERY significant. it's mandatory to separate constructs
- open example1.sh
  - comments
  - variable assigmment
    - no spaces!
    - strings by default
    - numbers if valid number
  - concatenation
    - just put the variables together
    - works for strings and numbers
  - echo
    - exactly the CLI command - I use it for output
    - use $ to evaluate the variable, otherwise will just print out string
- open example2.sh
  - branching
    - spacing
    - flags - there are a crapload of them, some unary, some binary
    - useful flags:
      - -z ARG: true if argument is zero-length string
      - -n ARG: true if argument is >0 length string
        - may also use [ "STRING" ]
      - ARG1 == ARG2: string comparison
      - -a ARG: true if file with path ARG exists
      - ARG1 OP ARG2: OP is one of (-eq, -ne, -lt, -le, -gt, -ge). binary arithmetic operators
        - ==, !=, <, <=, >, >= respectively
      - you can negate by preceding the condition with ` ! ` (note the spaces!)
      - cheat sheet at: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
    - semicolon/newline before then
    - when using a string that may have spaces, wrap in ""
  - run command
    - just type it directly
    - you can run the content of a variable using $variable
- running a script
  - 2 ways: `$sh scriptname.sh`
  - or, `$chmod 744 scriptname.sh`, and then you can invoke it with `$./scriptname`
    - this sets it's permission to executable for you, and readable to everyone else
- add `set -x` to the top of a script to have it print out each command as it's run
  - very helpful for debugging

My Scripts
----------

- There are a few things I do in every project (magnum-ui, evolve, masterlock)
  - update the repo
  - push changes to github
  - run in foreground
  - run tests
- I also have a 'settings' file that I call .fgrc
  - named because the first script I made was my foreground one, called fg.sh
- We'll look at my scripts for those

update.sh
---------
- updates my master branch, pushes it to my repo, switches back to my branch, installs
- Used to keep my master up to date, should I need to start a new branch
- If I want to immediately rebase my branch onto the updated master, I pass '-r'
- initialize variables
- source settings
  - source executes the file named, so it loads my setting variables
- store result of a command by doing `var=$(command)`
- access command-line arguments by $# where # is the index of the argument
- set my rebase flag
- switches to master, and updates the branch (fetch/merge)
  - I could use pull here, but I prefer using both commands in case something goes fishy halfway through
- invoke another script
  - I think `source` should work here too, but I like the semantic separation
    of running something (invoke) and running a script to load things (source)
- you can drop variables in anywhere you like, be it a string or a command
- rebase if flagged
- run install command

push-upstream.sh
----------------
- used to update my github repo's version of the current branch
- works for new branches too - set up tracking
- initialize / load settings
- reset broken variables to defaults
  - I still haven't totally settled on a way to handle the setting variables defaults well
- store the command into a variable
- run it. The exit code will be stored in the ? variable, accessed via `$?`
- if that push command failed (the remote doesnt exist), create it, and rerun the push
- print an error if there was no repo name
- This one still prints out the error output of the commands, but I don't really know how to fix that
- It's basically an overly elaborate way to say `git push -u mhoyle branchname`, but I can run this
  basically anywhere, and it'll do what I want
- That's the value of these - you can run the same command in different contexts to accomplish
  the same high-level task, but the scripts handle the details

go.sh
-----
- again, initialize and load variables (seeing a pattern?)
- stop the service
  - most of our applications get run automatically in the background, but they don't all use the same supervisor
  - I use `SUPERVISOR` and `SERVICENAME` variables to determine how to kill the bg process
    - Originally, I just had a setting that was a command that killed the process,
      but I don't like putting large commands in the settings file because it results in code duplication
  - Currently knows how to stop supervisorctl, service, and init.d
  - of course, there is a custom fallback option that runs the arbitrary command
  - There are probably serious security implications of just running the contents of an environment variable,
    but I don't know them, and these scripts are not intended to be solid, publishable-to-the-world things
- load the virtualenv, if any
- run the run command
  - This is another case of just running a command from an env var.  The run commands are so various,
    that it doesn't make a lot of sense to have a 'type' variable here.
  - Now that magnum-ui uses make, I may revisit this though.

fg.sh
-----
- This was my first script in this suite
- Originally it did everything in update, push-upstream, and go.
- I'd run it after a reboot or a puppet run to get the project updated and running in fg
- now I split it up into the other scripts so I can run each piece individually if I need to.
- Still keep it around for the original use-case, but it just drives the update and go scripts

runtests.sh
-----------


install.sh
----------












