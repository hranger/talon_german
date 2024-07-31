mode: user.german
language: de_DE
-
#######################################################################
## Talon
#######################################################################
# TODO: create talon setting for location of german settings directory
# Note: This expects a modified edit_text_file() action that accepts a second
# parameter for the working directory the editor should open in.
# If you do not need it, you can just get rid of the second parameter to get
# back knausj edit_text_file()
# TODO: just use local settings directory
bearbeite deutsche wörter:
    user.edit_text_file("/home/markus/.talon/user/knausj_talon/settings/additional_words_de.csv", "/home/markus/.talon/user/talon_german")
    sleep(500ms)
    edit.file_end()
bearbeite deutsche befehle:
    user.edit_text_file("/home/markus/.talon/user/talon_german/german.talon", "/home/markus/.talon/user/talon_german")
    sleep(500ms)
    edit.file_end()

# Disable / enable pop noise. Relies on custom knausj action from me
# no pop
noob | no pop: user.disable_pop()
# yes pop
jazz pop | jessup | jetzt Pop | Jacob: user.enable_pop()
