import smtplib
from datetime import datetime

from django.core.files.storage import FileSystemStorage
from django.core.mail import send_mail
from django.db.models import Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from MyApp.models import *
from Saloon import settings


def login(request):
    return render(request,'loginindex.html')

def login_post(request):
    Username = request.POST['textfield']
    Password = request.POST['textfield2']
    n=Login.objects.filter(Username=Username,Password=Password)
    if n.exists():
        e=Login.objects.get(Username=Username,Password=Password)
        request.session['lid']=e.id
        if e.type=='admin':
            return HttpResponse('''<script>alert("SUCCESSFULLY LOGGED IN");window.location='/MyApp/adminhome/'</script>''')
        if e.type=='organization':
            return HttpResponse('''<script>alert("SUCCESSFULLY LOGGED IN");window.location='/MyApp/orghome/'</script>''')
        if e.type == 'saloon':
            return HttpResponse(
                '''<script>alert("SUCCESSFULLY LOGGED IN");window.location='/MyApp/saloonhome/'</script>''')
        else:
            return HttpResponse('''<script>alert("INVALID USERNAME & PASSWORD");window.location='/MyApp/login/'</script>''')
    else:        
        return HttpResponse('''<script>alert("NOT FOUND");window.location='/MyAPP/login/'</script>''')


def adminhome(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/adminindex.html')

def add_saloon(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/AddSaloon.html')
def addsal_post(request):
    Name = request.POST['textfield']
    OwnName = request.POST['textfield2']
    Phone = request.POST['textfield3']
    Images = request.FILES['fileField']
    Place = request.POST['textfield4']
    Post = request.POST['textfield5']
    Pin = request.POST['textfield6']
    District = request.POST['textfield7']
    State = request.POST['textfield8']
    Email = request.POST['textfield9']
    fs = FileSystemStorage()
    from datetime import datetime
    d = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fn = fs.save(d, Images)
    path=fs.url(d)

    l=Login()
    l.Username=Email
    l.Password=Phone
    l.type='saloon'
    l.save()

    s=Saloon()
    s.Name=Name
    s.Ownername=OwnName
    s.Phone=Phone
    s.Image=path
    s.Place=Place
    s.Post=Post
    s.Pin=Pin
    s.District=District
    s.State=State
    s.Email=Email
    s.LOGIN=l
    s.save()

    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyApp/view_saloon/'</script>''')

def chng_pass(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/Change Pass admin.html')
def chngpass_post(request):
    currpass = request.POST['textfield']
    newpass = request.POST['textfield2']
    conpass = request.POST['textfield3']
    log=Login.objects.filter(Password=currpass)
    if log.exists():
        w = Login.objects.get(id=request.session['lid'], Password=currpass)
        if newpass == conpass:
            w = Login.objects.filter(id=request.session['lid']).update(Password=conpass)
            return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/login/'</script>''')
        else:
            return HttpResponse('''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/chngpass_post/'</script>''')
    else:
        return HttpResponse('''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/chngpass_post/'</script>''')

def don_his(request):
    res = Donationapprove.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/DonationHis.html',{"data":res})
def don_his_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    select=request.POST['select']
    if select=="":
        res = Donationapprove.objects.filter(DONATION__Date__range=[From,To])
        return render(request,'admin/DonationHis.html',{"data":res})
    elif From=="" and To=="":
        res = Donationapprove.objects.filter(DONATION__Status__icontains=select)
        return render(request, 'admin/DonationHis.html', {"data": res})
    else:
        res = Donationapprove.objects.filter(DONATION__Date__range=[From, To],DONATION__Status__icontains=select)
        return render(request, 'admin/DonationHis.html', {"data": res})

# def don_mng(request):
#     res = Donation.objects.filter(Status='forwarded')
#     return render(request,'admin/DonationManagement admin.html',{"data":res})
# def don_mng_post(request):
#     From = request.POST['textfield']
#     To = request.POST['textfield2']
#     res = Donation.objects.filter(Date__range=[From, To])
#     return render(request,'admin/DonationManagement admin.html',{"data":res})
def adaccdonreq(request,id):
    a=Donation.objects.filter(id=id).update(Status='approved')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("APPROVED");window.location='/MyApp/don_mng/'</script>''')

def view_adaccdonreq(request):
        res = Donationapprove.objects.filter(DONATION__Status='approved')
        if request.session['lid'] == '':
            return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
        else:
            return render(request,'admin/AccReq Don.html', {"data": res})

def viewadaccdon_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'admin/AccReq Don.html', {"data": res})
#
#
# def rejectdon(request,id):
#     a=Donation.objects.filter(id=id).update(Status='reject')
#     return HttpResponse('''<script>alert("REJECTED");window.location='/MyApp/don_mng/'</script>''')
#
# def view_rejdon(request):
#     res = Donation.objects.filter(Status='reject')
#     return render(request, 'admin/RejDon.html', {"data": res})
# def viewrejdon_post(request):
#     From = request.POST['textfield']
#     To = request.POST['textfield2']
#     res = Donation.objects.filter(Date__range=[From, To])
#     return render(request, 'admin/RejDon.html', {"data": res})


def view_org(request):
    res = Organization.objects.filter(Status='pending')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'admin/View Org.html',{"data":res})
def vieworg_post(request):
    search = request.POST['textfield']
    res = Organization.objects.filter(Name__icontains=search)
    return render(request,'admin/View Org.html',{"data":res})
def view_apporg(request):
        res = Organization.objects.filter(Status='approve')
        if request.session['lid'] == '':
            return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
        else:
            return render(request, 'admin/ViewApprovedOrg.html', {"data": res})
def viewapporg_post(request):
        search = request.POST['textfield']
        res = Organization.objects.filter(Name__icontains=search)
        return render(request, 'admin/ViewApprovedOrg.html', {"data": res})
def approveorg(request,id):
    a=Organization.objects.filter(LOGIN=id).update(Status='approve')
    obj=Login.objects.filter(id=id).update(type='organization')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("APPROVED");window.location='/MyApp/view_org/'</script>''')

