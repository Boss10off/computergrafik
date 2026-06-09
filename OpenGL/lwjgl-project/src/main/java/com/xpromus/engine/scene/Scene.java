package com.xpromus.engine.scene;

import com.xpromus.engine.graph.Model;

import java.util.*;

public class Scene {

    private Map<String, Model> modelMap;
    private Projection projection;

    public Scene(int width, int height) {
        modelMap = new HashMap<>();
        projection = new Projection(width, height);
    }

    public void addEntity(Entity entity) {
        var modelId = entity.getModelId();
        var model = modelMap.get(modelId);
        if (model == null) {
            throw new RuntimeException("Could not find model [" + modelId + "]");
        }
        model.getEntitesList().add(entity);
    }

    public void addModel(Model model) {
        modelMap.put(model.getId(), model);
    }

    public void cleanup() {
        modelMap.values().forEach(Model :: cleanup);
    }

    public Map<String, Model> getModelMap() {
        return modelMap;
    }

    public Projection getProjection() {
        return projection;
    }

    public void resize(int width, int height) {
        projection.updateProjMatrix(width, height);
    }
}
