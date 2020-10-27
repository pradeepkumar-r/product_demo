class CustomersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        customers = Customer.all;
        render json: {status: 'SUCCESS', message:'Loaded customers', data:customers},status: :ok
    end
    
    def show
        customer = Customer.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded Customer', data:customer},status: :ok
    end
    
    def create
        customer = Customer.new(customer_params)

        if customer.save
          render json: {status: 'SUCCESS', message:'Saved customer', data:customer},status: :ok
        else
          render json: {status: 'ERROR', message:'customer not saved', data:customer.errors},status: :unprocessable_entity
        end
    end
    
    def update
        customer = Customer.find(params[:id])
        if customer.update_attributes(customer_params)
          render json: {status: 'SUCCESS', message:'Updated customer', data:customer},status: :ok
        else
          render json: {status: 'ERROR', message:'customer not updated', data:customer.errors},status: :unprocessable_entity
        end
    end

    def destroy
        customer = Customer.find(params[:id])
        customer.destroy
        render json: {status: 'SUCCESS', message:'Deleted customer', data:customer},status: :ok
    end
    
      private

    def customer_params
        params.permit(:gmail, :address, :phone_no, :name)
       
    end
end
