mode: user.german
language: de_DE
-

^geh komplett schlafen [<phrase>]$:
    user.switcher_hide_running()
    user.history_disable()
    user.help_hide()
    user.mouse_sleep()
    speech.disable()
    user.engine_sleep()
    skip()

^geh schlafen [<phrase>]$:
    speech.disable()
    skip()

^talon wake | wach auf$:
    speech.enable()
    skip()