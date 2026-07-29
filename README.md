# LoopLens

A small desktop app that steps through a `for` loop so you can see the
classic shape:

```text
for (  start once  ;  check  ;  step  )
              int i = 0 ;  i < 3 ;  i++
         { body }
```

One focus at a time: the active slot lights up, squares show where `i` is,
and a single sentence explains the moment.

## Examples

- **C++** — `for (int i = 0; i < 3; i++)`
- **Python** — `for i in range(3)` (same squares; “next” instead of `i++`)

## Run

```bash
flutter pub get
flutter run -d linux    # or macos / windows
```

Controls: **← →** or **A D** step (pauses autoplay) · **Space** play/pause · **R** reset

## License

[MIT](LICENSE)
