package com.xpromus.tasks.catmullclark;

import com.xpromus.engine.graph.Mesh;
import com.xpromus.tasks.data.*;

import java.util.ArrayList;
import java.util.List;

public class CatmullClark {

    public Mesh SubdivideMesh(
        float[] positions,
        float[] colors,
        int[] indices
    ) {
        // var points = toPoint3D(positions);
        return new Mesh(positions, colors, indices);
    }

    private List<Point3D> CetFacePoints(List<Face> faces) {
        var facePoints = new ArrayList<Point3D>();

        for (Face face : faces) {
            var x = face.getPoints().stream().mapToDouble(Point3D::x).average().getAsDouble();
            var y = face.getPoints().stream().mapToDouble(Point3D::y).average().getAsDouble();
            var z = face.getPoints().stream().mapToDouble(Point3D::z).average().getAsDouble();
            facePoints.add(new Point3D(
                x, y, z
            ));
        }
        
        return facePoints;
    }

    private Point3D GetEdgePoint(
        List<Point3D> facePoints,
        Edge3D edge
    ) {
        facePoints.add(new Point3D(
            (edge.getA().x() + edge.getB().x()) / 2,
            (edge.getA().y() + edge.getB().y()) / 2,
            (edge.getA().z() + edge.getB().z()) / 2
        ));

        return new Point3D(
            facePoints.stream().mapToDouble(Point3D::x).average().getAsDouble(),
            facePoints.stream().mapToDouble(Point3D::y).average().getAsDouble(),
            facePoints.stream().mapToDouble(Point3D::z).average().getAsDouble()
        );
    }

    private Point3D GetVertexPoint(
        List<Point3D> facePoints,
        List<Edge3D> edges
    ) {
        var facePointAverage = new Point3D(
            facePoints.stream().mapToDouble(Point3D::x).average().getAsDouble(),
            facePoints.stream().mapToDouble(Point3D::y).average().getAsDouble(),
            facePoints.stream().mapToDouble(Point3D::z).average().getAsDouble()
        );

        var edgeMiddlePoints = new ArrayList<Point3D>();
        for (Edge3D edge : edges) {
            edgeMiddlePoints.add(new Point3D(
                (edge.getA().x() + edge.getB().x()) / 2,
                (edge.getA().y() + edge.getB().y()) / 2,
                (edge.getA().z() + edge.getB().z()) / 2
            ));
        }

        var edgeMiddlePointsAverage = new Point3D(
            edgeMiddlePoints.stream().mapToDouble(Point3D::x).average().getAsDouble(),
            edgeMiddlePoints.stream().mapToDouble(Point3D::y).average().getAsDouble(),
            edgeMiddlePoints.stream().mapToDouble(Point3D::z).average().getAsDouble()
        );

        return new Point3D(
            (facePointAverage.x() + edgeMiddlePointsAverage.x()) / 2,
            (facePointAverage.y() + edgeMiddlePointsAverage.y()) / 2,
            (facePointAverage.z() + edgeMiddlePointsAverage.z()) / 2
        );
    }

    private List<Face> ConnectPointsToFaces() {
        throw new RuntimeException("Not Implemented!");
    }

}
