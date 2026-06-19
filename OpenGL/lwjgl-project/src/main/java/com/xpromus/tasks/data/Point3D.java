package com.xpromus.tasks.data;

public record Point3D(double x, double y, double z) implements Point {

    public Point3D add(Point3D other) {
        return new Point3D(
                x + other.x(),
                y + other.y(),
                z + other.z()
        );
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Point3D other)) {
            return false;
        }

        return other.x == x && other.y == y && other.z == z;
    }

    @Override
    public String toString() {
        return "Point3D{" +
                "x: " + x +
                ", y: " + y +
                ", z: " + z +
                '}';
    }
}
