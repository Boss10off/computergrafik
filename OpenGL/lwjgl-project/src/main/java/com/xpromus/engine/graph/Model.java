package com.xpromus.engine.graph;

import com.xpromus.engine.scene.Entity;

import java.util.ArrayList;
import java.util.List;

public class Model {

    private final String id;
    private List<Entity> entitesList;
    private List<Mesh> meshList;

    public Model(String id, List<Mesh> meshList) {
        this.id = id;
        this.meshList = meshList;
        entitesList = new ArrayList<>();
    }

    public void cleanup() {
        meshList.forEach(Mesh :: cleanup);
    }

    public List<Entity> getEntitesList() {
        return entitesList;
    }

    public String getId() {
        return id;
    }

    public List<Mesh> getMeshList() {
        return meshList;
    }
}
