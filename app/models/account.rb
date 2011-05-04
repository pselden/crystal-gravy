# == Schema Information
# Schema version: 20110504050645
#
# Table name: accounts
#
#  id                              :integer         not null, primary key
#  userid                          :string(255)
#  displayname                     :string(255)
#  titlename                       :string(255)
#  givenname                       :string(255)
#  middlename                      :string(255)
#  familyname                      :string(255)
#  suffixname                      :string(255)
#  patronymicname                  :string(255)
#  matronymicname                  :string(255)
#  nickname                        :string(255)
#  emailaddressid                  :integer
#  homephoneid                     :integer
#  mobilephoneid                   :integer
#  businessphoneid                 :integer
#  faxphoneid                      :integer
#  companyname                     :string(255)
#  mailingaddressfirststreettext   :string(255)
#  mailingaddresssecondstreettext  :string(255)
#  mailingaddresscityname          :string(255)
#  mailingaddressstateprovincecode :string(255)
#  mailingaddresspostalcode        :string(255)
#  preferedculturecode             :string(255)
#  isogendercode                   :string(255)
#  avatarimageuri                  :string(255)
#  currentlocationid               :integer
#  currentlocationlatitudevalue    :float
#  currentlocationlongitudevalue   :float
#  birthdate                       :datetime
#  agevalue                        :integer
#  notificationenabledindicator    :boolean
#  verifiedemailaddressidindicator :boolean
#  created_at                      :datetime
#  updated_at                      :datetime
#

class Account < ActiveRecord::Base
	set_table_name "accounts"
end
