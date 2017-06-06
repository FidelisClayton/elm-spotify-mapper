const Shepherd = require("tether-shepherd")

let tour = new Shepherd.Tour({
  defaults: {
    classes: 'shepherd-theme-arrows'
  }
});

module.exports = function(app) {
  app.ports.initTutorial.subscribe(steps => {
    steps.forEach(step => {
      if (!step.done)
        tour.addStep(step.id, step);
    })

    tour.start();
  })

  app.ports.addSteps.subscribe(steps => {
    steps.forEach(step => {
      if (!step.done)
        tour.addStep(step.id, step);
    })

    setTimeout(() => {
      tour.next();
    }, 1000);
  })

  app.ports.nextStep.subscribe(() => {
    tour.next();
  })
}
