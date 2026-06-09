import type { Triangle } from "../data/Triangle";

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
}