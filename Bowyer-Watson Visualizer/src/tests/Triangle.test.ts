import { Vector3 } from "three";
import { expect, test } from "vitest";
import { Triangle } from "../data/Triangle";
import { Edge } from "../data/Edge";
import { tri } from "three/src/nodes/TSL.js";

test('create triangle from [(0, 0), (1, 0), (1, 1)] and expect point (1, 0) to be a vertex of the triangle', () => {
    const targetPoint: Vector3 = new Vector3(1, 0, 0);
    const triangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0)
    );
    expect(triangle.containsPoint(targetPoint)).toBe(true);
});

test('create triangle from [(0, 0), (1, 0), (1, 1)] and expect edge [(0, 0), (1, 0)] to be an edge of the triangle', () => {
    const targetEdge: Edge = new Edge(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0)
    );
    const triangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0)
    );
    expect(triangle.containsEdge(targetEdge)).toBe(true);
});

test('create triangle from edge [(0, 0), (1 ,0)] and point (1, 1) and expect triangle to be [(0, 0), (1, 0), (1, 1)]', () => {
    const expectedTriangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0) 
    )
    const creationEdge: Edge = new Edge(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0)
    ); 
    const creationPoint: Vector3 = new Vector3(1, 1, 0);
    const triangle: Triangle = Triangle.fromEdgeAndPoint(creationEdge, creationPoint);
    expect(triangle).toEqual(expectedTriangle);
});
