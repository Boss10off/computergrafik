import * as THREE from "three";
import { Vector3 } from "three";
import { Triangulator } from "./triangulator/Triangulator";
import GUI from "lil-gui";
// import { ColorGUIHelper } from "./util/ColorGUIHelper";
import { OrbitControls } from "three/examples/jsm/Addons.js";

const gui = new GUI();

const points: Vector3[] = [
  new Vector3(0, 0, 0),
  new Vector3(1, 1, 0),
  new Vector3(1, 0, 0),
  new Vector3(0.5, 0.25, 0),
  new Vector3(2, 3, 0),
  new Vector3(-3, 0.9, 0)
]
const pointsFolder: Map<Vector3, GUI> = new Map();

const addItem = (newItem: Vector3) => {
  points.push(newItem);
  const folder = gui.addFolder(points.indexOf(newItem).toString());
  folder.add(newItem, "x").name("x");
  folder.add(newItem, "y").name("y");
  folder.add(newItem, "z").name("z");
  folder.add({
    remove: () => removeItem(newItem)
  }, "remove").name("Remove")
  pointsFolder.set(newItem, folder);
}

const removeItem = (item: Vector3) => {
  const index = points.indexOf(item);
  if (index === -1) return;
  points.splice(index, 1);
  const folder = pointsFolder.get(item);
  if (folder) {
    folder.destroy();
  }
  pointsFolder.delete(item);
}

points.forEach(addItem);
gui.add({
  add: () => addItem(new Vector3(0, 0, 0))
}, "add").name("Add Position");

const createLights = (): THREE.Light => {
  const skyColor = 0xB1E1FF;
  const groundColor = 0xB97A20;
  const intensity = 1;
  return new THREE.HemisphereLight(skyColor, groundColor, intensity);
}

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

//const light = new THREE.AmbientLight(0xFFFFFF, 1);
const light = createLights();
scene.add(light);

// const geometry = new THREE.BoxGeometry(1, 1, 1);
// const material = new THREE.MeshStandardMaterial({
//   color: 0x00ff00
// });
// const cube = new THREE.Mesh(geometry, material);
// scene.add(cube);

const triangulation = Triangulator.triangulate(points);
let triagulatedMesh = triangulation.toMesh();
scene.add(triagulatedMesh);

// gui.addColor(new ColorGUIHelper(light, "color"), "value").name("color");
// gui.add(light, "intensity", 0, 5, 0.01);
// gui.add(points[0], "y", -5, 5, 0.05);

camera.position.z = 5;

const controls = new OrbitControls(camera, renderer.domElement);
controls.update();

function animate(time: number) {
  //cube.rotation.x = time / 2000;
  //cube.rotation.y = time / 1000;

  triagulatedMesh.geometry.dispose();
  triagulatedMesh.geometry = Triangulator.triangulate(points).toGeometry();

  controls.update();
  renderer.render(scene, camera);
}

renderer.setAnimationLoop(animate);
