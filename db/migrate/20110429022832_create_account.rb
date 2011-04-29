class CreateAccount < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
			t.string :userid
      t.string :displayname
      t.string :titlename
      t.string :givenname
      t.string :middlename
      t.string :familyname
      t.string :suffixname
      t.string :patronymicname
      t.string :matronymicname
      t.string :nickname
      t.integer :emailaddressid
      t.integer :homephoneid
      t.integer :mobilephoneid
      t.integer :businessphoneid
      t.integer :faxphoneid
      t.string :companyname
      t.string :mailingaddressfirststreettext
      t.string :mailingaddresssecondstreettext
      t.string :mailingaddresscityname
      t.string :mailingaddressstateprovincecode
      t.string :mailingaddresspostalcode
      t.string :preferedculturecode
      t.string :isogendercode
      t.string :avatarimageuri
      t.integer :currentlocationid
      t.float :currentlocationlatitudevalue
      t.float :currentlocationlongitudevalue
      t.datetime :birthdate
      t.integer :agevalue
      t.boolean :notificationenabledindicator
      t.boolean :verifiedemailaddressidindicator

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
