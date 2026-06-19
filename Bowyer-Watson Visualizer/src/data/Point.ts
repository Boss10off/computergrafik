import { Vector3 } from "three";
import { Instantiable } from "./Instantiable";

export class Point extends Instantiable<Point> {
    readonly x: number;
    readonly y: number;
    readonly z: number;

    constructor(
        x: number,
        y: number,
        z: number
    ) {
        super();
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public toString(): string {
        return `(${this.x}, ${this.y}, ${this.z})`
    }

    public equals(other: Point): boolean {
        return this.x == other.x && this.y == other.y && this.z == other.z; 
    }

    public clone(): Point {
        return new Point(
            this.x, this.y, this.z
        );
    }

    public toThreeVector3(): Vector3 {
        return new Vector3(
            this.x, this.y, this.z
        );
    }
}
