# LoopLens

Desktop app that steps through code so you can *see* what each line does.

Built for the moment before a real debugger helps — when you still need a
mental model of control flow and state. First showcase: a Python `for` loop.

```python
for i in range(3):
    print(i)
```

## What you see

| Panel | Purpose |
| --- | --- |
| **Source** | Active line highlighted as execution moves |
| **Loop machine** | `range → next? → assign i → body → exit` |
| **Sequence** | The values in `range(3)` with a moving cursor |
| **Variables** | Live `i` (pulses when it changes) |
| **Console** | `print` output as it appears |
| **Narration** | Plain-English explanation of the current step |

Controls: **Space** play/pause · **← →** step · **R** reset · speed button · scrubber

## Run

Requires [Flutter](https://flutter.dev) with desktop enabled.

```bash
flutter pub get
flutter run -d linux    # or macos / windows
```

## Why curated traces

LoopLens uses hand-authored execution steps, not a live Python interpreter.
That keeps every transition explicit and beginner-accurate. Pasting arbitrary
code is intentionally out of scope for now.

## Project layout

```
lib/
  main.dart                 # workspace shell
  data/python_for_loop.dart # example + step trace
  models/                   # ExecutionStep, CodeExample
  state/player_controller.dart
  theme/app_theme.dart
  widgets/                  # panels + transport controls
```

## Contributing

Issues and PRs welcome. Keep examples small, make every state change obvious,
and write explanations for people who are still learning loops.

## License

[MIT](LICENSE)
