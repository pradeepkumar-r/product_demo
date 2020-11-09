class OrderController < ApplicationController
    skip_before_action :verify_authenticity_token
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

    def create
        @order = Order.new(order_params);
        if @order.save
            puts "order added";
            params[:order_id] = @order.id
            orderdetail=params[:order_data];
            number=orderdetail.length-1;
            for i in 0..number
                orderdetail[i]["order_id"]=params[:order_id]
                puts orderdetail[i];
                #orderitem = OrderItem.new(orderdetail[i])
                if OrderItem.create(orderdetail[i])
                    #render json: {status: 'SUCCESS', message:'Added to orderitem', data:orderitem},status: :ok
                else
                render json: {status: 'ERROR', message:'Item not saved to orderitem', data:orderitem.errors},status: :unprocessable_entity
                end
            end
        else
            render json: {status: 'ERROR', message:'Item not saved to order', data:order.errors},status: :unprocessable_entity
        end
    end

    def orderitem_params
        params.permit(:item_id, :quantity, :order_id)
       
    end
    
    def order_params
        params.permit(:customer_id)
       
    end

end
