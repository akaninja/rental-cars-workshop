module RentalHelper 
  def status(rental)
    if rental.scheduled? 
      content_tag(:span, class: 'badge badge-success') do
         "Agendada"
      end
    else
      content_tag(:span, class: 'badge badge-primary') do
        "Em andamento"
      end
    end
  end
end