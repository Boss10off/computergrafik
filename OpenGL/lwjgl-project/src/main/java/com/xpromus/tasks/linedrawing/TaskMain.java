package com.xpromus.tasks.linedrawing;

public class TaskMain {

    private final Line givenLine = new Line(1, 1, 11, 5);
    private final Grid givenGrid = new Grid(13, 7);
    private final Grid targetGrid = new Grid(13, 7).setGrid(
        new boolean[][]{
            new boolean[13],
            new boolean[]{false, true, true, false, false, false, false, false, false, false, false, false, false},
            new boolean[]{false, false, false, true, true, false, false, false, false, false, false, false, false},
            new boolean[]{false, false, false, false, false, true, true, true, false, false, false, false, false},
            new boolean[]{false, false, false, false, false, false, false, false, true, true, false, false, false},
            new boolean[]{false, false, false, false, false, false, false, false, false, false, true, true, false},
            new boolean[13],
        }
    );

    public static void main(String[] args) {
        new TaskMain();
    }

    public TaskMain() {
        var createdGrid = new Bresenham().CreateLineOnGrid(givenGrid, givenLine);
        System.out.println(createdGrid.equals(targetGrid));
    }
}
