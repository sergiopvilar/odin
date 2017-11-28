class Site < ApplicationRecord
  after_create :create_tenant

  private

  def create_tenant
    Apartment::Tenant.create(code)
  end
end
