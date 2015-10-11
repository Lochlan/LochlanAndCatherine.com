from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import TemplateView
from rsvps.views import GuestRsvpView


urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name="home.html"), name='home'),
    url(r'^about/$', TemplateView.as_view(template_name="about.html"), name='about'),
    url(r'^event/$', TemplateView.as_view(template_name="event.html"), name='event'),
    url(r'^rsvp/(?P<pk>[0-9]+)/$', GuestRsvpView.as_view()),

    url(r'^admin/', include(admin.site.urls)),
]
