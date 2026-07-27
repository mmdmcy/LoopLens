# LoopLens

LoopLens is an interactive code visualizer for people who need to see what a program does, not only read what it says. It pairs the active source line with changing variables, data movement, condition results, and console output.

The first release focuses on small, carefully explained JavaScript examples:

- A classic indexed `for` loop
- A running total with `for...of`
- A `while` loop countdown

## Why

Most debuggers assume you already understand the execution model. LoopLens is designed for the step before that: building an intuition for control flow and state.

## Run locally

No package manager, build step, or dependencies are required. Open `index.html`
directly in a browser, or serve the folder with any static file server.

Use the on-screen controls, arrow keys to step, or the space bar to play and pause.

## Scope

LoopLens currently uses curated execution traces. It does not evaluate pasted code. That keeps the visual explanations precise and avoids presenting a partial parser as a complete JavaScript runtime.

Useful next contributions include additional examples, trace authoring tools, accessibility improvements, and support for safely instrumented user code.

## Project structure

- `index.html` contains the page shell
- `styles.css` contains the responsive visual design
- `app.js` contains the examples, execution traces, and player

## Contributing

Issues and pull requests are welcome. Keep examples small, make every state transition explicit, and write explanations for beginners without sacrificing technical accuracy.

## License

[MIT](LICENSE)
