const FPS = 60;

particleCanvas.width = 800;
particleCanvas.height = 800;
const ctx = particleCanvas.getContext("2d");

const particleArray = []

function frame() {
    const deltaTime = 1 / FPS;
    //Code for rendering goes here

    clear()
    particleArray[particleArray.length]= new Particle(ctx, deltaTime);
    for (let i = particleArray.length - 1; i >= 0; i--) {
        particleArray.update();
    }

    //Code for rendering goes here

    setTimeout(frame, 1000 / FPS);
}

setTimeout(frame, 1000 / FPS);

//Code for rendering goes here

function clear(){
    ctx.fillStyle = "#101010";
    ctx.fillRect(0,0,particleCanvas.width, particleCanvas.height);
}

function point({x, y}) {
    const s = 20;
    ctx.fillStyle = "green";
    ctx.fillRect(x - s/2, y - s/2, s, s)
}

class Particle{
    constructor(x, y){
        this.x = x;
        this.y = y;

        this.velX = Math.random() *10;
        this.velY = Math.random() *10;
    }

    update(dt){
        this.x += this.velX*dt;
        this.y += this.velY*dt;
    }

    draw(){

    }
}

//Code for rendering goes here