def view_rejorg(request):
    res = Organization.objects.filter(Status='reject')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'admin/ViewRejectedOrg.html', {"data": res})
def viewrejorg_post(request):
    search = request.POST['textfield']
    res = Organization.objects.filter(Name__icontains=search)
    return render(request, 'admin/ViewRejectedOrg.html', {"data": res})
def rejectorg(request,id):
    a=Organization.objects.filter(LOGIN_id=id).update(Status='reject')
    obj = Login.objects.filter(id=id).update(type='blocked')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("REJECTED");window.location='/MyApp/view_org/'</script>''')



def edit_saloon(request,id):
    v = Saloon.objects.get(id=id)
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/EditSaloon.html',{'data': v})


def editsal_post(request):
    id = request.POST['id']
    Name = request.POST['textfield']
    OwnName = request.POST['textfield2']
    Phone = request.POST['textfield3']
    Place = request.POST['textfield4']
    Post = request.POST['textfield5']
    Pin = request.POST['textfield6']
    District = request.POST['textfield7']
    State = request.POST['textfield8']
    Email = request.POST['textfield9']

    s = Saloon.objects.get(LOGIN_id=id)
    if 'fileField' in request.FILES:
        Images = request.FILES['fileField']
        if Images != "":
            fs = FileSystemStorage()
            from datetime import datetime
            d = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
            fn = fs.save(d, Images)
            path = fs.url(d)
            s.Image = path
            s.save()
    l=Login.objects.get(id=id)
    l.Username=Email
    l.save()
    s.Name = Name
    s.Ownername = OwnName
    s.Phone = Phone
    s.Place = Place
    s.Post = Post
    s.Pin = Pin
    s.District = District
    s.State = State
    s.Email = Email
    s.save()

    return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/view_saloon/'</script>''')

def feedback(request):
    res=Feedback.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/Feedback admin.html',{"data":res})
def feedback_post(request):
    return render(request,'admin/Feedback admin.html')

def report(request):
    res=Report.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/Report admin.html',{"data":res})
def report_post(request):
    return render(request,'admin/Report admin.html')

def view_saloon(request):
    res=Saloon.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/ViewSaloon.html',{"data":res})
def view_saloon_post(request):
    search = request.POST.get('textfield', '')

    # Filter Saloon objects based on the search term (Name or Pin)
    if search:
        # Filter Saloon objects where the name contains the search term
        name_results = Saloon.objects.filter(Name__icontains=search)

        # Filter Saloon objects where the pin code matches the search term
        pin_results = Saloon.objects.filter(Pin__icontains=search)

        # Combine the results
        n = name_results | pin_results
    else:
        # If no search term provided, return all Saloon objects
        n = Saloon.objects.all()
    return render(request,'admin/ViewSaloon.html',{"data":n})
def del_sal(request,id):
    v = Saloon.objects.get(id=id)
    v.delete()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("DELETED");window.location='/MyApp/view_saloon/'</script>''')



def view_emp(request):
    res=Employee.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'admin/ViewEmployee.html',{"data":res})
def view_emp_post(request):
    search = request.POST['textfield']
    res = Employee.objects.filter(Name__icontains=search)
    return render(request,'admin/ViewEmployee.html',{"data":res})




def orghome(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'organization/orgindex.html')

def orgchng_pass(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'organization/Change Pass org.html')
def orgchng_pass_post(request):
    currpass = request.POST['textfield']
    newpass = request.POST['textfield2']
    conpass = request.POST['textfield3']
    log = Login.objects.filter(Password=currpass)
    if log.exists():
        w = Login.objects.get(id=request.session['lid'],Password=currpass)
        if newpass == conpass:
            w = Login.objects.filter(id=request.session['lid']).update(Password=conpass)
            return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/login/'</script>''')
        else:
            return HttpResponse(
                '''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/orgchng_pass/'</script>''')
    else:
        return HttpResponse('''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/orgchng_pass/'</script>''')

def don_req(request):
    s=Saloon.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'organization/DonationReq org.html',{'data':s})
def donreq_post(request):
    quantity = request.POST['textfield']
    length = request.POST['textfield2']
    # saloon= request.POST['sal']
    # ss=Saloon.objects.get(id=saloon)
    o=Donation()
    o.Quantity=quantity
    o.Length=length
    from datetime import datetime
    o.Date=datetime.now()
    o.Status='pending'
    o.ORGANIZATION=Organization.objects.get(LOGIN_id=request.session['lid'])
    o.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY REQUESTED");window.location='/MyApp/view_donreq/'</script>''')


def view_appdon(request):
        res = Donationapprove.objects.filter(DONATION__Status='approved')
        if request.session['lid'] == '':
            return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
        else:
            return render(request,'organization/AccDon.html', {"data": res})


def viewappdon_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'organization/AccDon.html', {"data": res})


def view_rejdon(request):
    res = Donationapprove.objects.filter(Status='rejected')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'organization/RejDon.html', {"data": res})

def viewrejdon_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request, 'organization/RejDon.html', {"data": res})


def org_signup(request):
    return render(request,'organization/Org signup.html')
