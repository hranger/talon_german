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
    user.formatters_reformat_selection("title")

#######################################################################
## Editor Commands
#######################################################################
datei speichern: edit.save()
^speichern$: edit.save()
(kopier|kopiere) das: edit.copy()
schneide das aus: edit.cut()
füge das ein: edit.paste()
mache rückgängig | nop: edit.undo()
mache rückgängig | nop <user.number_small>:
    edit.undo()
    repeat(number_small - 1)
nop das: user.clear_last_phrase()
stelle wieder her: edit.redo()

#######################################################################
## Navigation
#######################################################################
# to do: use new navigation grammar? (requires recent version of community)
# small movements
(geh | gehe) (hoch | rauf): edit.up()
(geh | gehe) (hoch | rauf) <user.number_small>:
    edit.up()
    repeat(number_small - 1)
(geh | gehe) runter: edit.down()
(geh | gehe) runter <user.number_small>:
    edit.down()
    repeat(number_small - 1)
(geh | gehe) links: edit.left()
(geh | gehe) links <user.number_small>:
    edit.left()
    repeat(number_small - 1)
(geh | gehe) rechts: edit.right()
(geh | gehe) rechts <user.number_small>:
    edit.right()
    repeat(number_small - 1)

# large movements
(spring | springe) links:
    edit.word_left()
(spring | springe) links <user.number_small>:
    edit.word_left()
    repeat(number_small - 1)
(spring | springe) rechts:
    edit.word_right()
(spring | springe) rechts <user.number_small>:
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
auswählen links:
    edit.extend_word_left()
auswählen links <user.number_small>:
    edit.extend_word_left()
    repeat(number_small - 1)
auswählen rechts:
    edit.extend_word_right()
auswählen rechts <user.number_small>:
    edit.extend_word_right()
    repeat(number_small - 1)

#######################################################################
## Deleting Text
#######################################################################
# "weg" should only be recognized when it's not part of a sentence or
# using token for counting the number of "weg"s
^<user.weg> [{user.count}]$: user.smart_delete(weg, "{count or '1'}")
löschtaste: key("backspace")

lösche links:
    edit.extend_word_left()
    edit.delete()
lösche links <user.number_small>:
    edit.extend_word_left()
    repeat(number_small - 1)
    edit.delete()
lösche ganz links:
    edit.extend_line_start()
    edit.delete()
(entferne) links:
    edit.delete()
lösche rechts:
    edit.extend_word_right()
    edit.delete()
lösche rechts <user.number_small>:
    edit.extend_word_right()
    repeat(number_small - 1)
    edit.delete()
lösche ganz rechts:
    edit.extend_line_end()
    edit.delete()
(entferne) rechts:
    key("delete")
lösche zeile: edit.delete_line()
