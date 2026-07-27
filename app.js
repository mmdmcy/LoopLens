const examples = [
  {
    id: 'for-loop', label: 'For loop', eyebrow: 'Walk through a list',
    description: 'See initialization, condition checks, updates, and array access as separate events.',
    code: ["const fruits = ['apple', 'pear', 'plum'];", '', 'for (let i = 0; i < fruits.length; i++) {', '  console.log(fruits[i]);', '}'],
    collectionLabel: 'fruits',
    steps: [
      step(1, 'setup', 'Create the array', 'A list named fruits is placed in memory with three items.', { fruits: ['apple', 'pear', 'plum'] }, [], null, 'fruits'),
      step(3, 'setup', 'Initialize the counter', 'The loop creates i and starts it at 0. Array positions also begin at 0.', { fruits: ['apple', 'pear', 'plum'], i: 0 }, [], 0, 'i'),
      check(3, 'Check the condition', 'Is 0 less than the array length, 3? Yes, so the loop body runs.', 0, 3, true, { fruits: ['apple', 'pear', 'plum'], i: 0 }, [], 0, '<'),
      step(4, 'execute', 'Read index 0', 'fruits[i] means fruits[0], so "apple" is sent to the console.', { fruits: ['apple', 'pear', 'plum'], i: 0 }, ['apple'], 0),
      step(3, 'update', 'Increase the counter', 'i++ adds one. The pointer moves from index 0 to index 1.', { fruits: ['apple', 'pear', 'plum'], i: 1 }, ['apple'], 1, 'i'),
      check(3, 'Check again', '1 is still less than 3, so another iteration begins.', 1, 3, true, { fruits: ['apple', 'pear', 'plum'], i: 1 }, ['apple'], 1, '<'),
      step(4, 'execute', 'Read index 1', 'The item at position 1 is "pear". It joins the console output.', { fruits: ['apple', 'pear', 'plum'], i: 1 }, ['apple', 'pear'], 1),
      step(3, 'update', 'Increase the counter', 'i changes from 1 to 2, moving the pointer to the final item.', { fruits: ['apple', 'pear', 'plum'], i: 2 }, ['apple', 'pear'], 2, 'i'),
      check(3, 'Check again', '2 is less than 3. The loop can run one more time.', 2, 3, true, { fruits: ['apple', 'pear', 'plum'], i: 2 }, ['apple', 'pear'], 2, '<'),
      step(4, 'execute', 'Read index 2', 'The item at position 2 is "plum". Every array item has now been visited.', { fruits: ['apple', 'pear', 'plum'], i: 2 }, ['apple', 'pear', 'plum'], 2),
      step(3, 'update', 'Increase once more', 'i becomes 3. There is no item at index 3, so the next check matters.', { fruits: ['apple', 'pear', 'plum'], i: 3 }, ['apple', 'pear', 'plum'], null, 'i'),
      check(3, 'The condition is false', '3 is not less than 3. The loop stops before trying to read another item.', 3, 3, false, { fruits: ['apple', 'pear', 'plum'], i: 3 }, ['apple', 'pear', 'plum'], null, '<'),
      step(5, 'complete', 'Program complete', 'The loop visited each item exactly once and then exited.', { fruits: ['apple', 'pear', 'plum'], i: 3 }, ['apple', 'pear', 'plum']),
    ],
  },
  {
    id: 'running-total', label: 'Running total', eyebrow: 'Build a value over time',
    description: 'Watch an accumulator remember its value while a loop moves through an array.',
    code: ['const numbers = [4, 7, 2, 5];', 'let total = 0;', '', 'for (const number of numbers) {', '  total += number;', '}', '', 'console.log(total);'],
    collectionLabel: 'numbers',
    steps: [
      step(1, 'setup', 'Create the numbers', 'Four numbers are stored together in an array.', { numbers: [4, 7, 2, 5] }, [], null, 'numbers'),
      step(2, 'setup', 'Create the accumulator', 'total starts at zero. It will remember the running sum.', { numbers: [4, 7, 2, 5], total: 0 }, [], null, 'total'),
      step(4, 'execute', 'Take the first number', 'The loop reads 4 and stores it in the temporary variable number.', { numbers: [4, 7, 2, 5], total: 0, number: 4 }, [], 0, 'number'),
      step(5, 'update', 'Add 4 to total', 'total += number is shorthand for total = total + number.', { numbers: [4, 7, 2, 5], total: 4, number: 4 }, [], 0, 'total'),
      step(4, 'execute', 'Take the next number', 'The loop advances and number now holds 7.', { numbers: [4, 7, 2, 5], total: 4, number: 7 }, [], 1, 'number'),
      step(5, 'update', 'Add 7 to total', 'The previous total, 4, and the current number, 7, make 11.', { numbers: [4, 7, 2, 5], total: 11, number: 7 }, [], 1, 'total'),
      step(4, 'execute', 'Take the next number', 'The loop advances to 2.', { numbers: [4, 7, 2, 5], total: 11, number: 2 }, [], 2, 'number'),
      step(5, 'update', 'Add 2 to total', '11 plus 2 becomes 13.', { numbers: [4, 7, 2, 5], total: 13, number: 2 }, [], 2, 'total'),
      step(4, 'execute', 'Take the final number', 'The last value, 5, enters the temporary variable.', { numbers: [4, 7, 2, 5], total: 13, number: 5 }, [], 3, 'number'),
      step(5, 'update', 'Add 5 to total', '13 plus 5 becomes 18. The array has no more values.', { numbers: [4, 7, 2, 5], total: 18, number: 5 }, [], 3, 'total'),
      step(8, 'complete', 'Print the result', 'The completed running total is sent to the console.', { numbers: [4, 7, 2, 5], total: 18, number: 5 }, ['18']),
    ],
  },
  {
    id: 'while-loop', label: 'While loop', eyebrow: 'Repeat while true',
    description: 'Follow a countdown and see why the loop stops exactly when count reaches zero.',
    code: ['let count = 3;', '', 'while (count > 0) {', '  console.log(count);', '  count--;', '}', '', "console.log('Liftoff!');"],
    steps: [
      step(1, 'setup', 'Set the starting value', 'count begins at 3 and is stored in memory.', { count: 3 }, [], null, 'count'),
      check(3, 'Check before running', '3 is greater than 0, so the while loop body can run.', 3, 0, true, { count: 3 }, [], null, '>'),
      step(4, 'execute', 'Print 3', 'The current value is sent to the console.', { count: 3 }, ['3']),
      step(5, 'update', 'Decrease count', 'count-- subtracts one, changing 3 to 2.', { count: 2 }, ['3'], null, 'count'),
      check(3, 'Check again', '2 is greater than 0, so the loop continues.', 2, 0, true, { count: 2 }, ['3'], null, '>'),
      step(4, 'execute', 'Print 2', 'The new current value is sent to the console.', { count: 2 }, ['3', '2']),
      step(5, 'update', 'Decrease count', 'count changes from 2 to 1.', { count: 1 }, ['3', '2'], null, 'count'),
      check(3, 'Check again', '1 is greater than 0. This is the final successful check.', 1, 0, true, { count: 1 }, ['3', '2'], null, '>'),
      step(4, 'execute', 'Print 1', 'The final positive value is sent to the console.', { count: 1 }, ['3', '2', '1']),
      step(5, 'update', 'Decrease count', 'count becomes 0.', { count: 0 }, ['3', '2', '1'], null, 'count'),
      check(3, 'Stop the loop', '0 is not greater than 0, so the body is skipped.', 0, 0, false, { count: 0 }, ['3', '2', '1'], null, '>'),
      step(8, 'complete', 'Print "Liftoff!"', 'Execution continues after the loop and prints the final message.', { count: 0 }, ['3', '2', '1', 'Liftoff!']),
    ],
  },
]