def orgsignup_post(request):
    Name = request.POST['textfield']
    Description = request.POST['textarea']
    License = request.FILES['fileField']
    Phone = request.POST['textfield2']
    Place = request.POST['textfield3']
    Post = request.POST['textfield4']
    Pin = request.POST['textfield5']
    District = request.POST['textfield6']
    State = request.POST['textfield7']
    Email = request.POST['textfield8']
    Password = request.POST['textfield9']
    ConPassword = request.POST['textfield10']
    fs = FileSystemStorage()
    from datetime import datetime
    d = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fn = fs.save(d,License)
    path = fs.url(d)

    l = Login()
    l.Username = Email
    l.Password =ConPassword
    l.type = 'pending'
    l.save()

    o = Organization()
    o.Name=Name
    o.Description=Description
    o.License=path
    o.Phone=Phone
    o.Place=Place
    o.Post=Post
    o.Pin=Pin
    o.District=District
    o.State=State
    o.Email=Email
    o.Status='pending'
    o.LOGIN=l
    o.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY REGISTERED");window.location='/MyApp/login/'</script>''')

def view_donreq(request):
    res = Donation.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'organization/ViewDonReq org.html',{"data":res})
def view_donreq_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'organization/ViewDonReq org.html',{"data":res})


def saloonhome(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/saloonindex.html')


def add_emp(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/Add EMP saloon.html')
def addemp_post(request):
    Name = request.POST['textfield']
    Age = request.POST['textfield2']
    Gender = request.POST['RadioGroup1']
    Place = request.POST['textfield3']
    Post = request.POST['textfield4']
    Pin = request.POST['textfield5']
    District = request.POST['textfield6']
    State = request.POST['textfield7']
    Email = request.POST['textfield8']
    Photo = request.FILES['fileField']
    Qualification = request.FILES['fileField1']
    fs = FileSystemStorage()
    from datetime import datetime
    d1 = datetime.now().strftime("%Y%m%d%H%M%S") + "photo.jpg"
    fn = fs.save(d1, Photo)
    path = fs.url(d1)

    fs1 = FileSystemStorage()
    from datetime import datetime
    d2 = datetime.now().strftime("%Y%m%d%H%M%S") + "cert.jpg"
    fn1 = fs1.save(d2, Qualification)
    path1 = fs1.url(d2)

    e=Employee()
    e.Name=Name
    e.Age=Age
    e.Gender=Gender
    e.Place=Place
    e.Post=Post
    e.Pin=Pin
    e.District=District
    e.State=State
    e.Email=Email
    e.Image=path
    e.Qualification=path1
    e.SALOON=Saloon.objects.get(LOGIN_id=request.session['lid'])
    e.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyApp/salview_emp/'</script>''')


def add_inv(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/AddInv saloon.html')
def addinv_post(request):
    ProductName = request.POST['textfield']
    Description = request.POST['textarea']
    Image = request.FILES['fileField']
    Price = request.POST['textfield3']
    # Instock = request.POST['textfield4']
    fs = FileSystemStorage()
    from datetime import datetime
    d = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fn = fs.save(d, Image)
    path = fs.url(d)
    Date=datetime.now().today()

    i=Inventory()
    i.Productname=ProductName
    i.Description=Description
    i.Mandate=Date
    i.Images=path
    i.Price=Price
    i.Instock='AVAILABLE'
    i.SALOON=Saloon.objects.get(LOGIN_id=request.session['lid'])
    i.save()

    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyApp/sal_inv/'</script>''')

def outofstock(request,id):
    Inventory.objects.filter(id=id).update(Instock='OUT OF STOCK')
    return HttpResponse('''<script>alert("STOCK UPDATED");window.location='/MyApp/sal_inv/'</script>''')

def avl(request,id):
    Inventory.objects.filter(id=id).update(Instock='AVAILABLE')
    return HttpResponse('''<script>alert("STOCK UPDATED");window.location='/MyApp/sal_inv/'</script>''')



def add_ser(request,id):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/AddServices saloon.html',{'id':id})
def addser_post(request):
    Sername = request.POST['textfield']
    id = request.POST['id']
    Description = request.POST['textarea']
    Duration = request.POST['textfield2']
    Price = request.POST['textfield3']

    ser=Services()
    ser.Servicename=Sername
    ser.Description=Description
    ser.Duration=Duration
    ser.Price=Price
    ser.SERVICESCAT_id=id
    ser.SALOON = Saloon.objects.get(LOGIN_id=request.session['lid'])
    ser.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyApp/viewsercat/'</script>''')

def addsercat(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'saloon/sercat.html')

def addsercat_post(request):
    Category = request.POST['textfield']
    cat=Servicescat()
    cat.Category=Category
    cat.SALOON = Saloon.objects.get(LOGIN_id=request.session['lid'])
    cat.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyApp/viewsercat/'</script>''')

def viewsercat(request):
    res = Servicescat.objects.filter(SALOON__LOGIN_id=request.session['lid'])
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'saloon/ViewServicescat saloon.html', {"data": res})

def view_sercat_post(request):
    Search = request.POST['textfield']
    res = Servicescat.objects.filter(Category__icontains=Search)
    return render(request, 'saloon/ViewServicescat saloon.html', {"data": res})

def del_sercat(request,id):
    v = Servicescat.objects.get(id=id)
    v.delete()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("DELETED");window.location='/MyApp/viewsercat/'</script>''')


def sal_donreq(request):
    res = Donation.objects.filter(Status='pending')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/DonationReq saloon.html',{"data":res})

def sal_donreq_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'saloon/DonationReq saloon.html',{"data":res})

def accdonreq(request,id):
    Donation.objects.filter(id=id).update(Status='approved')
    obj=Donationapprove()
    obj.DONATION_id=id
    obj.SALOON=Saloon.objects.get(LOGIN_id=request.session['lid'])
    obj.Status='approved'
    obj.save()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("APPROVED");window.location='/MyApp/sal_donreq/'</script>''')

def view_accdonreq(request):
        res = Donationapprove.objects.filter(SALOON__LOGIN_id=request.session['lid'],DONATION__Status='approved')
        if request.session['lid'] == '':
            return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
        else:
            return render(request,'saloon/AccReq Don.html', {"data": res})
