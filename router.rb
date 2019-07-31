class Router

  def initialize(sessions_controller, meals_controller, customers_controller, orders_controller)
    @sessions_controller = sessions_controller
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
  end

  def run
    employee = @sessions_controller.sign_in

    loop do
      if employee.manager?
        action = get_manager_actions
        case action
        when 1 then @meals_controller.add
        when 2 then @meals_controller.list
        when 3 then @customers_controller.add
        when 4 then @customers_controller.list
        when 5 then @orders_controller.add
        when 6 then @orders_controller.list_undelivered_orders
        end
      end

      if employee.delivery_guy?
        action = get_delivery_guy_actions
        case action
        when 1 then @orders_controller.list_my_undelivered_orders(employee)
        when 2 then @orders_controller.mark_as_delivered(employee)
        end
      end
    end
  end

  def get_manager_actions
    puts "MANAGER ACTIONS"
    puts "-" * 80
    puts "1. Add a meal"
    puts "2. List all meals"
    puts "3. Add customer"
    puts "4. List all customers"
    puts "5. Add new order"
    puts "6. List undeliverd orders"
    gets.chomp.to_i
  end

  def get_delivery_guy_actions
    puts "DELIVERY GUY ACTIONS"
    puts "-" * 80
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    gets.chomp.to_i
  end

end