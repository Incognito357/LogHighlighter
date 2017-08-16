# LogHighlighter
Colorize log output from files or stdin
```
log [options] [file file2..fileN]
```
## Options:
```
-n #        Number of lines to tail (default 30) (ignored if reading from stdin)
-p regex    Tail starting from the [n]th last occurrence of the provided regex pattern.
            Defaults to  'INFO\|WARN\|DEBUG\|ERROR\|TRACE\|FATAL' (ignored with stdin or more than 1 file)
-s regex    Search for and highlight occurrences of the provided regex pattern
-f          Do not follow the provided file(s) (ignored if reading from stdin)
```
When called with a file, 'tail -f' is used internally to automatically follow the file for processes writing to that log file in realtime. If you are not interested in realtime updates, using the -f flag will prevent tail from automatically following the file.
If called without a file, input is read from stdin, which is useful when piping the output from one process to log.

## Current Psuedo-Syntax
The current highlighting mode is tailored to highlight log files generated with log4j. I have successfully colored logs with the following patterns:
```
timestamp [TAG   ] [thread][class.name] - Message
timestamp [TAG   ] [thread] [class.name] Message
[TAG   ] timestamp [class.name] - Message
timestamp [TAG   ] [thread-[class.name]]Message
```
The most important part is the TAG, which is the logging level provided by log4j. Anything on a line before the tag is colored in a dark gray by default. The text immediately after the tag is highlighted in a darker shade of the tag's color, up to the point that the message is assumed to begin. There some issues with this, i.e. when there isn't any text between the tag and the message. The message is then highlighted the same color as the tag. Any lines of text after the last found tag is highlighted in a darker shade of the tag (usually stack traces afer an ERROR tag). The tag may or may not have brackets surrounding it, with or without whitespace immediately following the tag before the closing bracket.

## Future plans:
  * Allow colors and tags to be customized
  * Fallback colors to 16-color mode when the terminal being used does not support 256 colors
  * Make `-p` regex more user-friendly
