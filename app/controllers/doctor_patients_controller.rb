class DoctorPatientsController < ApplicationController
  def destroy
    doctor_patient = DoctorPatient.find(params[:id])
    doctor = Doctor.find(doctor_patient.doctor_id)
    doctor_patient.destroy  

    redirect_to "/doctors/#{doctor.id}"
  end
end