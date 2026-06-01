package com.xpromus.tasks.triangulation;

import com.xpromus.tasks.data.Edge;
import com.xpromus.tasks.data.Point2D;
import com.xpromus.tasks.data.Triangle;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//TODO: Implement functions for the triangulator
public class Triangulator {

    /**
     * Take a list of points and create a valid Delaunay triangulation.
     * Create this triangulation using the Bowyer-Watson algorithm.
     * @param point2DS List of points to be triangulated.
     * @return A list of triangles containing the valid triangulation.
     */
    public List<Triangle> triangulate(List<Point2D> point2DS) {
        List<Triangle> triangles = new ArrayList<>();
        Triangle superTriangle = calculateSuperTriangle(point2DS);
        triangles.add(superTriangle);

        for (Point2D point : point2DS) {
            List<Triangle> badTriangles = findBadTriangles(point, triangles);

            List<Edge> polygonFromBadTriangles = createPolygonFromBadTriangles(badTriangles);
            for (Edge edge : polygonFromBadTriangles) {
                triangles.add(new Triangle(edge, point));
            }
            triangles.removeAll(badTriangles);
        }

        triangles.removeIf(triangle ->
                triangle.containsVertex(superTriangle.getA()) ||
                        triangle.containsVertex(superTriangle.getB()) ||
                        triangle.containsVertex(superTriangle.getC()));

        return triangles;
    }

    /**
     * Create a triangle, that encloses all points, that should be triangulated.
     * The triangle should be an optimal triangle.
     * @param point2DS List of points, that should be enclosed in the triangle.
     * @return An instance of the triangle class containing the super triangle.
     */
    private Triangle calculateSuperTriangle(List<Point2D> point2DS) {
        double minX = point2DS.getFirst().getX();
        double minY = point2DS.getFirst().getY();
        double maxX = point2DS.getFirst().getX();
        double maxY = point2DS.getFirst().getY();
        for (Point2D point : point2DS) {
            if(point.getX() < minX) minX = point.getX();
            if(point.getY() < minY) minY = point.getY();
            if(point.getX() > maxX) maxX = point.getX();
            if(point.getY() > maxY) maxY = point.getY();
        }
        double length = (maxX - minX) * 2;
        double height = (maxY - minY) * 2;
        double midX = (maxX + minX) / 2;
        double midY = (maxY + minY) / 2;

        return new Triangle(new Point2D(midX-length,midY-height),
                            new Point2D(midX+length,midY-height),
                            new Point2D(midX,midY+height));
    }

    /**
     * Find triangles, that contain the new point. Also known as bad triangles.
     * @param point2D The new point, that will be added to the triangulation
     * @param triangles All current triangles, that will be checked.
     * @return All bad triangles, that have been found.
     */
    private List<Triangle> findBadTriangles(Point2D point2D, List<Triangle> triangles) {
        List<Triangle> badTriangles = new ArrayList<>();

        for (Triangle triangle : triangles) {
            if(triangle.getCircumcircle().isPointInCircumcircle(point2D)){
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
    private List<Edge> createPolygonFromBadTriangles(List<Triangle> badTriangles) {
        List<Edge> uniqueEdges = new ArrayList<>();
        for (Triangle triangle : badTriangles) {
            List<Triangle> badTrianglesCopy = new ArrayList<>(badTriangles);
            badTrianglesCopy.remove(triangle);
            for (Edge edge : triangle.getEdges()) {
                boolean isShared = false;
                for (Triangle other : badTrianglesCopy) {
                    if (other.containsEdge(edge)) {
                        isShared = true;
                        break;
                    }
                }
                if (!isShared) {
                    uniqueEdges.add(edge);
                }
            }
        }
        return uniqueEdges;
    }
}
