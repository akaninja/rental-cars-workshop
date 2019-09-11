class RentalPresenter < SimpleDelegator
  # delegate: content_tag, to: :helper
  include Rails.application.routes.url_helpers

  def initialize(rental)
    super(rental)
  end

  def status
    if scheduled? 
      helper.content_tag(:span, class: 'badge badge-success') do
         "Agendada"
      end
    else
      helper.content_tag(:span, class: 'badge badge-primary') do
        "Em andamento"
      end
    end
  end

  def withdraw_link
    return "" unless scheduled? 

    helper.link_to('Confirmar Retirada', withdraw_rental_path(self),
                   method: :post)
  end

  private

  def helper
    ApplicationController.helpers
  end
end
