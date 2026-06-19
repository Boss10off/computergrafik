package com.xpromus.tasks.data;

import java.util.List;

public class Face {

    private final List<Point3D> points;
    private final List<Edge> edges;

    public Face(List<Point3D> points, List<Edge> edges) {
        this.points = points;
        this.edges = edges;
    }

    public List<Point3D> getPoints() {
        return points;
    }

    public List<Edge> getEdges() {
        return edges;
    }
}
