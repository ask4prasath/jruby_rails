Rhea::Engine.routes.draw do
  resources :connectors
  resources :datasets
  resources :aggregations
  resources :data_curation_pipelines
  resources :data_ingestion_pipelines
  resources :workflows do
    post "run", :on => :collection
    post "stop", :on =>  :collection
  end
  get 'dashboard/index'
end
