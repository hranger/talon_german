from talon import Context, Module, actions, speech_system
from talon.grammar import Phrase
from talon import app

mod = Module()
mod.mode('german', desc='german language mode')

ctx = Context()
ctx.matches = 'mode: user.german'
ctx.settings = {
	'speech.language': 'de_DE',
	'speech.engine': 'conformer', # could also 'vosk' or 'webspeech' (will need set up)
}

phrase_stack = []
def on_pre_phrase(d):  phrase_stack.append(d)
def on_post_phrase(d): phrase_stack.pop()
speech_system.register('pre:phrase', on_pre_phrase)
speech_system.register('post:phrase', on_post_phrase)

@mod.action_class
class Actions:

	def vosk_recognize_german(phrase: Phrase):
			"""Replay speech from last phrase into german engine"""
			# NOTE: this is pretty much all considered an experimental API
			# and this script is just for demo purposes, for the beta only
			current_phrase = phrase_stack[-1]
			ts = current_phrase['_ts']
			start = phrase.words[0].start - ts
			# NOTE: might have to tweak this depending on engine / model if words
			# get lost or parts of your prefix appear as word (for example getting
			# "an ..." when saying "german ..." given prefix "german")
			tweak_offset = -0.1 # TO DO: extract into a setting
			start = max(0, start + tweak_offset)
			end = phrase.words[-1].end - ts
			samples = current_phrase['samples']
			pstart = int(start * 16_000)
			pend = int(end * 16_000)
			samples = samples[pstart:pend]
			actions.mode.enable("user.german")
			try:
				# NOTE: the following API is completely private and subject to change with no notice
				speech_system._on_audio_frame(samples)
				# Change command history entry
				german_text = actions.user.history_get(0)
				phrase_text = actions.user.history_transform_phrase_text(phrase.words)
				command = actions.user.history_get(1).removesuffix(phrase_text)
				actions.user.history_set(1, command + german_text)
				actions.user.history_set(0, None)
			finally:
				actions.mode.disable("user.german")