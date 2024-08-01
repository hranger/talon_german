mode: user.german
language: de_DE
-

^(abkürzung|abkürzungen) <user.acronym>: "{acronym}"

#######################################################################
## Misc Editing
#######################################################################
neue zeile | zeilenumbruch: key("enter")
(nächste Zeile | slap | schlapp):
    edit.line_end()
    key("enter")
neuer absatz:
  key("enter")
  key("enter")

leerzeichen: " "
schrägstrich oder: " / "

Spiegelstrich: " - "

# use knausj insert_between() instead?
in klammern:
    " ()"
    edit.left()

in Anführungszeichen:
    ' ""'
    edit.left()

großgeschrieben | mach groß:
    edit.select_word()
    user.formatters_reformat_selection("CAPITALIZE_FIRST_WORD")

#######################################################################
## Editor Commands
#######################################################################
datei speichern: edit.save()
^speichern$: edit.save()
(kopier|kopiere) das: edit.copy()
schneide das aus: edit.cut()
füge das ein: edit.paste()
(mache rückgängig | nop) [<user.number_small>]:
    edit.undo()
    repeat(number_small - 1)
nop das: user.clear_last_phrase()
stelle wieder her: edit.redo()

#######################################################################
## Navigation
#######################################################################
# to do: use new navigation grammar? (requires recent version of community)
# small movements
(geh | gehe) [<user.number_small>] (hoch | rauf):
    edit.up()
    repeat(number_small - 1)
(geh | gehe) [<user.number_small>] runter:
    edit.down()
    repeat(number_small - 1)
(geh | gehe) [<user.number_small>] links:
    edit.left()
    repeat(number_small - 1)
(geh | gehe) [<user.number_small>] rechts:
    edit.right()
    repeat(number_small - 1)

# large movements
(spring | springe) [<user.number_small>] links:
    edit.word_left()
    repeat(number_small - 1)
(spring | springe) [<user.number_small>] rechts:
    edit.word_right()
    repeat(number_small - 1)
(spring | springe) zeilen anfang: edit.line_start()
(spring | springe) ganz links: edit.line_start()
(spring | springe) heimat: edit.line_start()
(spring | springe) bend: edit.line_start()
(spring | springe) zeilenende: edit.line_end()
(spring | springe) push: edit.line_end()
(spring | springe) ganz rechts: edit.line_end()
(spring | springe) lend: edit.line_end()

#######################################################################
## Selecting Text
#######################################################################
auswählen [<user.number_small>] links:
    edit.extend_word_left()
    repeat(number_small - 1)
auswählen [<user.number_small>] rechts:
    edit.extend_word_right()
    repeat(number_small - 1)

#######################################################################
## Deleting Text
#######################################################################
# "weg" should only be recognized when it's not part of a sentence or
# using token for counting the number of "weg"s
^<user.weg> [{user.count}]$: user.smart_delete(weg, "{count or '1'}")
löschtaste: key("backspace")

lösche [<user.number_small>] links:
    edit.extend_word_left()
    repeat(number_small - 1)
    edit.delete()
lösche ganz links:
    edit.extend_line_start()
    edit.delete()
(entferne) links:
    edit.delete()
lösche [<user.number_small>] rechts:
    edit.extend_word_right()
    repeat(number_small - 1)
    edit.delete()
lösche ganz rechts:
    edit.extend_line_end()
    edit.delete()
(entferne) rechts:
    key("delete")
lösche zeile: edit.delete_line()
