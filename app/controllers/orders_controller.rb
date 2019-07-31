require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'

class OrdersController

  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @view.display(undelivered_orders)
  end

  def add
    # ask meal
    @meals_view.display(@meal_repository.all)
    meal_id = @view.ask_meal_id
    meal = @meal_repository.find(meal_id)
    # ask customer
    @customers_view.display(@customer_repository.all)
    customer_id = @view.ask_customer_id
    customer =  @customer_repository.find(customer_id)
    # ask employee
    @view.display_employees(@employee_repository.all_delivery_guys)
    employee_id = @view.ask_employee_id
    employee = @employee_repository.find(employee_id)

    # instanciate an order
    order = Order.new(meal: meal, customer: customer, employee: employee)

    # add order to order repository
    @order_repository.add(order)
  end

  def list_my_orders(employee)
    my_orders = @order_repository.all.select{ |order| order.employee.username == employee.username }

    @view.display(my_orders)
  end

  def list_my_undelivered_orders(employee)
    my_orders = @order_repository.all.select{ |order| order.employee.username == employee.username && !order.delivered? }

    @view.display(my_orders)
  end

  def mark_as_delivered(employee)
    # List all delivery guy undelivered orders
    # ask order id
    list_my_undelivered_orders(employee)
    order_id = @view.ask_order_id
    order = @order_repository.find(order_id)
    # mask order as deliverd
    order.deliver!
    @order_repository.save
  end


end
