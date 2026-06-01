package com.xpromus.tasks.triangulation;

import com.xpromus.engine.Engine;
import com.xpromus.engine.IAppLogic;
import com.xpromus.engine.Window;
import com.xpromus.engine.graph.Mesh;
import com.xpromus.engine.graph.Render;
import com.xpromus.engine.scene.Scene;
import com.xpromus.tasks.data.Point2D;
import com.xpromus.tasks.util.MeshConverter;

import java.util.List;

public class TaskMain implements IAppLogic {

    public static void main(String[] args) {
        var taskMain = new TaskMain();
        var engine = new Engine("Delaunay Triangulation", new Window.WindowOptions(), taskMain);
        engine.start();
    }

    @Override
    public void cleanup() {

    }

    @Override
    public void init(Window window, Scene scene, Render render) {
        Point2D[] points = new Point2D[]{
             new Point2D(0d, 0d),
             new Point2D(0.9d, 0.9d),
             new Point2D(0.9d, 0d),
             new Point2D(0.5d, -0.5d),
             new Point2D(-0.3d, -0.3d),
             new Point2D(-0.9d, -0.4d),
             new Point2D(-0.9d, 0.8d),
        };

        var triangulator = new Triangulator();

        var triangles = triangulator.triangulate(List.of(points));
        var newMesh = MeshConverter.ConvertToMesh(triangles);
        Mesh mesh = new Mesh(newMesh.getCoordinates(), newMesh.getColors(), newMesh.getTriangleIndices());
        scene.addMesh("quad", mesh);
    }

    @Override
    public void input(Window window, Scene scene, long diffTimeMillis) {

    }

    @Override
    public void update(Window window, Scene scene, long diffTimeMillis) {

    }
}
