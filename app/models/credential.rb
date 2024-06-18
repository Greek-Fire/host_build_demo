# app/models/credential.rb
class Credential < ApplicationRecord
  belongs_to :vcenter
end