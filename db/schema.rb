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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110810090544) do

  create_table "asins", :force => true do |t|
    t.string   "sku"
    t.integer  "purchaseorder_id"
    t.integer  "compliance_id"
    t.datetime "association_at"
    t.string   "title"
    t.string   "srq_impact_source"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battery_details", :force => true do |t|
    t.integer  "compliance_id"
    t.string   "battery_type"
    t.string   "size"
    t.integer  "units"
    t.string   "packaging"
    t.integer  "battery_wt"
    t.string   "brand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battery_sizes", :force => true do |t|
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battery_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compliances", :force => true do |t|
    t.string   "sku"
    t.string   "vendor_product_number"
    t.string   "brand"
    t.integer  "vendor_id"
    t.string   "status"
    t.integer  "standard_id"
    t.text     "importer_of_record"
    t.text     "keeper_of_record"
    t.date     "manufacture_date"
    t.string   "manufacture_place"
    t.string   "esignature"
    t.string   "position"
    t.text     "comments_internal"
    t.text     "comments_external"
    t.string   "vendor_notes"
    t.datetime "last_activity_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "wee_compliance"
    t.boolean  "contains_battery"
    t.string   "efn_availability"
    t.text     "efn_restrictions"
    t.text     "efn_restriction_reason"
  end

  create_table "documents", :force => true do |t|
    t.integer  "compliance_id"
    t.string   "url"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labs", :force => true do |t|
    t.integer  "compliance_id"
    t.text     "info"
    t.date     "testing_date"
    t.string   "report_number"
    t.text     "standards"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packaging_datas", :force => true do |t|
    t.integer  "compliance_id"
    t.integer  "paper_cardboard_wt"
    t.integer  "plastic_wt"
    t.integer  "other_wt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packaging_details", :force => true do |t|
    t.integer  "compliance_id"
    t.float    "paper_cardboard_wt"
    t.float    "plastic_wt"
    t.float    "other_wt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_details", :force => true do |t|
    t.integer  "compliance_id"
    t.string   "weee_category"
    t.float    "net_product_wt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchaseorders", :force => true do |t|
    t.string   "code"
    t.integer  "vendor_id"
    t.string   "condition"
    t.date     "delivery_date"
    t.string   "marketplace"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "contact"
    t.boolean  "is_import"
    t.boolean  "is_private_label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "password_hash"
  end

  create_table "weee_product_datas", :force => true do |t|
    t.integer  "compliance_id"
    t.string   "weee_category"
    t.integer  "net_product_wt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
