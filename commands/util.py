from talon import Module, Context, actions

ctx = Context()
ctx.matches = """
mode: user.german
language: de_DE
"""

mod = Module()


@mod.capture
def repeat_count_small(m) -> int:
    """
    Returns a number count that can be fed directly to repeat.

    In order to run an action n times, it needs to be repeated only (n-1) times.
    """

@ctx.capture("user.repeat_count_small", rule="<user.number_small>")
def repeat_count_small(m) -> int:
    return max(m.number_small - 1, 0)