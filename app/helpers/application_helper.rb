module ApplicationHelper
  def disp_alerts
    if notice
      render 'layouts/notice'
    elsif alert
      render 'layouts/alert'
    end
  end
end
