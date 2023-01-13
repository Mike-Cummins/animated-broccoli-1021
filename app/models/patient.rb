class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.over_18_years_old
    Patient.where('age > ?',  18).order(:name)
  end
end