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

ActiveRecord::Schema.define(:version => 20110227191249) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.text     "notes"
    t.string   "status"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "terms"
  end

  create_table "items", :force => true do |t|
    t.text     "description"
    t.decimal  "unit_cost"
    t.integer  "quantity"
    t.integer  "discount"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "hashed_password", :null => false
    t.string   "password_salt",   :null => false
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
  end

end
