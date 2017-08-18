function log {
        awkcmd='BEGIN {n="37"}
               function color(a, b, m){
                       na="38;5;242";
                       ma=RSTART;
                       ml=RLENGTH;
                       if (!match(substr($0, ma+ml, length($0)-(ma+ml)), /(.*? - )/, mm) &&
                           !match(substr($0, ma+ml, length($0)-(ma+ml)), /(.*?\])([a-zA-Z0-9])/, mm) &&
                           !match(substr($0, ma+ml, length($0)-(ma+ml)), /( *?[^ ]*?)/, mm)){
                               RSTART=0;
                               RLENGTH=1;
                       }
                       printf("\033[24;%sm%s\033[%sm%s\033[%sm%s\033[%sm%s\n",
                               na, substr($0, 0, ma-1),
                               a, m,
                               b, mm[1],
                               a, mm[2] substr($0, RSTART+RLENGTH+ma+ml-1, length($0)-(RSTART+RLENGTH-2)));
                       n=b;
               }
               !/INFO|ERROR|WARN|DEBUG|TRACE|FATAL|^==>.*<==$/ { print "\033[" n "m" $0 }
               match($0, /(\[?INFO *?\]?)/, m)  { color("36", "38;5;30", m[1]); }
               match($0, /(\[?WARN *?\]?)/, m)  { color("93", "38;5;100", m[1]); }
               match($0, /(\[?ERROR *?\]?)/, m) { color("91", "38;5;124", m[1]); }
               match($0, /(\[?DEBUG *?\]?)/, m) { color("92", "38;5;28", m[1]); }
               match($0, /(\[?TRACE *?\]?)/, m) { color("95", "38;5;90", m[1]); }
               match($0, /(\[?FATAL *?\]?)/, m) { color("4;91", "24;91", m[1]); }
               match($0, /^==>.*<==$/){ print "\033[95m" $0 }'
 
        if [[ "$#" -gt "0" ]]; then
                n="30"
                f="-f"
                search=""
                pat="INFO\|WARN\|DEBUG\|ERROR\|TRACE\|FATAL"
                files=()
 
                while [[ "$#" -gt "0" ]]; do
                        case "$1" in
                                -h)     echo "log [options] file [file..N]"
                                        echo "log can also receive from pipes"
                                        echo "    -n #          Number of lines to tail (default 30) (ignored in pipe mode)"
                                        echo "    -p regex      Tail starting from the [n]th last occurrence of the regex pattern"
                                        echo "                  Defaults to '$pat' (ignored with multiple files)"
                                        echo "    -s regex      Highlight occurrences of pattern if found (supports regex)"
                                        echo "    -f            Do not follow the file when tailed (ignored in pipe mode)"
                                        return
                                        ;;
                                -n)     shift
                                        if [[ "$#" -eq "0" ]]; then
                                                echo "-n: expected a number"
                                                return
                                        fi
                                        n="$1"
                                        ;;
                                -f)     f=""
                                        ;;
                                -p)     shift
                                        if [[ "$#" -eq "0" ]]; then
                                                echo "-p: expected a pattern to start tail from"
                                                return
                                        fi
                                        pat="$1"
                                        ;;
                                -s)     shift
                                        if [[ "$#" -eq "0" ]]; then
                                                echo "-s: expected a pattern to search for"
                                                return
                                        fi
                                        search="$1"
                                        ;;
                                *)      files+=("$1")
                                        ;;
                        esac
                        shift
                done
 
                col=$(printf '\033')
                if [[ ${#files[@]} -gt 0 ]]; then
                        if [[ ${#files[@]} -eq 1 ]]; then
                                n=$(tac "${files[0]}" | grep $pat -m$n -n | tac | head -1 | cut -d : -f 1)
                        fi
                        if [[ -n "$search" ]]; then
                                tail -n $n $f "${file[@]}" | stdbuf -o0 awk "$awkcmd" | sed -E 's/('"$search"')/'"$col"'[7m\1'"$col"'[27m/g'
                        else
                                tail -n $n $f "${files[@]}" | awk "$awkcmd"
                        fi
                else
                        if [[ -n "$search" ]]; then
                                stdbuf -o0 awk "$awkcmd" | sed -E 's/('"$search"')/'"$col"'[7m\1'"$col"'[27m/g'
                        else
                                awk "$awkcmd"
                        fi
                fi
        else
                awk "$awkcmd"
        fi
}