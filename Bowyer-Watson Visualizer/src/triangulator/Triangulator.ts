import { Vector3 } from "three";
import { Edge } from "../data/Edge";
import { Triangle } from "../data/Triangle";
import { Triangulation } from "./Triangulation";

export class Triangulator {

    public static triangulate(
        Vector3s: Vector3[]
    ): Triangulation {
        if (Vector3s.length < 3) {
            return new Triangulation([]);
        }

        const superTriangle = this.calculateSuperTriangle(Vector3s);
        let triangles: Triangle[] = [];
        triangles.push(superTriangle);

        for (const Vector3 of Vector3s) {
            const badTriangles = this.findBadTriangles(Vector3, triangles);
            const polygon = this.createPolygonFromBadTriangles(badTriangles);
            triangles = this.removeInstancesFromList(triangles, badTriangles);
            for (const edge of polygon) {
                const newTriangle = Triangle.fromEdgeAndPoint(edge, Vector3);
                triangles.push(newTriangle);
            }
        }
        const finalTriangles: Triangle[] = [];
        for (const triangle of triangles) {
            if (
                triangle.containsPoint(superTriangle.a) ||
                triangle.containsPoint(superTriangle.b) ||
                triangle.containsPoint(superTriangle.c)
            ) {
                continue;
            }
            finalTriangles.push(triangle);
        }

        return new Triangulation(finalTriangles);
    }

    private static calculateSuperTriangle(
        Vector3s: Vector3[]
    ): Triangle {
        const minX = Vector3s.reduce((r, e) => r.x < e.x ? r : e).x;
        const maxX = Vector3s.reduce((r, e) => r.x > e.x ? r : e).x;
        const minY = Vector3s.reduce((r, e) => r.y < e.y ? r : e).y;
        const maxY = Vector3s.reduce((r, e) => r.y > e.y ? r : e).y;

        const squareWidth = Math.max(maxX - minX, maxY - minY);

        return new Triangle(
            new Vector3(minX - 0.5 * squareWidth, minY, 0),
            new Vector3(minX + 1.5 * squareWidth, minY, 0),
            new Vector3(minX + 0.5 * squareWidth, minY + 2 * squareWidth, 0)
        );
    }

    private static findBadTriangles(
        Vector3: Vector3,
        triangles: Triangle[]
    ): Triangle[] {
        const badTriangles: Triangle[] = [];

        for (let index = 0; index < triangles.length; index++) {
            const triangle = triangles[index];

            if (triangle.circumcircle.isPointInCircumcircle(Vector3)) {
                badTriangles.push(triangle);
            }
        }

        return badTriangles;
    }

    private static createPolygonFromBadTriangles(
        badTriangles: Triangle[]
    ): Edge[] {
        const polygon: Edge[] = [];
        
        for (let index = 0; index < badTriangles.length; index++) {
            const currentBadTriangle = badTriangles[index];
            const trianglesToCheck: Triangle[] = badTriangles.map(item => item.clone());
            trianglesToCheck.splice(index, 1);

            for (const currentEdge of currentBadTriangle.edges) {
                let edgeIsShared = false;
                for (const currentTriangleToCheck of trianglesToCheck) {
                    if (currentTriangleToCheck.containsEdge(currentEdge)) {
                        edgeIsShared = true;
                    }
                }

                if (!edgeIsShared) {
                    polygon.push(currentEdge)
                }
            }
        }

        return polygon;
    }

    private static removeInstancesFromList(
        listToApplyTo: Triangle[], 
        removeTargets: Triangle[]
    ): Triangle[] {
        const returnList: Triangle[] = [];

        for (const triangle of listToApplyTo) {
            let inBadTriangles = false;

            for (const badTriangle of removeTargets) {
                if (triangle.equals(badTriangle)) {
                    inBadTriangles = true;
                    break;
                }
            }

            if (!inBadTriangles) {
                returnList.push(triangle);
            }
        }

        return returnList;
    }
}