def viewaccdonreq_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'saloon/AccReq Don.html', {"data": res})


def rejdonreq(request,id):
    a=Donation.objects.filter(id=id).update(Status='rejected')
    obj = Donationapprove()
    obj.DONATION_id = id
    obj.SALOON = Saloon.objects.get(LOGIN_id=request.session['lid'])
    obj.Status = 'rejected'
    obj.save()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("REJECTED");window.location='/MyApp/sal_donreq/'</script>''')

def view_rejdonreq(request):
    res = Donation.objects.filter(Status='reject')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request, 'saloon/RejReqDon.html', {"data": res})
def viewrejdonreq_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request, 'saloon/RejReqDon.html', {"data": res})


def edit_emp(request,id):
    res=Employee.objects.get(id=id)
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/EditEMP saloon.html',{'data':res})
def editemp_post(request):
    Name = request.POST['textfield']
    Age = request.POST['textfield2']
    Gender = request.POST['RadioGroup1']
    Place = request.POST['textfield3']
    Post = request.POST['textfield4']
    Pin = request.POST['textfield5']
    District = request.POST['textfield6']
    State = request.POST['textfield7']
    Email = request.POST['textfield8']
    id=request.POST['id']
    e = Employee.objects.get(id=id)
    if 'fileField' in request.FILES:
        Images = request.FILES['fileField']
        if Images != "":
            fs = FileSystemStorage()
            from datetime import datetime
            d = datetime.now().strftime("%Y%m%d%H%M%S") + "-1.jpg"
            fn = fs.save(d, Images)
            path = fs.url(d)
            e.Image = path
            e.save()
    if 'fileField1' in request.FILES:
        Qualification = request.FILES['fileField1']
        if Qualification != "":
            fs1 = FileSystemStorage()
            from datetime import datetime
            d = datetime.now().strftime("%Y%m%d%H%M%S") + "-2.jpg"
            fn1 = fs1.save(d, Qualification)
            path1 = fs1.url(d)
            e.Qualification = path1
            e.save()

    e.Name = Name
    e.Age = Age
    e.Gender = Gender
    e.Place = Place
    e.Post = Post
    e.Pin = Pin
    e.District = District
    e.State = State
    e.Email = Email
    e.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/salview_emp/'</script>''')

def edit_inv(request,id):
    res = Inventory.objects.get(id=id)
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/EditInv saloon.html',{'data':res})
def editinv_post(request):
    ProductName = request.POST['textfield']
    Description = request.POST['textarea']
    ManDate = request.POST['textfield2']
    Image = request.FILES['fileField']
    Price = request.POST['textfield3']
    Instock = request.POST['textfield4']
    id = request.POST['id']
    i = Inventory.objects.get(id=id)
    if 'fileField' in request.FILES:
        Images = request.FILES['fileField']
        if Images != "":
            fs = FileSystemStorage()
            from datetime import datetime
            d = datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
            fn = fs.save(d,Images)
            path = fs.url(d)
            i.Image = path
            i.save()

        i = Inventory.objects.get(id=id)
        i.Productname = ProductName
        i.Description = Description
        i.Mandate = ManDate
        i.Price = Price
        i.Instock = Instock
        i.save()

        return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/sal_inv/'</script>''')


def edit_ser(request,id):
    ser = Services.objects.get(id=id)
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/EditServices saloon.html',{'data':ser})
def editser_post(request):
    Sername = request.POST['textfield']
    Description = request.POST['textarea']
    Duration = request.POST['textfield2']
    Price = request.POST['textfield3']
    id = request.POST['id']
    ser = Services.objects.get(id=id)
    ser.Servicename = Sername
    ser.Description = Description
    ser.Duration = Duration
    ser.Price = Price
    ser.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/viewsercat/'</script>''')


def sal_feedback(request):
    res = Feedback.objects.filter(SALOON__LOGIN_id=request.session['lid'])
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/Feedback saloon.html',{"data": res})
def sal_feedback_post(request):
    return render(request,'saloon/Feedback saloon.html')

def sal_inv(request):
    res = Inventory.objects.all()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/Inventory saloon.html',{"data": res})
def sal_inv_post(request):
    search = request.POST['textfield']
    res = Inventory.objects.filter(Productname__icontains=search)
    return render(request,'saloon/Inventory saloon.html',{"data": res})
def del_inv(request,id):
    v = Inventory.objects.get(id=id)
    v.delete()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("DELETED");window.location='/MyApp/sal_inv/'</script>''')

def reply(request,id):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/reply.html',{"id":id})
def reply_post(request):
    reply = request.POST['textarea']
    id = request.POST['id']
    Report.objects.filter(id=id).update(Status='replied',Reply=reply)
    return HttpResponse('''<script>alert("REPLIED");window.location='/MyApp/sal_report/'</script>''')

def sal_report(request):
    res = Report.objects.filter(SALOON__LOGIN_id=request.session['lid'])
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/Report saloon.html',{"data": res})
def sal_report_post(request):
    return render(request,'saloon/Report saloon.html')

def salview_emp(request):
    res = Employee.objects.filter(SALOON__LOGIN_id=request.session['lid'])
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/ViewEmp saloon.html',{"data": res})
def salview_emp_post(request):
    search = request.POST['textfield']
    res = Employee.objects.filter(Name__icontains=search)
    return render(request,'saloon/ViewEmp saloon.html',{"data": res})

def del_emp(request,id):
    v = Employee.objects.get(id=id)
    v.delete()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("DELETED");window.location='/MyApp/salview_emp/'</script>''')


