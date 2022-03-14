# Libraries
___
[<img src="images/icons/home.png" width="24" />](/documentation/home.md) [Home](/documentation/home.md)
___

<div class="message  message--information">
  <b>MODIFYING FILES:</b> Making changes to these files is not recommended. If you would like make changes, see the Over Rides section.
</div>

* [lib_aliases](/documentation/libraries/lib_aliases.md)
* [lib_colors](/documentation/libraries/lib_colors.md)
* [lib_ebdirectories](/documentation/libraries/lib_ebdirectories.md)
* [lib_exports](/documentation/libraries/lib_exports.md)
* [lib_printTable](/documentation/libraries/lib_printTable.md)
* [lib_sharedFunctions](/documentation/libraries/lib_sharedFunctions.md)
* [lib_text](/documentation/libraries/lib_text.md)
* [lib_update](/documentation/libraries/lib_update.md)
* [lib_utils](/documentation/libraries/lib_utils.md)
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

<style>
  .message {
    background-color: white;
    width: calc(100% - 3em);
    max-width: 24em;
    padding: 1em 1em 1em 1.5em;
    border-left-width: 6px;
    border-left-style: solid;
    border-radius: 3px;
    position: relative;
    line-height: 1.5;
    margin-bottom: 5px;
  }

  .message + .message {
    margin-top: 2em;
  }

  .message:before {
    color: white;
    width: 2em;
    height: 2em;
    position: absolute;
    top: 2em;
    left: -3px;
    border-radius: 50%;
    transform: translateX(-50%);
    font-weight: bold;
    line-height: 2em;
    text-align: center;
  }

  .message p {
    margin: 0 0 1em;
  }

  .message p:last-child {
    margin-bottom: 0;
  }

  .message--error {
    border-left-color: firebrick;
    background-color: #F4B3AD;
    color: #D40032;
  }
  .message--error:before {
    background-color: firebrick;
    content: "🔥";
  }

  .message--warning {
    border-left-color: darkorange;
    background-color: #FFD68A;
    color: #D18700;
  }
  .message--warning:before {
    background-color: darkorange;
    content: "🔔";
  }

  .message--success {
    border-left-color: darkolivegreen;
    background-color: #8AFF8A;
    color: #007500;
  }

  .message--success:before {
    background-color: darkolivegreen;
    content: "✔️";
  }

  .message--information {
    border-left-color: #035CA3;
    background-color: #62B8FC;
    color: #035CA3;
  }

  .message--information:before {
    background-color: #024376;
    content: "ℹ️";
  }
</style>
