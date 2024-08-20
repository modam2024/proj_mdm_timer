from django.contrib import admin
from django.contrib.staticfiles.storage import staticfiles_storage
from django.urls import path
from django.views.generic.base import RedirectView

from app_chat import views as chat_views
from app_news_study import views as news_study_views

urlpatterns = [
    path('favicon.ico', RedirectView.as_view(url=staticfiles_storage.url('img/favicon.ico'))),
    path("admin/",         admin.site.urls),
    path('chat/',          chat_views.chat, name='chat'),
    path('news_study/',    news_study_views.news_study,    name='news_study'),
    path('news_study/news_info_eng/', news_study_views.news_info_eng, name='news_info_eng'),
    path('news_study/news_info_inf/', news_study_views.news_info_inf, name='news_info_inf'),

    path('save-wordinfo/', news_study_views.save_wordinfo, name='save_wordinfo'),
    path('complete-word/', news_study_views.complete_word, name='complete_word'),
]
