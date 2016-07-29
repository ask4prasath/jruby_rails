# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160622073757) do

  create_table "rhea_aggregations", force: :cascade do |t|
    t.string   "name"
    t.string   "aggregation_type"
    t.string   "file_path"
    t.text     "query",            limit: 650000
    t.string   "status"
    t.string   "schedule"
    t.integer  "workflow_id"
    t.string   "correlation_ids"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "rhea_aggregations", ["workflow_id"], name: "index_rhea_aggregations_on_workflow_id"

  create_table "rhea_connectors", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.string   "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rhea_data_curation_pipelines", force: :cascade do |t|
    t.string   "name"
    t.string   "file_type"
    t.string   "parent"
    t.string   "hdfs_path"
    t.string   "file_attributes", limit: 6000
    t.string   "regex"
    t.string   "schedule"
    t.integer  "dataset_id"
    t.integer  "workflow_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "rhea_data_curation_pipelines", ["workflow_id"], name: "index_rhea_data_curation_pipelines_on_workflow_id"

  create_table "rhea_data_ingestion_pipelines", force: :cascade do |t|
    t.string   "name"
    t.string   "connector_type"
    t.string   "credentials",    limit: 3000
    t.string   "sink_path"
    t.string   "schedule"
    t.integer  "workflow_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "rhea_data_ingestion_pipelines", ["workflow_id"], name: "index_rhea_data_ingestion_pipelines_on_workflow_id"

  create_table "rhea_datasets", force: :cascade do |t|
    t.string   "name"
    t.text     "schema_key",   limit: 650000
    t.text     "schema_value", limit: 650000
    t.string   "status"
    t.string   "created_by"
    t.integer  "workflow_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "rhea_datasets", ["workflow_id"], name: "index_rhea_datasets_on_workflow_id"

  create_table "rhea_workflows", force: :cascade do |t|
    t.string   "name"
    t.string   "created_by"
    t.string   "schedule"
    t.string   "status"
    t.string   "notification_emails"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "raw_data"
  end

end
