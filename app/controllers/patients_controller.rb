class PatientsController < ApplicationController
  def index
    @patients = Patient.over_18_years_old
  end
end