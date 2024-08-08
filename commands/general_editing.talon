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
(mache rückgängig | nop) [<user.repeat_count_small>]:
    edit.undo()
    repeat(repeat_count_small or 0)
nop das: user.clear_last_phrase()
stelle wieder her: edit.redo()

#######################################################################
## Navigation
#######################################################################
# TODO: use new navigation grammar instead? (requires recent version of community)
# small movements
(geh | gehe) [<user.repeat_count_small>] (hoch | rauf):
    edit.up()
    repeat(repeat_count_small or 0)
(geh | gehe) [<user.repeat_count_small>] runter:
    edit.down()
    repeat(repeat_count_small or 0)
(geh | gehe) [<user.repeat_count_small>] links:
    edit.left()
    repeat(repeat_count_small or 0)
(geh | gehe) [<user.repeat_count_small>] rechts:
    edit.right()
    repeat(repeat_count_small or 0)

# large movements
(spring | springe) [<user.repeat_count_small>] links:
    edit.word_left()
    repeat(repeat_count_small or 0)
(spring | springe) [<user.repeat_count_small>] rechts:
    edit.word_right()
    repeat(repeat_count_small or 0)
(spring | springe) zeilen anfang: edit.line_start()
(spring | springe) ganz links: edit.line_start()
(spring | springe) heimat: edit.line_start()
(spring | springe) bend: edit.line_start()
(spring | springe) zeilenende: edit.line_end()
(spring | springe) push: edit.line_end()
(spring | springe) ganz rechts: edit.line_end()
(spring | springe) lend: edit.line_end()

((spring | springe) | (geh | gehe)) (hoch | rauf | runter | links | rechts) <user.number_small>:
    app.notify("'BEWEGUNG RICHTUNG ANZAHL' order is deprecated.\nUse 'BEWEGUNG ANZAHL RICHTUNG' order instead (same as community 'go three left')!")

#######################################################################
## Selecting Text
#######################################################################
auswählen [<user.repeat_count_small>] links:
    edit.extend_word_left()
    repeat(repeat_count_small or 0)
auswählen [<user.repeat_count_small>] rechts:
    edit.extend_word_right()
    repeat(repeat_count_small or 0)

#######################################################################
## Deleting Text
#######################################################################
# "weg" should only be recognized when it's not part of a sentence or
# using token for counting the number of "weg"s
^<user.weg> [{user.count}]$: user.smart_delete(weg, "{count or '1'}")
löschtaste: key("backspace")

lösche [<user.repeat_count_small>] links:
    edit.extend_word_left()
    repeat(repeat_count_small or 0)
    edit.delete()
lösche ganz links:
    edit.extend_line_start()
    edit.delete()
(entferne) links:
    edit.delete()
lösche [<user.repeat_count_small>] rechts:
    edit.extend_word_right()
    repeat(repeat_count_small or 0)
    edit.delete()
lösche ganz rechts:
    edit.extend_line_end()
    edit.delete()
(entferne) rechts:
    key("delete")
lösche zeile: edit.delete_line()

(lösche | auswählen) (links | rechts) <user.number_small>:
    app.notify("'AKTION RICHTUNG ANZAHL' order is deprecated.\nUse 'AKTION ANZAHL RICHTUNG' order instead (for example 'lösche 3 rechts')!")
