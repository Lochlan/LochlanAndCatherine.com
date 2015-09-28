from django.db import models


class Guest(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField();
    address = models.CharField(max_length=200)
    created = models.DateTimeField(db_index=True, auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        return '{}'.format(self.name)

class Rsvp(models.Model):
    BEEF = 'B'
    CHICKEN = 'C'
    FISH = 'F'
    VEGETARIAN = 'V'
    FOOD_CHOICES = (
        (BEEF, 'Beef'),
        (CHICKEN, 'Chicken'),
        (FISH, 'Fish'),
        (VEGETARIAN, 'Vegetarian'),
    )
    guest = models.ForeignKey(Guest)
    accept = models.BooleanField();
    food = models.CharField(max_length=1, choices=FOOD_CHOICES)
    created = models.DateTimeField(db_index=True, auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)
