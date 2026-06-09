import * as THREE from "three";
import { Vector3 } from "three";
import { Triangulator } from "./triangulator/Triangulator";

const points: Vector3[] = [
  new Vector3(0, 0, 0),
  new Vector3(1, 1, 0),
  new Vector3(1, 0, 0),
  new Vector3(0.5, 0.25, 0)
]

const triangulation = Triangulator.triangulate(points);
triangulation.debugPrint();

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({
  color: 0x00ff00
});
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

function animate(time: number) {
  cube.rotation.x = time / 2000;
  cube.rotation.y = time / 1000;

  renderer.render(scene, camera);
}

renderer.setAnimationLoop(animate);
