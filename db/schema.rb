# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_615_072_015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'continents', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'lat', precision: 16, scale: 14
    t.decimal 'lng', precision: 16, scale: 14
  end

  create_table 'countries', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'continent_id'
    t.index ['continent_id'], name: 'index_countries_on_continent_id'
  end

  create_table 'heritage_charms', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.bigint 'heritage_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'order'
    t.index ['heritage_id'], name: 'index_heritage_charms_on_heritage_id'
  end

  create_table 'heritage_likes', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'heritage_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['heritage_id'], name: 'index_heritage_likes_on_heritage_id'
    t.index %w[user_id heritage_id], name: 'index_heritage_likes_on_user_id_and_heritage_id', unique: true
    t.index ['user_id'], name: 'index_heritage_likes_on_user_id'
  end

  create_table 'heritage_tags', force: :cascade do |t|
    t.bigint 'heritage_id', null: false
    t.bigint 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['heritage_id'], name: 'index_heritage_tags_on_heritage_id'
    t.index ['tag_id'], name: 'index_heritage_tags_on_tag_id'
  end

  create_table 'heritages', force: :cascade do |t|
    t.string 'name'
    t.text 'content'
    t.bigint 'country_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'lat', precision: 16, scale: 14
    t.decimal 'lng', precision: 16, scale: 14
    t.index ['country_id'], name: 'index_heritages_on_country_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.integer 'review_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['review_id'], name: 'index_likes_on_review_id'
    t.index %w[user_id review_id], name: 'index_likes_on_user_id_and_review_id', unique: true
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer 'follower_id'
    t.integer 'followed_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index %w[follower_id followed_id], name: 'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'replies', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id', null: false
    t.bigint 'review_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[review_id created_at], name: 'index_replies_on_review_id_and_created_at'
    t.index ['review_id'], name: 'index_replies_on_review_id'
    t.index %w[user_id created_at], name: 'index_replies_on_user_id_and_created_at'
    t.index ['user_id'], name: 'index_replies_on_user_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.text 'content'
    t.bigint 'heritage_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'parent_id'
    t.integer 'score'
    t.index ['heritage_id'], name: 'index_reviews_on_heritage_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', limit: 20, null: false
    t.string 'email', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest', null: false
    t.string 'remember_digest'
    t.string 'activation_digest'
    t.boolean 'activated', default: false
    t.datetime 'activated_at'
    t.boolean 'admin', default: false
    t.string 'reset_digest'
    t.datetime 'reset_sent_at'
    t.string 'content'
    t.string 'email_reset_digest'
    t.datetime 'email_reset_sent_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'countries', 'continents'
  add_foreign_key 'heritage_charms', 'heritages'
  add_foreign_key 'heritage_tags', 'heritages'
  add_foreign_key 'heritage_tags', 'tags'
  add_foreign_key 'heritages', 'countries'
  add_foreign_key 'replies', 'reviews'
  add_foreign_key 'replies', 'users'
  add_foreign_key 'reviews', 'heritages'
  add_foreign_key 'reviews', 'users'
end
