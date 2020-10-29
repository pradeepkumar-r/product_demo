class CartController < ApplicationController
    skip_before_action :verify_authenticity_token
    def show
        #items = Cart.all;
        if Cart.exists?(:customer_id => params[:id])
            @cartvalue = Cart.where(customer_id: params[:id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id).to_a;
            #puts pddetails[1].id
            render json: {status: 'SUCCESS', message:'Loaded Cart items', data:pddetails},status: :ok
        else
            render json: {status: 'ERROR', message:'CART IS EMPTY'}
        end
    end
    
    
    def update
        if Cart.exists?(:customer_id => params[:id])
            @cartvalue = Cart.where(customer_id: params[:id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id,item_id: params[:item_id])
            if pddetails.update_all(quantity: params[:quantity])
                render json: {status: 'SUCCESS', message:'Updated item', data:pddetails},status: :ok
            else
                render json: {status: 'ERROR', message:'item not updated', data:pddetails.errors},status: :unprocessable_entity
            end
        else
            render json: {status: 'ERROR', message:'CART IS EMPTY'}
        end

    end




    def create
        if Cart.exists?(:customer_id => params[:customer_id])
            puts "exists";
            @cartvalue = Cart.where(customer_id: params[:customer_id]).first
            puts @cartvalue.id;
            params[:cart_id] = @cartvalue.id
            cartitem = CartItem.new(cartitem_params)
            
            if cartitem.save
                render json: {status: 'SUCCESS', message:'Added to cartitem', data:cartitem},status: :ok
            else
                render json: {status: 'ERROR', message:'Item not saved to cartitem', data:cartitem.errors},status: :unprocessable_entity
            end
        else
            @cart = Cart.new(cart_params);
            if @cart.save
                puts "cart added";
                params[:cart_id] = @cart.id
                cartitem = CartItem.new(cartitem_params)
                if cartitem.save
                    render json: {status: 'SUCCESS', message:'Added to cartitem', data:cartitem},status: :ok
                else
                    render json: {status: 'ERROR', message:'Item not saved to cartitem', data:cartitem.errors},status: :unprocessable_entity
                end
            end
        end
       
    end

    def destroy
        if Cart.exists?(:customer_id => params[:id])
            @cartvalue = Cart.where(customer_id: params[:id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id,item_id: params[:item_id])
            samplepd=CartItem.where(cart_id: @cartvalue.id,item_id: params[:item_id]).to_a;
            if pddetails.delete_all
                render json: {status: 'SUCCESS', message:'Deleted  item', data:samplepd},status: :ok
            else
                render json: {status: 'ERROR', message:'item not found', data:pddetails.errors},status: :unprocessable_entity
            end
        else
            render json: {status: 'ERROR', message:'Cart Empty'}
        end
    end
    
    def deleteallItems
        if Cart.exists?(:customer_id => params[:id])
            @cartvalue = Cart.where(customer_id: params[:id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id)
            samplepd=CartItem.where(cart_id: @cartvalue.id).to_a;
            if pddetails.delete_all
                render json: {status: 'SUCCESS', message:'Deleted  item', data:samplepd},status: :ok
            else
                render json: {status: 'ERROR', message:'item not found', data:pddetails.errors},status: :unprocessable_entity
            end
        else
            render json: {status: 'ERROR', message:'Cart Empty'}
        end
    end
    
    

    def cartitem_params
        params.permit(:item_id, :quantity, :cart_id)
       
    end

    def cart_params
        params.permit(:customer_id)
       
    end
end
