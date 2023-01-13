require 'rails_helper'

RSpec.describe 'Doctor Show' do
  describe 'As a user when I visit a doctor show page' do
    before :each do
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
      DoctorPatient.create!(doctor: @doctor_2, patient: @patient_4)
      DoctorPatient.create!(doctor: @doctor_3, patient: @patient_3)
      DoctorPatient.create!(doctor: @doctor_4, patient: @patient_3)
    end

    it 'Displays the doctors name, specialty, and university' do
      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@doctor_1.name)
      expect(page).to have_content(@doctor_1.specialty)
      expect(page).to have_content(@doctor_1.university)
      expect(page).to_not have_content(@doctor_2.name)
      expect(page).to_not have_content(@doctor_3.name)
      expect(page).to_not have_content(@doctor_4.name)
    end

    it 'Displays the name of the hospital' do
      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@hospital_1.name)
      expect(page).to_not have_content(@hospital_2.name)
    end

    it 'Displays the names of each patient' do
      visit "/doctors/#{@doctor_1.id}"

      within "div#patients" do
        expect(page).to have_content(@patient_1.name)
        expect(page).to have_content(@patient_2.name)
        expect(page).to_not have_content(@patient_3.name)
        expect(page).to_not have_content(@patient_4.name)
      end
    end
  end
end