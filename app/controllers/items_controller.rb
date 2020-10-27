class ItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        items = Item.all;
        render json: {status: 'SUCCESS', message:'Loaded items', data:items},status: :ok
    end
    
    def show
        item = Item.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded item', data:item},status: :ok
    end
    
    def create
        item = Item.new(item_params)

        if item.save
          render json: {status: 'SUCCESS', message:'Saved item', data:item},status: :ok
        else
          render json: {status: 'ERROR', message:'Item not saved', data:item.errors},status: :unprocessable_entity
        end
    end
    
    def update
        item = Item.find(params[:id])
        if item.update_attributes(item_params)
          render json: {status: 'SUCCESS', message:'Updated item', data:item},status: :ok
        else
          render json: {status: 'ERROR', message:'item not updated', data:item.errors},status: :unprocessable_entity
        end
    end

    def destroy
        item = Item.find(params[:id])
        item.destroy
        render json: {status: 'SUCCESS', message:'Deleted item', data:item},status: :ok
    end
    
      private

    def item_params
        params.permit(:sku, :description, :price, :stock)
       
    end
    
    
end