def view_ser(request,id):
    res = Services.objects.filter(SALOON__LOGIN_id=request.session['lid'],SERVICESCAT_id=id)
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/ViewServices saloon.html',{"data": res,'id':id})
def view_ser_post(request):
    id = request.POST['id']
    Search = request.POST['textfield']
    res = Services.objects.filter(Servicename__icontains=Search,SERVICESCAT_id=id,SALOON__LOGIN_id=request.session['lid'])
    return render(request,'saloon/ViewServices saloon.html',{"data": res,'id':id})

def del_ser(request,id):
    v = Services.objects.get(id=id)
    v.delete()
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("DELETED");window.location='/MyApp/viewsercat/'</script>''')


def view_booking(request):
    res = Booking.objects.filter(SALOON__LOGIN_id=request.session['lid'],Status='pending')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'saloon/Booking saloon.html',{"data": res})
def view_booking_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Bookingsub.objects.filter(Date__range=[From, To])
    return render(request,'saloon/Booking saloon.html',{"data": res})

def more_book(request,id):
    res=Bookingsub.objects.filter(BOOKING__id=id)
    return render(request, 'saloon/morebook.html', {"data": res})
def bookk(request,id):
    return render(request, 'saloon/provide token.html',{'id':id})





def calview(request):
    if request.POST:
        month = int(request.POST['monthSelect'])

        a = Booking.objects.filter(Q( Status='approved',)|Q(Status='PAID'),SALOON__LOGIN_id=request.session['lid'])
        # a = Booking.objects.filter(BDate__month=month)
        tkns = []
        bookings = {0: 'no'}
        for i in a:
            f=Booking.objects.filter(Q( Status='approved',)|Q(Status='PAID'),BDate=i.BDate,SALOON__LOGIN_id=request.session['lid']).count()
            # if i.BDate ==
            tkns.append(i.Token)
            bdate = str(i.BDate).split('-')[1]
            user_name = i.USER.Name

            print(bdate)
            if len(bdate)==2 and bdate[0] == '0':
                bdate = bdate[1]
            if bdate == str(month):
                day = str(i.BDate).split('-')[2]
                bookings[int(day)] = ["yes", str(f)]
                bookings['user'] = user_name
                # bookings[day].append(user_name)
        return render(request, 'saloon/calender.html', {'month': month, 'bookings': bookings})
    return render(request, 'saloon/calender.html')


def calbook(request,id):
    obj=Bookingsub.objects.filter(BOOKING__BDate__day=id,BOOKING__SALOON__LOGIN_id=request.session['lid'])
    print(obj)
    return render(request, 'saloon/Viewcalbook.html',{"data": obj})

def saltime(request,id):

    return render(request, 'saloon/time.html',{"id":id})


# def accbook(request):
#     Token=request.POST['token']
#     tid=request.POST['tid']
#     Booking.objects.filter(id=tid).update(Status='approved',Token=Token)
#
#     if request.session['lid']=='':
#         return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
#     else:
#         return HttpResponse('''<script>alert("APPROVED");window.location='/MyApp/view_booking/'</script>''')



import random

def generate_unique_token(request,dt):
    token = 1
    bkd = Booking.objects.filter(BDate=dt,SALOON__LOGIN_id=request.session['lid']).exclude(Token='0').order_by('-id')
    if bkd.exists():
        s = bkd[0]
        if s.Token!='0':
            token = int(s.Token)+1

    return token


from django.core.mail import send_mail
from django.conf import settings
from django.http import HttpResponse
from .models import Booking

def accbook(request):
    id=request.POST['id']
    ti=request.POST['textfield']
    try:
        booking = Booking.objects.get(id=id)
    except Booking.DoesNotExist:
        return HttpResponse("Booking not found")

    # Generate a unique token
    token = generate_unique_token(request,booking.BDate)

    # Update the booking with the generated token and set status to 'approved'
    booking.Status = 'approved'
    booking.Time = ti
    booking.Token = token
    booking.save()

    user_email = booking.USER.Email



    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login("sreeragm655@gmail.com", "gssy jugc bnlw arhm")  # App Password
    to = user_email
    subject = "Booking Approval"
    body = 'Your booking has been approved. Your token number is ' + str(token)+" and "+ti
    msg = f"Subject: {subject}\n\n{body}"
    server.sendmail("s@gmail.com", to, msg)
        # Disconnect from the server        server.quit()
        # ress = Login.objects.filter(username=email).filter(password=new_pass)

    # Get the email of the user associated with the booking

    # Send the token number to the user's email
    # message = 'Your booking has been approved. Your token number is ' + str(token)


    # send_mail(
    #     'Booking Approval',
    #     message,
    #     settings.EMAIL_HOST_USER,
    #     [user_email],
    #     fail_silently=False
    # )

    if request.session.get('lid', '') == '':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
    else:
        return HttpResponse('''<script>alert("APPROVED");window.location='/MyApp/view_booking/'</script>''')


def view_accbook(request):
        res = Bookingsub.objects.filter(BOOKING__SALOON__LOGIN_id=request.session['lid'],BOOKING__Status='approved')
        if request.session['lid'] == '':
            return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
        else:
            return render(request,'saloon/Accbook.html', {"data": res})
def viewaccbook_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request,'saloon/Accbook.html', {"data": res})

def rejbook(request,id):
    a=Booking.objects.filter(id=id).update(Status='rejected')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
    else:
        return HttpResponse('''<script>alert("REJECTED");window.location='/MyApp/view_booking/'</script>''')

def view_rejbook(request):
    res = Bookingsub.objects.filter(BOOKING__Status='rejected')
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
    else:
        return render(request, 'saloon/Rejbook.html', {"data": res})
def viewrejbook_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Donation.objects.filter(Date__range=[From, To])
    return render(request, 'saloon/Rejbook.html', {"data": res})


def paymenthis(request):
    res = Payment.objects.filter(BOOKING__Status='PAID',BOOKING__SALOON__LOGIN_id=request.session['lid'])
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/view_booking/'</script>''')
    else:
        return render(request, 'saloon/paymenthis.html', {"data": res})


