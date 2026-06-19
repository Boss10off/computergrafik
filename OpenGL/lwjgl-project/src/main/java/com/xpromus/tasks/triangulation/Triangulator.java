package com.xpromus.tasks.triangulation;

import com.xpromus.tasks.data.Edge;
import com.xpromus.tasks.data.Point2D;
import com.xpromus.tasks.data.Triangle;

import java.util.ArrayList;
import java.util.List;

public class Triangulator {

    /**
     * Take a list of points and create a valid delaunay triangulation.
     * Create this triangulation using the Bowyer-Watson algorithm.
     * @param points List of points to be triangulated.
     * @return A list of triangles containing the valid triangulation.
     */
    public List<Triangle> Triangulate(List<Point2D> points) {
        if (points.size() < 3) {
            return new ArrayList<>();
        }

        var superTriangle = CalculateSuperTriangle(points);
        ArrayList<Triangle> triangles = new ArrayList<>();
        triangles.add(superTriangle);

        for (Point2D point : points) {
            var badTriangles = FindBadTriangles(point, triangles);
            var polygon = CreatePolygonFromBadTriangles(badTriangles);
            triangles.removeIf(badTriangles :: contains);
            for (Edge edge : polygon) {
                var newTriangle = new Triangle(edge, point);
                triangles.add(newTriangle);
            }
        }

        var finalTriangles = new ArrayList<Triangle>();
        for (Triangle triangle : triangles) {
            if (
                triangle.containsVertex(superTriangle.getA()) ||
                triangle.containsVertex(superTriangle.getB()) ||
                triangle.containsVertex(superTriangle.getC())
            ) {
                continue;
            }

            finalTriangles.add(triangle);
        }

        return finalTriangles;
    }

    /**
     * Create a triangle, that encloses all points, that should be triangulated.
     * The triangle should be an optimal triangle.
     * @param points List of points, that should be enclosed in the triangle.
     * @return An instance of the triangle class containing the super triangle.
     */
    private Triangle CalculateSuperTriangle(List<Point2D> points) {
        var xMin = points.stream().mapToDouble(Point2D::getX).min().getAsDouble();
        var yMin = points.stream().mapToDouble(Point2D::getY).min().getAsDouble();
        var xMax = points.stream().mapToDouble(Point2D::getX).max().getAsDouble();
        var yMax = points.stream().mapToDouble(Point2D::getY).max().getAsDouble();

        var squareWidth = Math.max(xMax - xMin, yMax - yMin);

        return new Triangle(
            new Point2D(xMin - 0.5d * squareWidth, yMin - 1d),
            new Point2D(xMin + 1.5d * squareWidth, yMin - 1d),
            new Point2D(xMin + 0.5d * squareWidth, yMin + 2d * squareWidth)
        );
    }

    /**
     * Find triangles, that contain the new point. Also known as bad triangles.
     * @param point The new point, that will be added to the triangulation
     * @param triangles All current triangles, that will be checked.
     * @return All bad triangles, that have been found.
     */
    private List<Triangle> FindBadTriangles(Point2D point, List<Triangle> triangles) {
        var badTriangles = new ArrayList<Triangle>();

        for (Triangle triangle : triangles) {
            if (triangle.getCircumcircle().IsPointInCircumcircle(point)) {
                badTriangles.add(triangle);
            }
        }

        return badTriangles;
    }

    /**
     * Create a polygon that represents the outline of all bad triangles.
     * @param badTriangles Bad triangles that were found.
     * @return The outline of all bad triangles as a list of edges.
     */
    private List<Edge> CreatePolygonFromBadTriangles(List<Triangle> badTriangles) {
        var polygon = new ArrayList<Edge>();

        for (Triangle currentTriangle : badTriangles) {
            var trianglesToCheck = new ArrayList<>(badTriangles);
            trianglesToCheck.remove(currentTriangle);
            for (Edge edge : currentTriangle.getEdges()) {
                var sharedEdge = false;
                for (Triangle triangle : trianglesToCheck) {
                    if (triangle.containsEdge(edge)) {
                        sharedEdge = true;
                        break;
                    }
                }

                if (!sharedEdge) {
                    polygon.add(edge);
                }
            }
        }

        return polygon;
    }

}
