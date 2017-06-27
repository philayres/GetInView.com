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

ActiveRecord::Schema.define(version: 20161227160542) do

  create_table "google_places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "property_id"
    t.string   "place_id",    limit: 100
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["property_id"], name: "index_google_places_on_property_id", using: :btree
    t.index ["user_id"], name: "index_google_places_on_user_id", using: :btree
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "hidden"
    t.integer  "owner_id"
    t.string   "status",        limit: 10
    t.string   "claim_status"
    t.integer  "claimed_by_id"
    t.string   "property_type"
    t.index ["claimed_by_id"], name: "index_properties_on_claimed_by_id", using: :btree
    t.index ["owner_id"], name: "index_properties_on_owner_id", using: :btree
    t.index ["status"], name: "index_properties_on_status", using: :btree
    t.index ["user_id"], name: "index_properties_on_user_id", using: :btree
  end

  create_table "property_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "address1",    limit: 50
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country",     limit: 3
    t.decimal  "latitude",               precision: 10, scale: 7
    t.decimal  "longitude",              precision: 10, scale: 7
    t.integer  "property_id"
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["property_id"], name: "index_property_addresses_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_addresses_on_user_id", using: :btree
  end

  create_table "property_calendars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.string   "publish_uri"
    t.string   "timezone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_property_calendars_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_calendars_on_user_id", using: :btree
  end

  create_table "property_clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "primary_phone"
    t.integer  "country_code"
    t.boolean  "accept_sms"
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["property_id"], name: "index_property_clients_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_clients_on_user_id", using: :btree
  end

  create_table "property_contact_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "primary_phone"
    t.string   "primary_phone_country"
    t.string   "secondary_phone"
    t.string   "secondary_phone_country"
    t.string   "email"
    t.string   "website_url"
    t.integer  "property_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["property_id"], name: "index_property_contact_details_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_contact_details_on_user_id", using: :btree
  end

  create_table "property_descriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "property_id"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.index ["property_id"], name: "index_property_descriptions_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_descriptions_on_user_id", using: :btree
  end

  create_table "property_room_bookings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.date     "date_from"
    t.date     "date_to"
    t.string   "status"
    t.string   "event_uid"
    t.time     "check_in"
    t.time     "check_out"
    t.integer  "property_client_id"
    t.boolean  "hidden"
    t.integer  "property_calendar_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["property_calendar_id"], name: "index_property_room_bookings_on_property_calendar_id", using: :btree
    t.index ["property_client_id"], name: "index_property_room_bookings_on_property_client_id", using: :btree
  end

  create_table "property_room_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.boolean  "hidden"
    t.integer  "property_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["property_id"], name: "index_property_room_types_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_room_types_on_user_id", using: :btree
  end

  create_table "property_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "number"
    t.string   "name"
    t.boolean  "hidden"
    t.integer  "property_id"
    t.integer  "property_room_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.index ["property_id"], name: "index_property_rooms_on_property_id", using: :btree
    t.index ["property_room_type_id"], name: "index_property_rooms_on_property_room_type_id", using: :btree
    t.index ["user_id"], name: "index_property_rooms_on_user_id", using: :btree
  end

  create_table "room_availabilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.date     "date_from"
    t.date     "date_to"
    t.string   "status"
    t.integer  "property_room_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["property_id"], name: "index_room_availabilities_on_property_id", using: :btree
    t.index ["property_room_id"], name: "index_room_availabilities_on_property_room_id", using: :btree
    t.index ["user_id"], name: "index_room_availabilities_on_user_id", using: :btree
  end

  create_table "room_type_availabilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.date     "date_from"
    t.date     "date_to"
    t.string   "status"
    t.integer  "property_room_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["property_id"], name: "index_room_type_availabilities_on_property_id", using: :btree
    t.index ["property_room_type_id"], name: "index_room_type_availabilities_on_property_room_type_id", using: :btree
    t.index ["user_id"], name: "index_room_type_availabilities_on_user_id", using: :btree
  end

  create_table "room_type_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.integer  "occupants"
    t.decimal  "rate",                      precision: 10
    t.integer  "min_nights"
    t.integer  "room_type_availability_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "hidden"
    t.index ["property_id"], name: "index_room_type_rates_on_property_id", using: :btree
    t.index ["room_type_availability_id"], name: "index_room_type_rates_on_room_type_availability_id", using: :btree
    t.index ["user_id"], name: "index_room_type_rates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "google_places", "properties"
  add_foreign_key "google_places", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "properties", "users", column: "claimed_by_id"
  add_foreign_key "properties", "users", column: "owner_id"
  add_foreign_key "property_addresses", "properties"
  add_foreign_key "property_addresses", "users"
  add_foreign_key "property_calendars", "properties"
  add_foreign_key "property_calendars", "users"
  add_foreign_key "property_clients", "properties"
  add_foreign_key "property_clients", "users"
  add_foreign_key "property_contact_details", "properties"
  add_foreign_key "property_contact_details", "users"
  add_foreign_key "property_descriptions", "properties"
  add_foreign_key "property_descriptions", "users"
  add_foreign_key "property_room_bookings", "property_calendars"
  add_foreign_key "property_room_bookings", "property_clients"
  add_foreign_key "property_room_types", "properties"
  add_foreign_key "property_room_types", "users"
  add_foreign_key "property_rooms", "properties"
  add_foreign_key "property_rooms", "property_room_types"
  add_foreign_key "property_rooms", "users"
  add_foreign_key "room_availabilities", "properties"
  add_foreign_key "room_availabilities", "property_rooms"
  add_foreign_key "room_availabilities", "users"
  add_foreign_key "room_type_availabilities", "properties"
  add_foreign_key "room_type_availabilities", "property_room_types"
  add_foreign_key "room_type_availabilities", "users"
  add_foreign_key "room_type_rates", "properties"
  add_foreign_key "room_type_rates", "room_type_availabilities"
  add_foreign_key "room_type_rates", "users"
end
