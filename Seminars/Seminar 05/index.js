const FPS = 60;

particleCanvas.width = 800;
particleCanvas.height = 800;
const ctx = particleCanvas.getContext("2d");

function frame() {
    const deltaTime = 1 / FPS;

    //Code for rendering goes here

    setTimeout(frame, 1000 / FPS);
}

setTimeout(frame, 1000 / FPS);