def paymenthis_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    res = Payment.objects.filter(Date__range=[From, To])
    return render(request, 'saloon/paymenthis.html', {"data": res})


def salchng_pass(request):
    if request.session['lid']=='':
        return HttpResponse('''<script>alert("TRY AGAIN");window.location='/MyApp/login/'</script>''')
    else:
        return render(request,'organization/Change Pass org.html')
def salchng_pass_post(request):
    currpass = request.POST['textfield']
    newpass = request.POST['textfield2']
    conpass = request.POST['textfield3']
    log = Login.objects.filter(Password=currpass)
    if log.exists():
        w = Login.objects.get(id=request.session['lid'],Password=currpass)
        if newpass == conpass:
            w = Login.objects.filter(id=request.session['lid']).update(Password=conpass)
            return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyApp/login/'</script>''')
        else:
            return HttpResponse(
                '''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/salchng_pass/'</script>''')
    else:
        return HttpResponse('''<script>alert("PASSWORD MISMATCH");window.location='/MyApp/salchng_pass/'</script>''')


def logout(request):
    request.session['lid']=''
    return HttpResponse('''<script>alert("SUCCESSFULLY LOGGED OUT");window.location='/MyApp/login/'</script>''')

def forgotpass(request):
    return render(request,"forgotpass.html")

def forgotpass_post(request):
    email=request.POST['textfield']
    import random
    password = random.randint(00000000, 99999999)
    log = Login.objects.filter(Username=email,type='saloon')|Login.objects.filter(Username=email,type='organization')
    if log.exists():
        logg = Login.objects.get(Username=email)
        message = 'temporary password is ' + str(password)
        send_mail(
            'temp password',
            message,
            settings.EMAIL_HOST_USER,
            [email, ],
            fail_silently=False
        )
        logg.Password = password
        logg.save()
        return HttpResponse('<script>alert("success");window.location="/MyApp/login/"</script>')
    else:
        return HttpResponse('<script>alert("invalid email");window.location="/MyApp/login/"</script>')


##############################USER#################################################

def User_login_post(request):
    username = request.POST['username']
    password = request.POST['password']
    n = Login.objects.filter(Username=username, Password=password)
    if n.exists():
        e = Login.objects.get(Username=username, Password=password)
        lid = e.id
        # s=User.objects.get(LOGIN_id=e.id)
        if e.type == 'user':
            return JsonResponse({'status': 'ok', "lid": str(lid),'type':e.type})

        else:
            return JsonResponse({'status': 'no'})
    else:
        return JsonResponse({'status': 'no'})

    #         return JsonResponse({'status':'ok',"lid":e.id,"name":s.name,"email":s.email,"photo":s.photo})
    #     else:
    #         return JsonResponse({'status':'bl',"lid":e.id,"name":s.name,"email":s.email,"photo":s.photo})
    # else:
    #     return JsonResponse({'status': 'no',"lid":"id","name":"name","email":"email","photo":"photo"})

def User_chngpass_post(request):
    currpass = request.POST['textfield']
    newpass = request.POST['textfield2']
    confpass = request.POST['textfield3']
    lid = request.POST['lid']
    w = Login.objects.get(id=lid)
    if w.Password==currpass:
        if newpass == confpass:
            s = Login.objects.filter(id=lid).update(Password=confpass)
            return JsonResponse({'status': 'ok'})
        else:
            return JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status': 'no'})


def User_signup_post(request):
    name = request.POST['name']
    age= request.POST['age']
    gender = request.POST['gender']
    phone = request.POST['phone']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']
    district = request.POST['district']
    state = request.POST['state']
    photo=request.POST['photo']
    import datetime
    import base64

    date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    a=base64.b64decode(photo)
    fh = open("C:\\Users\\USER\\PycharmProjects\\Saloon\\media\\user\\" + date + ".jpg", "wb")
    # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
    path = "/media/user/" + date + ".jpg"
    fh.write(a)
    fh.close()
    # fs=FileSystemStorage()
    # # fn=fs.save(date,photo)
    # path=fs.url(date)

    email = request.POST['email']
    password=request.POST['password']
    conpassword=request.POST['conpassword']

    lobj=Login()
    lobj.Username=email
    lobj.Password=conpassword
    lobj.type='user'
    lobj.save()

    uobj=User()
    uobj.Name=name
    uobj.Age=age
    uobj.Gender=gender
    uobj.Phone=phone
    uobj.Place=place
    uobj.Post=post
    uobj.Pin=pin
    uobj.District=district
    uobj.State=state
    uobj.Email=email
    uobj.Image=path
    uobj.LOGIN=lobj
    uobj.save()
    return JsonResponse({'status':'ok'})

def User_view_profile(request):
    lid=request.POST['lid']
    print("lid",lid)
    res=User.objects.get(LOGIN_id=lid)
    return JsonResponse({'status': 'ok','name':res.Name,'age':res.Age,'gender':res.Gender,'phone':res.Phone,'place':res.Place,'post':res.Post,'pin':res.Pin,'district':res.District,'state':res.State,'email':res.Email,'photo':res.Image})

def User_editprofile_post(request):
    lid=request.POST['lid']
    name = request.POST['name']
    age= request.POST['age']
    gender = request.POST['gender']
    phone = request.POST['phone']
    place = request.POST['place']
    post = request.POST['post']
    pin = request.POST['pin']
    district = request.POST['district']
    state = request.POST['state']
    photo=request.POST['photo']
    email = request.POST['email']
    uobj=User.objects.get(LOGIN_id=lid)

    if len(photo) > 0:
        import datetime
        import base64

        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        a = base64.b64decode(photo)
        fh = open("C:\\Users\\USER\\PycharmProjects\\Saloon\\media\\user\\" + date + ".jpg", "wb")
        # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
        path = "/media/user/" + date + ".jpg"
        fh.write(a)
        fh.close()
        uobj.Image=path
        uobj.save()

    uobj.Name = name
    uobj.Age = age
    uobj.Gender = gender
    uobj.Phone = phone
    uobj.Place = place
    uobj.Post = post
    uobj.Pin = pin
    uobj.District = district
    uobj.State = state
    uobj.Email = email
    uobj.save()
    return JsonResponse({'status':'ok'})


