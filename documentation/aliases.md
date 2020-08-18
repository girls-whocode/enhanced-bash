# Aliases

## What is an alias

An alias is a word that you create to perform a command or multiple commands. Although very basic, when you type ```ls``` from the terminal command prompt, normally this would be just a wide list of files and folders in the directory you're currently residing. If you create an alias with ```alias ls=ls --color-auto``` now whenever you type ```ls``` if you are on a terminal that supports color, you will see a colorized version of the same directory. Aliases can be made up of any word, and create any action. Be mindful when creating aliases, they can be just has harmful as helpful.

## Adding a new custom alias

One of the modules built into this application is called mod_addalias.sh, this module gives you the ability to create and add custom aliases to the overrides folder. By default this file is named: or_bash_aliases.sh. See the help docs for the [Add Alias](https://gitlab.com/public_scope/bash-projects/enhanced-bash-system/-/blob/master/documentation/modules/addalias.md) command for more information.

## Removing a custom alias

Removing a custom alias is currently a manual process, and hopefully soon will become an automated one. Currently the only want to remove a custom alias is to go to the enhanced_bash_system/overrides/or_bash_aliases.sh file, and delete the line you wish to remove. Save the file, and press ALT-R to reload the current shell environment.

If you wish to remove a built-in alias, you may delete it from the lib_aliases.sh file, but on the next update it will automatically add the alias back in. To permanently remove an alias from the built-in, add the alias to the or_bash_aliases.sh and set it to ""

## What does Enhanced Bash do with aliases

By default, the built-in aliases are

| Alias | Command | Description |
|---|---|---|
| ls | ls --color=auto | Change directory to colorize automatically <sup>1</sup> |
| ll | ls -alFh --color=auto | List all, in long format, append indicator to entries, make human-readable and colorize automatically <sup>2</sup> |
| la | ls -A --color=auto | List almost all and colorize automatically <sup>3</sup> |
| l  | ls -CF --color=auto | List in columns and append indicator to entries <sup>4</sup> |
| dir | dir --color=auto | Same command as ```l``` but easier for Windows<sup>TM</sup> Users <sup>5</sup> |
| grep | grep --color=auto | Enable color option in grep searches |
| lt | du -sh * | sort -h | Display list of folder and their sizes. On large folder this may take some time. |
| q | exit | A shortened ```exit``` |
| quit | exit | Another way to ```exit``` |
| cls | clear; ls | Clear the screen and show files and folders |
| c | clear | A shortened way to clear the screen |
| h | history | A shortened way to display command history |
| k | kill | A shortened way to kill a process |
| null | /dev/null | An assign value to send to null |
| home | cd ~ | Keyword to send you back to your come directory |
| root | cd / | Ketword to send you back to the root folder |
| resetperms | sudo chmod -R a=r,u+w,a+X | A quick way to reset all folders to 755 and files to 644 recursively |
| nano | &lt;Assigned Editor&gt; | Invoke what ever editor is defined in the .bashrc, if none then vim is used. |
| vi | &lt;Assigned Editor&gt; | Invoke what ever editor is defined in the .bashrc, if none then vim is used. |
| vim | &lt;Assigned Editor&gt; | Invoke what ever editor is defined in the .bashrc, if none then vim is used. |
| edit | &lt;Assigned Editor&gt; | Invoke what ever editor is defined in the .bashrc, if none then vim is used. |
| start | systemctl start | Start a daemon in systemd |
| restart | systemctl restart | Restart a daemon in systemd |
| stop | systemctl stop | Stop a daemon in systemd |
| status | systemctl status | Check the status of a daemon in systemd |
| viewcode | highlight -O ansi --force  | Colorize many types code and scripts. Highlight must be installed |

___
[<img src="https://gitlab.com/public_scope/bash-projects/enhanced-bash-system/-/raw/master/documentation/images/icons/home.png" width="24" />](https://gitlab.com/public_scope/bash-projects/enhanced-bash-system/-/blob/master/documentation/home.mdhelp-topics-menu) [Home](https://gitlab.com/public_scope/bash-projects/enhanced-bash-system/-/blob/master/documentation/home.md)
___

___
>>>
## References

- This document leveraged heavily from the [Markdown-Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).
- The original [Markdown Syntax Guide](https://daringfireball.net/projects/markdown/syntax)
  at Daring Fireball is an excellent resource for a detailed explanation of standard Markdown.
- The detailed specification for CommonMark can be found in the [CommonMark Spec](https://spec.commonmark.org/current/)
- The [CommonMark Dingus](http://try.commonmark.org) is a handy tool for testing CommonMark syntax.
>>>
___