from django.db import models

# Create your models here.


class Login(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)


class User(models.Model):
    name=models.CharField(max_length=100)
    dob=models.DateField()
    gender=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    place=models.CharField(max_length=100)
    city=models.CharField(max_length=100)
    state=models.CharField(max_length=100)
    photo=models.CharField(max_length=500)
    email=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
    status=models.CharField(max_length=100)

class News(models.Model):
    title=models.CharField(max_length=100)
    description=models.CharField(max_length=500)
    photos=models.CharField(max_length=500)
    place=models.CharField(max_length=100)
    city=models.CharField(max_length=100)
    state=models.CharField(max_length=100)
    date=models.DateField()
    status=models.CharField(max_length=100)
    type=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
    category=models.CharField(max_length=100,default='')

class Report(models.Model):
    NEWS=models.ForeignKey(News,on_delete=models.CASCADE)
    reportmsg=models.CharField(max_length=300)
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    status=models.CharField(max_length=100)
    date=models.DateField()