# def User_viewsaloon(request):
#     search=request.POST['search']
#     n=Saloon.objects.filter(Name__icontains=search,)
#     l=[]
#     for i in n:
#         l.append({"id":i.id,"name":i.Name,"ownername":i.Ownername,"phone":i.Phone,"image":i.Image,"place":i.Place,"post":i.Post,"pin":i.Pin,"district":i.District,"state":i.State,"email":i.Email})
#     print(l)
#     return JsonResponse({'status':'ok','data':l})


def User_viewsaloon(request):
    # Get the search parameter from the POST data
    search = request.POST.get('search', '')

    # Filter Saloon objects based on the search term (Name or Pin)
    if search:
        # Filter Saloon objects where the name contains the search term
        name_results = Saloon.objects.filter(Name__icontains=search)

        # Filter Saloon objects where the pin code matches the search term
        pin_results = Saloon.objects.filter(Pin__icontains=search)

        # Combine the results
        n = name_results | pin_results
    else:
        # If no search term provided, return all Saloon objects
        n = Saloon.objects.all()

    # Construct a list of dictionaries containing selected fields of the Saloon objects
    saloons_data = []
    for saloon in n:
        saloons_data.append({
            "id": saloon.id,
            "name": saloon.Name,
            "ownername": saloon.Ownername,
            "phone": saloon.Phone,
            "image": saloon.Image,
            "place": saloon.Place,
            "post": saloon.Post,
            "pin": saloon.Pin,
            "district": saloon.District,
            "state": saloon.State,
            "email": saloon.Email
        })

    # Return a JSON response with the filtered data
    return JsonResponse({'status': 'ok', 'data': saloons_data})
def User_report_post(request):
    repmsg=request.POST['textfield']
    salid=request.POST['salid']
    lid=request.POST['lid']

    robj=Report()
    import datetime
    robj.SALOON_id=salid
    robj.Reporteddate=datetime.datetime.now().date()
    robj.USER=User.objects.get(LOGIN=lid)
    robj.Reportmsg=repmsg
    robj.Status="pending"
    robj.save()
    return JsonResponse({'status':'ok'})

def User_feedback_post(request):
    feedbackmsg=request.POST['textfield']
    fid=request.POST['fid']
    lid=request.POST['lid']

    robj=Feedback()
    import datetime
    robj.Date=datetime.datetime.now().date()
    robj.SALOON_id=fid
    robj.USER=User.objects.get(LOGIN=lid)
    robj.Feedbackmsg=feedbackmsg
    robj.save()
    return JsonResponse({'status':'ok'})

def User_viewinv(request):
    search = request.POST['search']
    sid=request.POST['sid']

    n = Inventory.objects.filter(Productname__icontains=search,SALOON_id=sid)
    l=[]
    for i in n:
        l.append({"id":i.id,"productname":i.Productname,"description":i.Description,"mandate":i.Mandate,"photos":i.Images,"price":i.Price,"instock":i.Instock})
    print(l)
    return JsonResponse({'status':'ok','data':l})

def User_viewser(request):
    pid=request.POST['pid']
    n=Services.objects.filter(SALOON_id=pid)
    l=[]
    for i in n:
        l.append({"id":i.id,"sername":i.Servicename,"description":i.Description,"duration":i.Duration,"price":i.Price})
    print(l)
    return JsonResponse({'status':'ok','data':l})

def User_viewreportreply(request):
    lid=request.POST['lid']
    n=Report.objects.filter(USER__LOGIN_id=lid)
    l=[]
    for i in n:
        l.append({"id":i.id,"reporteddate":i.Reporteddate,"reportmsg":i.Reportmsg,"reporton":i.SALOON.Name,"replymsg":i.Reply})
    print(l)
    return JsonResponse({'status':'ok','data':l})

def User_addcart(request):
    lid=request.POST['lid']
    sid=request.POST['sid']
    print(request.POST)
    obj=Cart()
    obj.SERVICE_id=sid
    obj.USER=User.objects.get(LOGIN=lid)
    obj.save()
    return JsonResponse({'status':'ok'})

def User_viewcart(request):
    lid=request.POST['lid']
    n = Cart.objects.filter(USER__LOGIN_id=lid)
    l = []
    for i in n:
        l.append({"id": i.id, "salname":i.SERVICE.SALOON.Name,"sername": i.SERVICE.Servicename, "duration": i.SERVICE.Duration, "sid":i.SERVICE.id,
                  "price": i.SERVICE.Price})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})

def User_cartdel(request):
    cid = request.POST['cid']
    a = Cart.objects.filter(id=cid).delete()
    return JsonResponse({'status': 'ok'})


def User_book(request):
    lid=request.POST['lid']
    aid=request.POST['aid']
    print(aid,'id')
    Date = request.POST['textfield']
    Time = request.POST['textfield1']
    obj=Booking()
    import datetime
    obj.BDate=Date
    obj.Date=datetime.datetime.now().today()
    obj.Time=Time
    obj.Token='0'
    obj.Status='pending'
    obj.USER=User.objects.get(LOGIN_id=lid)
    obj.SALOON_id=Services.objects.get(id=aid).SALOON.id
    pp=Services.objects.get(id=aid).Price
    obj.Amount=pp
    obj.save()

    b=Bookingsub()
    b.BOOKING=obj
    b.SERVICES_id=aid
    b.save()

    return JsonResponse({'status': 'ok'})

