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

ActiveRecord::Schema.define(:version => 20110429153112) do

  create_table "accounts", :force => true do |t|
    t.string   "userid"
    t.string   "displayname"
    t.string   "titlename"
    t.string   "givenname"
    t.string   "middlename"
    t.string   "familyname"
    t.string   "suffixname"
    t.string   "patronymicname"
    t.string   "matronymicname"
    t.string   "nickname"
    t.integer  "emailaddressid"
    t.integer  "homephoneid"
    t.integer  "mobilephoneid"
    t.integer  "businessphoneid"
    t.integer  "faxphoneid"
    t.string   "companyname"
    t.string   "mailingaddressfirststreettext"
    t.string   "mailingaddresssecondstreettext"
    t.string   "mailingaddresscityname"
    t.string   "mailingaddressstateprovincecode"
    t.string   "mailingaddresspostalcode"
    t.string   "preferedculturecode"
    t.string   "isogendercode"
    t.string   "avatarimageuri"
    t.integer  "currentlocationid"
    t.float    "currentlocationlatitudevalue"
    t.float    "currentlocationlongitudevalue"
    t.datetime "birthdate"
    t.integer  "agevalue"
    t.boolean  "notificationenabledindicator"
    t.boolean  "verifiedemailaddressidindicator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "album_tracks", :force => true do |t|
    t.integer  "song_id"
    t.integer  "album_id"
    t.integer  "track_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlist_tracks", :force => true do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.integer  "track_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", :force => true do |t|
    t.string   "titlename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descriptiontext"
    t.string   "imageuri"
    t.integer  "mediacountvalue"
  end

  create_table "profile", :force => true do |t|
    t.integer  "user_id"
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_playlists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.integer  "playlist_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_song", :force => true do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "username"
  end

end
