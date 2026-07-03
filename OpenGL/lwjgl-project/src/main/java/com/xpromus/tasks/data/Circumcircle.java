package com.xpromus.tasks.data;

public class Circumcircle {

    private final Point2D center;
    private final double radius;

    public Circumcircle(Point2D center, float radius) {
        this.center = center;
        this.radius = radius;
    }

    public Circumcircle(
        Point2D a,
        Point2D b,
        Point2D c
    ) {
        center = calculateCenter(a, b, c);
        radius = calculateRadius(center, a);
    }

    public boolean isPointInCircumcircle(Point2D point2D) {
        var deltaX = point2D.getX() - center.getX();
        var deltaY = point2D.getY() - center.getY();
        var distance = Math.pow(deltaX, 2) + Math.pow(deltaY, 2);
        var radiusSquared = Math.pow(radius, 2);

        return distance < radiusSquared;
    }

    private double calculateRadius(
        Point2D center,
        Point2D a
    ) {
        return Math.sqrt(
            Math.pow(center.getX() - a.getX(), 2) + Math.pow(center.getY() - a.getY(), 2)
        );
    }

    private Point2D calculateCenter(
        Point2D a,
        Point2D b,
        Point2D c
    ) {
        var d = Math.abs(
            2 * (a.getX() * (b.getY() - c.getY()) + b.getX() *
                (c.getY() - a.getY()) + c.getX() *
                (a.getY() - b.getY()))
        );

        var uX = (
            (Math.pow(a.getX(), 2) + Math.pow(a.getY(), 2)) * (b.getY() - c.getY()) +
            (Math.pow(b.getX(), 2) + Math.pow(b.getY(), 2)) * (c.getY() - a.getY()) +
            (Math.pow(c.getX(), 2) + Math.pow(c.getY(), 2)) * (a.getY() - b.getY())
        ) / d;

        var uY = (
            (Math.pow(a.getX(), 2) + Math.pow(a.getY(), 2)) * (c.getX() - b.getX()) +
            (Math.pow(b.getX(), 2) + Math.pow(b.getY(), 2)) * (a.getX() - c.getX()) +
            (Math.pow(c.getX(), 2) + Math.pow(c.getY(), 2)) * (b.getX() - a.getX())
        ) / d;

        return new Point2D(uX, uY);
    }

    public Point2D getCenter() {
        return center;
    }

    public double getRadius() {
        return radius;
    }
}
