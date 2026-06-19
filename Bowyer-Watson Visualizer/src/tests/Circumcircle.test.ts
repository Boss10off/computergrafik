import { expect, test } from "vitest";
import { Circumcircle } from "../data/Circumcircle";
import { Vector3 } from "three";
import { Triangle } from "../data/Triangle";

test('create circumcircle from triangle [(0, 0), (1, 0), (1, 1)] and expect center at (0.5, 0.5)', () => {
    const expectedCenter = new Vector3(0.5, 0.5, 0)
    const triangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0)
    )
    const circumcircle = Circumcircle.fromTriangle(triangle);
    expect(circumcircle.center).toEqual(expectedCenter);
});

test('create circumcircle from triangle [(0, 0), (1, 0), (1, 1)] and expect radius close to 0.707', () => {
    const expectedRadius = 0.707
    const triangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0)
    )
    const circumcircle = Circumcircle.fromTriangle(triangle);
    expect(circumcircle.radius).toBeCloseTo(expectedRadius);
});

test('create circumcircle from points [(0, 0), (1, 0), (1, 1)] and expect center at (0.5, 0.5)', () => {
    const expectedCenter = new Vector3(0.5, 0.5, 0)
    const p1 = new Vector3(0, 0, 0);
    const p2 = new Vector3(1, 0, 0);
    const p3 = new Vector3(1, 1, 0);
    const circumcircle = Circumcircle.fromPoints(p1, p2, p3);
    expect(circumcircle.center).toEqual(expectedCenter);
});

test('create circumcircle from points [(0, 0), (1, 0), (1, 1)] and expect radius close to 0.707', () => {
    const expectedRadius = 0.707
    const p1 = new Vector3(0, 0, 0);
    const p2 = new Vector3(1, 0, 0);
    const p3 = new Vector3(1, 1, 0);
    const circumcircle = Circumcircle.fromPoints(p1, p2, p3);
    expect(circumcircle.radius).toBeCloseTo(expectedRadius);
});

test('create circumcircle from triangle [(0, 0), (1, 0), (1, 1)] and expect point (0.75, 0.5) to be inside', () => {
    const targetPoint: Vector3 = new Vector3(0.75, 0.5, 0);
    const triangle: Triangle = new Triangle(
        new Vector3(0, 0, 0),
        new Vector3(1, 0, 0),
        new Vector3(1, 1, 0)
    )
    const circumcircle = Circumcircle.fromTriangle(triangle);
    expect(circumcircle.isPointInCircumcircle(targetPoint)).toBe(true);
});
