import { Vector3 } from "three";
import * as THREE from "three";
import { Circumcircle } from "./Circumcircle";
import { Edge } from "./Edge";
import type { Point } from "./Point";
import { Instantiable } from "./Instantiable";

export class Triangle extends Instantiable<Triangle> {
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
        super();
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

    public static fromPoints<T extends Vector3 | Point>(
        a: T,
        b: T,
        c: T
    ): Triangle {
        const p1 = this.toVector3<T>(a);
        const p2 = this.toVector3<T>(b);
        const p3 = this.toVector3<T>(c);
        return new Triangle(
            p1, p2, p3
        );
    }

    private static toVector3<T extends Vector3 | Point>(
        point: T
    ): Vector3 {
        if (point instanceof Vector3) {
            return point
        } else {
            return point.toThreeVector3();
        }
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

    public equals(other: Triangle): boolean {
        return this.a.equals(other.a) && this.b.equals(other.b) && this.c.equals(other.c); 
    }

    public toThreeTriangle(): THREE.Triangle {
        return new THREE.Triangle(
            this.a, this.b, this.c
        )
    }

    public clone(): Triangle {
        return new Triangle(
            this.a, this.b, this.c
        );
    }

    public toString(): string {
        return `
            a: (${this.a.x}, ${this.a.y}, ${this.a.z}),
            b: (${this.b.x}, ${this.a.y}, ${this.a.z}),
            c: (${this.c.x}, ${this.c.y}, ${this.c.z})
        `;
    }

    public toPositionArray(): Float32Array {
        return new Float32Array([
            this.a.x, this.a.y, this.a.z,
            this.b.x, this.b.y, this.b.z,
            this.c.x, this.c.y, this.c.z
        ]);
    }
}
