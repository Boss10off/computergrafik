import type { Triangle } from "../data/Triangle";
import * as THREE from "three";

export class Triangulation {
    readonly triangles: Triangle[];

    constructor(
        triangles: Triangle[]
    ) {
        this.triangles = triangles;
    }

    public debugPrint() {
        console.log(`Number of triangles: ${this.triangles.length}`)
        for (const triangle of this.triangles) {
            console.log(`Triangle: A${triangle.a.toString()}, B${triangle.b.toString()}, C${triangle.c.toString()}`)
        }
    }

    public toGeometry(): THREE.BufferGeometry {
        let trianglesAsFloat32Array: Float32Array = new Float32Array();
        for (const triangle of this.triangles) {
            const triangleAsArray = triangle.toPositionArray();
            trianglesAsFloat32Array = this.concatFloat32Array(trianglesAsFloat32Array, triangleAsArray);
        }

        const geometry = new THREE.BufferGeometry();
        geometry.setAttribute("position", new THREE.BufferAttribute(trianglesAsFloat32Array, 3));
        geometry.computeVertexNormals();
        return geometry;
    }

    public toMesh(): THREE.Mesh {
        const geometry = this.toGeometry();
        const material = new THREE.MeshBasicMaterial({
            color: 0xffffff,
            side: THREE.DoubleSide,
            wireframe: true,
        });
        const mesh = new THREE.Mesh(geometry, material);
        return mesh;
    }

    private concatFloat32Array(
        a: Float32Array,
        b: Float32Array
    ): Float32Array {
        const out = new Float32Array(a.length + b.length);
        out.set(a, 0);
        out.set(b, a.length);
        return out;
    }
}