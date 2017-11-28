module ApplicationHelper
  def format_element(percent)
    ret = "<span class='has-text-grey-darker'>#{percent}%</span>" if percent == 100
    ret = "<span class='has-text-danger'>#{percent}%</span>" if percent < 100
    ret = "<span class='has-text-success'>#{percent}%</span>" if percent > 100
    ret.html_safe
  end

  def public?
    Apartment::Tenant.current == 'public'
  end

  def current_site
    Site.find_by_code(Apartment::Tenant.current)
  end

  def site_title
    public? ? 'Odin' : current_site.name
  end

  def is_root?
    public?
  end

  def logo_style
    public? ? 'width: 450px;height: 273px' : 'width:520px; height:177px'
  end

  def logo_url
    public? ? '/logo.png' : "/tenant/#{current_site.code}/logo.png"
  end

  def square_logo_url
    public? ? '/odin.jpg' : "/tenant/#{current_site.code}/logo-square.png"
  end

end
