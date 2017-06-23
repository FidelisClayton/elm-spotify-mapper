const Shepherd = require("tether-shepherd")

let tour = new Shepherd.Tour({
  defaults: {
    classes: 'shepherd-theme-arrows'
  }
})

const updateStoredSteps = stepId => {
  const previousSteps = JSON.parse(localStorage.getItem('steps')) || []
  const newSteps = removeDuplicated([ ...previousSteps, stepId ])

  localStorage.setItem('steps', JSON.stringify(newSteps))

  return newSteps
}

const removeDuplicated = items => {
  return items.reduce((previous, current) => {
    return previous.filter(item => item === current).length > 0
      ? previous
      : [ ...previous, current ]
  }, [])
}

const getStoredSteps = () => JSON.parse(localStorage.getItem('steps')) || []
const stepDone = (step, steps) => steps.filter(id => step.id === id).length > 0

const elementAvailable = step => {
  const attachTo = step.attachTo.split(" ")
  const attachToLength = attachTo.length

  const selector = attachTo.slice(0, attachToLength - 1).join(" ")

  return document.querySelector(selector) !== null
}

const onInitTutorial = steps => {
  steps = steps || []

  const storedSteps = getStoredSteps()

  steps.forEach(step => {
    if (!stepDone(step, storedSteps) && elementAvailable(step))
      tour.addStep(step.id, step)
  })

  tour.start()
}

const onAddSteps = steps => {
  steps = steps || []

  const storedSteps = getStoredSteps()

  steps.forEach(step => {
    if (!stepDone(step, storedSteps))
      tour.addStep(step.id, step)
  })

  setTimeout(() => {
    if (steps.length >= 1)
      tour.next();
  }, 1000)
}

const onNextStep = () => tour.next()

tour.on('show', event => {
  event.step.on('hide', () => {
    updateStoredSteps(event.step.id)
  })
})

module.exports = function(app) {
  app.ports.initTutorial.subscribe(onInitTutorial)
  app.ports.addSteps.subscribe(onAddSteps)
  app.ports.nextStep.subscribe(onAddSteps)
}
