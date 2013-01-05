class UserStats < Netzke::Base

  def body_content(user)
    bike = user.bike
    %Q(
      <div id="user_stats_page">
        <p>Total Hours Worked: #{user.total_hours}</p>
        <p>Hours worked in #{Time.now.strftime('%B')}: #{user.current_month_hours}</p>
        <p>Current bike ID: #{bike.id if bike}</p>
        <p>Current bike S/N: #{bike.serial_number if bike}</p>
      </div>
    )
  end

  js_configure do |c|
    c.body_padding = 15
    c.title = "User Stats"
    #c.html = body_content()
    c.update_stats = <<-JS
      function(){
        // Call endpoint
        this.serverUpdate({}, function(){
          //success callback
        }, this);
      }
    JS
  end

  endpoint :server_update do |params, this|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel
    this[:update] = [body_content(user)]
  end

private
  def user
    controller.current_user
  end

end
