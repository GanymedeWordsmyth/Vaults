Another common pw gen technique is to follow patterns on the keyboard. These pws are called keyboard walks.

The help menu shows the various options supported by `kwp`. The pattern is based on the geographical directions a user could choose on the keyboard, e.g. `--keywalk-west` is used to specify movement towards the west from the base char.
The program takes in base chars as a parameter, which is the char set the pattern will start with. Next, it needs a keymap, which maps the locations of keys on language-specific keyboard layouts. The final option is used to specify the route to be used. A route is a pattern to be followed by the pws. It defines how pws will be formed, starting from the base chars. e.g. the route `222` would denote the path `2 * EAST + 2 * SOUTH + 2 * WEST` from the base char. If the base char is considered to be `T`, then the password gen'd by the route would be `TYUJNBV` on a US keymap. For further information, refer to the [README](https://github.com/hashcat/kwprocessor#routes) for kwprocessor.
```example
$ kwp -s 1 basechars/full.base keymaps/en-us.keymap  routes/2-to-10-max-3-direction-changes.route
```
The command above generates words with characters reachable while holding shift (`-s`), using the full base, the standard en-us keymap, and 3 direction changes route.