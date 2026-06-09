import type { Vector3 } from "three";
import * as THREE from "three";
import { Circumcircle } from "./Circumcircle";
import { Edge } from "./Edge";

export class Triangle {
    readonly a: Vector3;
    readonly b: Vector3;
    readonly c: Vector3;
    readonly edges: Edge[];

    readonly circumcircle: Circumcircle;

    constructor(
        a: Vector3,
        b: Vector3,
        c: Vector3
    ) {
        this.a = a;
        this.b = b;
        this.c = c;

        this.edges = [
            new Edge(a, b),
            new Edge(b, c),
            new Edge(c, a)
        ]

        this.circumcircle = Circumcircle.fromPoints(a, b, c);
    }

    public static fromEdgeAndPoint(
        edge: Edge, 
        point: Vector3
    ) {
        return new Triangle(edge.a, edge.b, point);
    }

    public containsPoint(point: Vector3): boolean {
        return this.a.equals(point) || this.b.equals(point) || this.c.equals(point);
    }

    public containsEdge(edge: Edge): boolean {
        return this.edges.some(item => item.equals(edge));
    }

    public equals(triangle: Triangle): boolean {
        return this.a.equals(triangle.a) && this.b.equals(triangle.b) && this.c.equals(triangle.c); 
    }

    public toThreeTriangle(): THREE.Triangle {
        return new THREE.Triangle(
            this.a, this.b, this.c
        )
    }
}
