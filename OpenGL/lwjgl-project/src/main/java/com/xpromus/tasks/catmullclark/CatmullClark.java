package com.xpromus.tasks.catmullclark;

import com.xpromus.engine.graph.Mesh;
import com.xpromus.tasks.data.Face;
import com.xpromus.tasks.data.Point3D;

import java.util.List;

public class CatmullClark {

    public Mesh SubdivideMesh(
        float[] positions,
        float[] colors,
        int[] indices
    ) {
        return new Mesh(positions, colors, indices);
    }

    public List<Point3D> CetFacePoints(List<Face> faces) {
        throw new RuntimeException("Not Implemented!");
    }

    public List<Point3D> GetEdgePoints() {
        throw new RuntimeException("Not Implemented!");
    }

    public List<Point3D> GetVertexPoints() {
        throw new RuntimeException("Not Implemented!");
    }

    public List<Face> ConnectPointsToFaces() {
        throw new RuntimeException("Not Implemented!");
    }

}
