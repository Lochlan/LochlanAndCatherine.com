from django.views.generic.base import TemplateView
from rsvps.models import Guest

class GuestRsvpView(TemplateView):

    template_name = "rsvp.html"

    def get_context_data(self, **kwargs):
        context = super(GuestRsvpView, self).get_context_data(**kwargs)
        context['guest'] = Guest.objects.get(pk=kwargs['pk'])
        return context
