import type { Vector3 } from "three";

export class Edge {
    readonly a: Vector3;
    readonly b: Vector3;

    constructor(
        a: Vector3,
        b: Vector3
    ) {
        this.a = a;
        this.b = b;
    }

    public equals(other: Edge): boolean {
        return this.a.equals(other.a) && this.b.equals(other.b) || this.b.equals(other.a) && this.a.equals(other.b);
    }
}
