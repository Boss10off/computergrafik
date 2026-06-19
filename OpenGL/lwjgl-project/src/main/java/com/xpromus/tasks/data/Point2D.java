package com.xpromus.tasks.data;

public class Point2D implements Point {

    private final double x;
    private final double y;

    public Point2D(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Point2D other)) {
            return false;
        }

        return other.x == x && other.y == y;
    }
}
