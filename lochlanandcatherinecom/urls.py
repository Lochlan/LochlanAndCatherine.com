from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import TemplateView


urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name="home.html"), name='home'),
    url(r'^about/$', TemplateView.as_view(template_name="about.html"), name='about'),
    url(r'^event/$', TemplateView.as_view(template_name="event.html"), name='event'),

    url(r'^admin/', include(admin.site.urls)),
]
