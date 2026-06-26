package com.xpromus.tasks.linedrawing;

public class Grid {

    private int width;
    private int height;
    private boolean[][] grid;

    public Grid(int width, int height) {
        this.width = width;
        this.height = height;
        grid = new boolean[height][];
        for (int i = 0; i < grid.length; i++) {
            grid[i] = new boolean[width];
        }
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public boolean[][] getGrid() {
        return grid;
    }

    public Grid setGrid(boolean[][] grid) {
        this.grid = grid;
        return this;
    }
}
