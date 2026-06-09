export class Point {
    readonly x: number;
    readonly y: number;
    readonly z: number;

    constructor(
        x: number,
        y: number,
        z: number
    ) {
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
}
