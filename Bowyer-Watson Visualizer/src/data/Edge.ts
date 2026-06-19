import type { Vector3 } from "three";
import { Instantiable } from "./Instantiable";

export class Edge extends Instantiable<Edge> {
    readonly a: Vector3;
    readonly b: Vector3;

    constructor(
        a: Vector3,
        b: Vector3
    ) {
        super();
        this.a = a;
        this.b = b;
    }

    public equals(other: Edge): boolean {
        return this.a.equals(other.a) && this.b.equals(other.b) || this.b.equals(other.a) && this.a.equals(other.b);
    }

    public clone(): Edge {
        return new Edge(
            this.a.clone(), this.b.clone()
        )
    }

    public toString(): string {
        return `[(${this.a.x}, ${this.a.y}, ${this.a.z}), ${this.b.toString()}]`
    }
}
