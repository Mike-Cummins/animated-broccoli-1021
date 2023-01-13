require 'rails_helper'

RSpec.describe Patient do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  it 'Displays only over age 18 and orders by name' do 
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seaside Health & Wellness Center")
    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
    @doctor_2 = @hospital_1.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university:"Johns Hopkins University")
    @doctor_3 = @hospital_2.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    @doctor_4 = @hospital_2.doctors.create!(name: "Derek McDreamy Shepherd", specialty: "Attending Surgeon", university: "University of Pennsylvania")
    @patient_1 = Patient.create!(name: "Katie Bryce", age: 24)
    @patient_2 = Patient.create!(name: "Denny Duquette", age: 39)
    @patient_3 = Patient.create!(name: "Rebecca Pope", age: 32)
    @patient_4 = Patient.create!(name: "Zola Shepherd", age: 2)
    DoctorPatient.create!(doctor: @doctor_1, patient: @patient_1)
    DoctorPatient.create!(doctor: @doctor_1, patient: @patient_2)
    DoctorPatient.create!(doctor: @doctor_2, patient: @patient_2)
    DoctorPatient.create!(doctor: @doctor_2, patient: @patient_4)
    DoctorPatient.create!(doctor: @doctor_3, patient: @patient_3)
    DoctorPatient.create!(doctor: @doctor_4, patient: @patient_3)

    expect(Patient.over_18_years_old).to eq([@patient_2, @patient_1, @patient_3]) 

  end
end