function step(line, phase, title, explanation, variables, output, focusIndex = null, changed = null) {
  return { line, phase, title, explanation, variables, output, focusIndex, changed }
}

function check(line, title, explanation, left, right, result, variables, output, focusIndex, operator) {
  return { ...step(line, 'check', title, explanation, variables, output, focusIndex), comparison: { left, operator, right, result } }
}

const state = { exampleIndex: 0, stepIndex: 0, playing: false, speedIndex: 1, timer: null }
const speeds = [1400, 850, 450]

function escapeHtml(value) {
  const entities = { '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;' }
  return String(value).replace(/[&<>'"]/g, character => entities[character])
}

function icon(name) {
  const paths = {
    github: '<path d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3.3-.4 6.8-1.6 6.8-7A5.4 5.4 0 0 0 19.4 4 5 5 0 0 0 19.3.5S18.2.1 15 1.8a13.4 13.4 0 0 0-7 0C4.8.1 3.7.5 3.7.5A5 5 0 0 0 3.6 4a5.4 5.4 0 0 0-1.4 3.7c0 5.3 3.5 6.5 6.8 7A4.8 4.8 0 0 0 8 18v4"/><path d="M8 19c-3 .9-3-1.5-4-2"/>',
    play: '<polygon points="6 3 20 12 6 21 6 3"/>',
    pause: '<rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/>',
    restart: '<path d="M3 12a9 9 0 1 0 3-6.7L3 8"/><path d="M3 3v5h5"/>',
    left: '<path d="m15 18-6-6 6-6"/>',
    right: '<path d="m9 18 6-6-6-6"/>',
    check: '<path d="m20 6-11 11-5-5"/>',
    terminal: '<path d="m4 17 6-6-6-6"/><path d="M12 19h8"/>',
  }
  return `<svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${paths[name]}</svg>`
}

function formatValue(value) {
  if (Array.isArray(value)) return `[${value.join(', ')}]`
  if (typeof value === 'string') return `"${value}"`
  return String(value)
}

function render() {
  const example = examples[state.exampleIndex]
  const current = example.steps[state.stepIndex]
  const isLast = state.stepIndex === example.steps.length - 1
  const collection = Object.entries(current.variables).find(([, value]) => Array.isArray(value))

  document.querySelector('#root').innerHTML = `
    <main>
      <header class="site-header">
        <a class="brand" href="#top" aria-label="LoopLens home"><span class="brand-mark"><span></span></span><span>LoopLens</span></a>
        <p class="header-note">An open-source code visualizer</p>
        <a class="github-link" href="https://github.com/mmdmcy/LoopLens" target="_blank" rel="noreferrer">${icon('github')} <span>View source</span></a>
      </header>
      <section class="hero" id="top">
        <div class="hero-kicker">&#10022; Code, slowed down</div>
        <h1>Don't just read code.<br><em>Watch it think.</em></h1>
        <p>Step inside each instruction. See values change, conditions decide, and loops move through data one moment at a time.</p>
        <div class="hint"><kbd>Space</kbd> play / pause <span>&middot;</span> <kbd>&larr;</kbd><kbd>&rarr;</kbd> step</div>
      </section>
      <section class="example-picker" aria-label="Choose a code example">
        ${examples.map((item, index) => `<button class="example-tab ${index === state.exampleIndex ? 'active' : ''}" data-example="${index}"><span>0${index + 1}</span><strong>${item.label}</strong></button>`).join('')}
      </section>
      <section class="lesson-heading"><div><span class="section-label">${example.eyebrow}</span><h2>${example.label}</h2></div><p>${example.description}</p></section>
      <section class="visualizer" aria-label="Code execution visualizer">
        <div class="code-panel">
          <div class="panel-bar"><span><i class="dot coral"></i><i class="dot gold"></i><i class="dot green"></i></span><span class="file-name">example.js</span><span class="language">JavaScript</span></div>
          <div class="code-lines" aria-label="Source code">${example.code.map((line, index) => `<div class="code-line ${current.line === index + 1 ? 'active' : ''}"><span class="line-number">${index + 1}</span><span class="execution-arrow">&rsaquo;</span><code>${escapeHtml(line) || ' '}</code></div>`).join('')}</div>
          <div class="now-card"><div class="phase-badge ${current.phase}">&#9889; ${current.phase}</div><h3>${current.title}</h3><p>${current.explanation}</p>
            ${current.comparison ? `<div class="comparison ${current.comparison.result ? 'true' : 'false'}"><code>${current.comparison.left} ${escapeHtml(current.comparison.operator)} ${current.comparison.right}</code>${icon('right')}<strong>${current.comparison.result}</strong></div>` : ''}
          </div>
        </div>
        <div class="stage-panel">
          <div class="panel-bar"><span class="stage-title"><span class="pulse ${state.playing ? 'live' : ''}"></span> Execution stage</span><span class="step-count">Step ${state.stepIndex + 1} / ${example.steps.length}</span></div>
          <div class="stage-content">
            ${collection ? `<section class="data-section"><div class="mini-heading"><span>DATA IN MEMORY</span><code>${example.collectionLabel}</code></div><div class="array-visual">${collection[1].map((item, index) => `<div class="array-cell ${current.focusIndex === index ? 'focused' : ''}">${current.focusIndex === index ? '<span class="pointer">i &darr;</span>' : ''}<span class="index">${index}</span><strong>${item}</strong></div>`).join('')}</div></section>` : ''}
            <section class="memory-section"><div class="mini-heading"><span>VARIABLES</span><span>live memory</span></div><div class="variables-grid">${Object.entries(current.variables).filter(([, value]) => !Array.isArray(value)).map(([name, value]) => `<div class="variable-card ${current.changed === name ? 'changed' : ''}"><code>${name}</code><strong>${formatValue(value)}</strong>${current.changed === name ? '<span>changed</span>' : ''}</div>`).join('') || '<p class="empty-state">No single values yet.</p>'}</div></section>
            <section class="output-section"><div class="mini-heading"><span>${icon('terminal')} CONSOLE</span><span>${current.output.length} lines</span></div><div class="console">${current.output.length ? current.output.map((line, index) => `<div class="${index === current.output.length - 1 ? 'new-output' : ''}"><span>&rsaquo;</span>${escapeHtml(line)}</div>`).join('') : '<span class="console-empty">Waiting for output...</span>'}</div></section>
          </div>
        </div>
      </section>
      <section class="controls" aria-label="Playback controls">
        <button class="icon-button" data-action="restart" aria-label="Restart">${icon('restart')}</button>
        <button class="step-button" data-action="back" ${state.stepIndex === 0 ? 'disabled' : ''}>${icon('left')} Back</button>
        <button class="play-button" data-action="play">${icon(state.playing ? 'pause' : isLast ? 'restart' : 'play')} ${state.playing ? 'Pause' : isLast ? 'Replay' : 'Play'}</button>
        <button class="step-button" data-action="next" ${isLast ? 'disabled' : ''}>Next ${icon('right')}</button>
        <div class="speed-control" aria-label="Playback speed">${speeds.map((_, index) => `<button data-speed="${index}" class="${state.speedIndex === index ? 'active' : ''}">${index + 1}x</button>`).join('')}</div>
        <div class="progress-track" aria-hidden="true"><span style="width:${((state.stepIndex + 1) / example.steps.length) * 100}%"></span></div>
      </section>
      <section class="principles"><div class="section-label">What you're seeing</div><div class="principle-grid">${[['Line', 'The glowing line is the instruction the computer is handling now.'], ['State', "Variables are the computer's memory. A flash means a value just changed."], ['Effect', 'The stage shows the real consequence: movement, decisions, and output.']].map((item, index) => `<article><span>0${index + 1}</span>${icon('check')}<h3>${item[0]}</h3><p>${item[1]}</p></article>`).join('')}</div></section>
      <footer><a class="brand" href="#top"><span class="brand-mark"><span></span></span><span>LoopLens</span></a><p>Built for the moment code finally clicks.</p><a href="https://github.com/mmdmcy/LoopLens" target="_blank" rel="noreferrer">${icon('github')} MIT licensed</a></footer>
    </main>`
  bindControls()
}

function stop() {
  state.playing = false
  clearTimeout(state.timer)
}

function schedule() {
  clearTimeout(state.timer)
  if (!state.playing) return
  const example = examples[state.exampleIndex]
  if (state.stepIndex >= example.steps.length - 1) {
    stop()
    render()
    return
  }
  state.timer = setTimeout(() => {
    state.stepIndex++
    render()
    schedule()
  }, speeds[state.speedIndex])
}

function changeStep(amount) {
  const last = examples[state.exampleIndex].steps.length - 1
  state.stepIndex = Math.max(0, Math.min(last, state.stepIndex + amount))
  render()
}

function togglePlay() {
  const last = examples[state.exampleIndex].steps.length - 1
  if (state.stepIndex === last) state.stepIndex = 0
  state.playing = !state.playing
  render()
  schedule()
}

function bindControls() {
  document.querySelectorAll('[data-example]').forEach(button => button.addEventListener('click', () => {
    stop()
    state.exampleIndex = Number(button.dataset.example)
    state.stepIndex = 0
    render()
  }))
  document.querySelector('[data-action="restart"]').addEventListener('click', () => { stop(); state.stepIndex = 0; render() })
  document.querySelector('[data-action="back"]').addEventListener('click', () => changeStep(-1))
  document.querySelector('[data-action="next"]').addEventListener('click', () => changeStep(1))
  document.querySelector('[data-action="play"]').addEventListener('click', togglePlay)
  document.querySelectorAll('[data-speed]').forEach(button => button.addEventListener('click', () => {
    state.speedIndex = Number(button.dataset.speed)
    render()
    schedule()
  }))
}

document.addEventListener('keydown', event => {
  if (event.key === 'ArrowRight') changeStep(1)
  if (event.key === 'ArrowLeft') changeStep(-1)
  if (event.key === ' ') {
    event.preventDefault()
    togglePlay()
  }
})

render()
