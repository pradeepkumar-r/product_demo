class CartController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def showItems
        #items = Cart.all;
        puts "in show items"
        if Cart.exists?(:customer_id => params[:customer_id])
            @cartvalue = Cart.where(customer_id: params[:customer_id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id).to_a;
            #puts pddetails[1].id
            number = pddetails.length - 1 ;
            result = Array.new;
            hash = {}
            for i in 0..number
                pid=pddetails[i].item_id;
                itemdetail=Item.find(pid);             
                #hash = { balcon: itemdetail.sku, apple: "fruit" }
                hash["product_id"]=itemdetail.id
                hash["item_name"]=itemdetail.sku;
                hash["quantity"]=pddetails[i].quantity;
                hash["amount_peritem"]=itemdetail.price;
                hash["total_amount"] = (pddetails[i].quantity * itemdetail.price).to_s ;
                result.push(hash.clone);
                #puts 'result for index ' + i + ' ' + result[i];
                puts "result for index  #{i} - #{result[0]}"
                #pddetails[i].sku = itemdetail.sku;
                #puts "Value of local variable is #{i}"
            end
            puts result[0];
            render json: {status: 'SUCCESS', message:'Loaded Cart items', data:result},status: :ok
        else
            render json: {status: 'ERROR', message:'CART IS EMPTY'}
        end
    end

    def showCart
        puts "in show carts"
        if Cart.exists?(:customer_id => params[:customer_id])
            p=CartItem.joins(:cart,:item).where('carts.customer_id=1').pluck('cart_items.quantity,items.id,items.sku as item_sku,items.price');
            
            number = p.length-1;
            result = Array.new;
            hash = {}
            for i in 0..number
                #pid=pddetails[i].item_id;
                #itemdetail=Item.find(pid);             
                #hash = { balcon: itemdetail.sku, apple: "fruit" }
                hash["quantity"]=p[i][0];
                hash["product_id"]=p[i][1];
                hash["item_name"]=p[i][2];
                hash["amount_peritem"]=p[i][3];
                hash["total_amount"] = (p[i][0] * p[i][3]) ;
                result.push(hash.clone);
                #puts 'result for index ' + i + ' ' + result[i];
                puts "result for index  #{i} - #{result[i]}"
                #pddetails[i].sku = itemdetail.sku;
                #puts "Value of local variable is #{i}"
            end
            
            render json: {status: 'SUCCESS', message:'Loaded Cart items', data:result},status: :ok
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

    def deleteFromCart
        if Cart.exists?(:customer_id => params[:customer_id])
            @cartvalue = Cart.where(customer_id: params[:customer_id]).first
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
        if Cart.exists?(:customer_id => params[:customer_id])
            @cartvalue = Cart.where(customer_id: params[:customer_id]).first
            puts @cartvalue.id;
            pddetails=CartItem.where(cart_id: @cartvalue.id)
            samplepd=CartItem.where(cart_id: @cartvalue.id).to_a;
            if pddetails.delete_all
                if Cart.where(customer_id: params[:customer_id]).delete_all
                    print samplepd;
                    render json: {status: 'SUCCESS', message:'Deleted  item', data:samplepd},status: :ok
                end
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
