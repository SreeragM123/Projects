from django.db import models

# Create your models here.
class Login(models.Model):
    Username=models.CharField(max_length=100)
    Password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class Organization(models.Model):
    Name=models.CharField(max_length=100)
    Description=models.CharField(max_length=500,default='')
    License=models.CharField(max_length=100)
    Email=models.CharField(max_length=100)
    Phone=models.BigIntegerField()
    Place = models.CharField(max_length=100)
    Post = models.CharField(max_length=100)
    Pin = models.CharField(max_length=100,default='')
    District = models.CharField(max_length=100)
    State = models.CharField(max_length=100)
    Status=models.CharField(max_length=100)
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)

class Saloon(models.Model):
    Name=models.CharField(max_length=100)
    Ownername=models.CharField(max_length=100)
    Phone=models.BigIntegerField()
    Image=models.CharField(max_length=100)
    Place=models.CharField(max_length=100)
    Post=models.CharField(max_length=100)
    Pin=models.CharField(max_length=100,default='')
    District=models.CharField(max_length=100)
    State=models.CharField(max_length=100)
    Email=models.CharField(max_length=100)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)

class Employee(models.Model):
    Name=models.CharField(max_length=100)
    Age=models.IntegerField()
    Gender=models.CharField(max_length=100)
    Place = models.CharField(max_length=100)
    Post = models.CharField(max_length=100)
    Pin = models.CharField(max_length=100,default='')
    District = models.CharField(max_length=100)
    State = models.CharField(max_length=100)
    Email=models.CharField(max_length=100)
    Image=models.CharField(max_length=100)
    Qualification=models.CharField(max_length=100,default="")
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE)

class User(models.Model):
    Name = models.CharField(max_length=100)
    Age = models.IntegerField()
    Gender = models.CharField(max_length=100)
    Phone=models.BigIntegerField(default='')
    Place = models.CharField(max_length=100)
    Post = models.CharField(max_length=100)
    Pin = models.CharField(max_length=100,default='')
    District = models.CharField(max_length=100)
    State = models.CharField(max_length=100)
    Email = models.CharField(max_length=100)
    Image = models.CharField(max_length=250,default="")
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)


class Report(models.Model):
    Reportmsg=models.CharField(max_length=500)
    Reporteddate=models.DateField()
    Status=models.CharField(max_length=100)
    Reply=models.CharField(max_length=100)
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE)

class Donation(models.Model):
    Quantity=models.FloatField(max_length=100)
    Length=models.FloatField(max_length=100)
    Date=models.DateField()
    Status=models.CharField(max_length=100)
    ORGANIZATION = models.ForeignKey(Organization, on_delete=models.CASCADE,default='')

class Donationapprove(models.Model):
    SALOON = models.ForeignKey(Saloon, on_delete=models.CASCADE,default='')
    DONATION = models.ForeignKey(Donation, on_delete=models.CASCADE)
    Status = models.CharField(max_length=100)


class Feedback(models.Model):
    Feedbackmsg=models.CharField(max_length=100)
    Date=models.CharField(max_length=100,default='')
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE)

class Servicescat(models.Model):
    Category=models.CharField(max_length=100)
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE)

class Services(models.Model):
    Servicename=models.CharField(max_length=100)
    Description=models.CharField(max_length=500)
    Duration=models.IntegerField()
    Price=models.FloatField()
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE)
    SERVICESCAT=models.ForeignKey(Servicescat,on_delete=models.CASCADE,default="")




class Booking(models.Model):
    Amount=models.FloatField()
    Date = models.DateField()
    Status=models.CharField(max_length=100)
    BDate = models.DateField()
    Time = models.CharField(max_length=100, default='')
    Token=models.CharField(max_length=100)
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE,default='')
    USER=models.ForeignKey(User,on_delete=models.CASCADE)

class Bookingsub(models.Model):
    BOOKING=models.ForeignKey(Booking,on_delete=models.CASCADE)
    SERVICES=models.ForeignKey(Services,on_delete=models.CASCADE)


class Payment(models.Model):
    Date=models.DateField()
    Amount=models.FloatField()
    BOOKING=models.ForeignKey(Booking,on_delete=models.CASCADE)
    USER=models.ForeignKey(User,on_delete=models.CASCADE)

class Inventory(models.Model):
    Productname=models.CharField(max_length=100)
    Description=models.CharField(max_length=500)
    Mandate=models.DateField()
    Images=models.CharField(max_length=100)
    Price=models.FloatField()
    Instock=models.CharField(max_length=100)
    SALOON=models.ForeignKey(Saloon,on_delete=models.CASCADE,default='')

class Cart(models.Model):
    SERVICE=models.ForeignKey(Services,on_delete=models.CASCADE,default='')
    USER=models.ForeignKey(User,on_delete=models.CASCADE)

