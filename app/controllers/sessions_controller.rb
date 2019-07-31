require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in

    #ask username
    username = @view.ask_username
    #ask password
    password = @view.ask_password

    employee = @employee_repository.find_by_username(username)
    #if employee with username exist and employee password corret
    if employee && employee.password == password
      @view.welcome(employee)
      return employee
    else
      @view.wrong_credentials
      sign_in
    end

  end
end