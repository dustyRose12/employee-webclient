class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees.json").body
  end

  def new
    
  end
  def create
    @employee = Unirest.post("#{ ENV['HOST_NAME'] }/api/v2/employees",
                                                headers: { "Accept" => "application/json"},
                                                parameters: { :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email]}
                                                )

    redirect_to "/employees/#{@employee['id']}"
  end

 def edit
      @employee = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json").body
  end

  def update

    @employee = Unirest.patch("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json", 
                                          headers:{ "Accept" => "application/json" }, 
                                          parameters:{ :first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email]}).body

      redirect_to "/employees/#{@employee['id']}"                                    
  
  end

  def destroy
      employee = Unirest.delete("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json").body

      flash[:warning] = "Employee Successfully Destroyed"
      redirect_to "/employees"

  end

  def show
    @employee = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/employees/#{params[:id]}.json").body
  end


end
