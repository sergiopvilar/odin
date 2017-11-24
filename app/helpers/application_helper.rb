module ApplicationHelper
  def format_element(percent)
    ret = "<span class='has-text-grey-darker'>#{percent}%</span>" if percent == 100
    ret = "<span class='has-text-danger'>#{percent}%</span>" if percent < 100
    ret = "<span class='has-text-success'>#{percent}%</span>" if percent > 100
    ret.html_safe
  end

  def site_title
    is_gg? ? 'RagnaGG' : 'Odin'
  end

  def is_root?
    !is_gg?
  end

  def is_gg?
    @domain == 'ragnagg.odindb.com'
  end

  def logo_style
    is_gg? ? 'width:520px; height:177px' : 'width: 450px;height: 273px'
  end

  def logo_url
    is_gg? ? '/ragnagg.png' : '/logo.png'
  end

end