def User_cartbook(request):
    lid=request.POST['lid']
    Date=request.POST['textfield']
    Time=request.POST['textfield1']
    obj=Cart.objects.filter(USER__LOGIN_id=lid).values_list('SERVICE__SALOON_id').distinct()
    for i in obj:
        mytotal = 0
        res2= Cart.objects.filter(USER__LOGIN_id=lid,SERVICE__SALOON_id=i[0])
        boj=Booking()
        boj.USER=User.objects.get(LOGIN_id=lid)
        boj.Amount=0
        import datetime
        boj.Date = datetime.datetime.now().date().today()
        boj.BDate = Date
        boj.Time = Time
        boj.Token=0
        boj.SALOON_id=i[0]
        boj.Status='pending'
        boj.save()

        for j in res2:
            bs=Bookingsub()
            bs.BOOKING_id=boj.id
            bs.SERVICES_id=j.SERVICE.id
            bs.save()
            mytotal+=(float(j.SERVICE.Price))
            print(mytotal)
            Cart.objects.filter(SERVICE__SALOON_id=i[0],USER__LOGIN_id=lid).delete()
            boj=Booking.objects.get(id=boj.id)
            boj.Amount=mytotal
            boj.save()
    return JsonResponse({'k':'0','status': 'ok'})

def User_viewbookinghis(request):

    lid=request.POST['lid']
    n = Booking.objects.filter(USER__LOGIN_id=lid)
    l = []
    for i in n:
        l.append({"id":i.id,"bbid": i.id, "salname":i.SALOON.Name,"time":i.Time,"totamount": i.Amount, "status": i.Status,"bdate": i.BDate,"token": i.Token,})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})


def User_viewbookinghismore(request):
    bid=request.POST['bid']
    n = Bookingsub.objects.filter(BOOKING_id=bid)
    l=[]
    for i in n:
        l.append({"id": i.id,"sid": i.SERVICES.SALOON.id,"time":i.BOOKING.Time, "sername":i.SERVICES.Servicename,"description": i.SERVICES.Description, "duration": i.SERVICES.Duration, "price": i.SERVICES.Price, "salname": i.BOOKING.SALOON.Name, "salphn": i.BOOKING.SALOON.Phone })
    return JsonResponse({'status': 'ok','data':l})

def User_bookcancel(request):
    id = request.POST['id']
    a = Booking.objects.filter(id=id).delete()
    b = Bookingsub.objects.filter(BOOKING_id=id).delete()
    return JsonResponse({'status': 'ok'})

def User_reschedule(request):
    bid = request.POST['bid']
    date = request.POST['date']
    Time = request.POST['time']
    obj = Booking.objects.get(id=bid)
    obj.Date=datetime.now().date()
    obj.BDate =date
    obj.Time = Time
    # obj.Status='pending'
    obj.save()
    return JsonResponse({'status': 'ok'})

def paid(request):
    bbid=request.POST['bbid']
    lid=request.POST['lid']
    Booking.objects.filter(id=bbid).update(Status='PAID')
    obj=Payment()
    obj.Date=datetime.now().date()
    obj.BOOKING_id=bbid
    obj.USER=User.objects.get(LOGIN=lid)
    obj.Amount=Booking.objects.get(id=bbid).Amount
    obj.save()
    return JsonResponse({'status': 'ok'})

def User_paymenthis(request):
    lid=request.POST['lid']
    obj = Payment.objects.filter(USER__LOGIN_id=lid)
    l = []
    for i in obj:
        l.append({"id": i.id, "date": i.Date, "salname": i.BOOKING.SALOON.Name, "amount": i.Amount,
                  "bdate": i.BOOKING.BDate})
    return JsonResponse({'status': 'ok', 'data': l})

def User_searchbook(request):
    # From = request.POST['from']
    # To = request.POST['to']
    From = datetime.strptime(request.POST['from'], '%Y-%m-%d %H:%M:%S.%f')
    To = datetime.strptime(request.POST['to'], '%Y-%m-%d %H:%M:%S.%f')
    lid = request.POST['lid']
    print(request.POST)
    # res = Bookingsub.objects.filter(Date__range=[From, To])
    lid=request.POST['lid']
    n = Booking.objects.filter(USER__LOGIN_id=lid,Date__range=[From, To])
    l = []
    for i in n:
        l.append({"id":i.id,"bbid": i.id, "salname":i.SALOON.Name,"time":i.Time,"totamount": i.Amount, "status": i.Status,"bdate": i.BDate,})
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})


def forget_password_post(request):
    em = request.POST['em_add']
    import random
    password = random.randint(00000000, 99999999)
    log = Login.objects.filter(Username=em,type='user')
    if log.exists():
        logg = Login.objects.get(Username=em)
        message = 'temporary password is ' + str(password)
        send_mail(
            'temp password',
            message,
            settings.EMAIL_HOST_USER,
            [em, ],
            fail_silently=False
        )
        logg.Password = password
        logg.save()
        return JsonResponse({'status': 'ok'})
    else:
        return JsonResponse({'status': 'no'})

def User_viewsercat(request):
    sid=request.POST['sid']
    n = Servicescat.objects.filter(SALOON_id=sid)
    l=[]
    for i in n:
        l.append({"id": i.id,"category":i.Category })
    return JsonResponse({'status': 'ok','data':l})
def User_viewserbycat(request):
    cat=request.POST['cid']
    sid=request.POST['sid']
    n=Services.objects.filter(SALOON_id=sid,SERVICESCAT_id=cat)
    l=[]
    for i in n:
        l.append({"id":i.id,"sername":i.Servicename,"description":i.Description,"duration":i.Duration,"price":i.Price})
    print(l)
    return JsonResponse({'status':'ok','data':l})