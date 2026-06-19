package com.xpromus.tasks.data;

public class Edge3D {
    private Point3D a;
    private Point3D b;
    private double length;

    public Edge3D(Point3D a, Point3D b) {
        this.a = a;
        this.b = b;
        length = Math.sqrt(
                Math.pow(b.x() - a.x(), 2) + Math.pow(b.y() - a.y(), 2)
        );
    }

    public Point3D getA() {
        return a;
    }

    public Point3D getB() {
        return b;
    }

    public double getLength() {
        return length;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Edge3D other)) {
            return false;
        }

        return other.a.equals(a) && other.b.equals(b) ||
                other.a.equals(b) && other.b.equals(a);
    }
}
