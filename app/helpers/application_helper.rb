module ApplicationHelper
  def format_element(percent)
    ret = "<span class='has-text-grey-darker'>#{percent}%</span>" if percent == 100
    ret = "<span class='has-text-danger'>#{percent}%</span>" if percent < 100
    ret = "<span class='has-text-success'>#{percent}%</span>" if percent > 100
    ret.html_safe
  end
end
