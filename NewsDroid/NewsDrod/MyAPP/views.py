from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.core.mail import send_mail
from django.conf import settings

# Create your views here.
from MyAPP.models import Login, News, Report, User


def addnews(request):
    return render(request,"AddNews.html")

def addnews_post(request):
    date=request.POST['date']
    title=request.POST['textfield']
    description=request.POST['textarea']
    place=request.POST['textfield2']
    city=request.POST['textfield3']
    state=request.POST['textfield4']
    cat=request.POST['category']
    if 'fileField' in request.FILES:
        photos = request.FILES['fileField']
        if photos !="":
            fs = FileSystemStorage()
            from datetime import datetime
            d="news/"+datetime.now().strftime("%Y%m%d%H%M%S")+".jpg"
            fn=fs.save(d, photos)
            d = News()
            d.title = title
            d.description = description
            d.photos = fs.url(fn)
            d.place = place
            d.city = city
            d.date = date
            d.state = state
            d.category = cat
            d.LOGIN_id = request.session["lid"]
            d.status = "approved"
            d.type = "admin"
            d.save()
    else:

        d=News()
        d.title=title
        d.description=description
        d.place=place
        d.city=city
        d.date=date
        d.state=state
        d.category=cat
        d.LOGIN_id=request.session["lid"]
        d.status="approved"
        d.type="admin"
        d.save()
    return HttpResponse('''<script>alert("SUCCESSFULLY ADDED");window.location='/MyAPP/adminhome/'</script>''')


def adminhome(request):
   return render(request,"adminindex.html")

def chngpass(request):
    return render(request,"ChngPass.html")

def chngpass_post(request):
    oldpass=request.POST['textfield']
    newpass=request.POST['textfield2']
    confpass=request.POST['textfield3']
    w=Login.objects.get(id=request.session['lid'],password=oldpass)
    if newpass==confpass:
        s=Login.objects.filter(id=request.session['lid']).update(password=confpass)
        return HttpResponse('''<script>alert("SUCCESSFULLY CHANGED");window.location='/MyAPP/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("PASSWORD MISMATCH");window.location='/MyAPP/chngpass/'</script>''')



def editnews(request,id):
    v=News.objects.get(id=id)
    return render(request,"EditNews.html",{'data':v})

def editnews_post(request):
    date=request.POST['date']
    title=request.POST['textfield']
    description=request.POST['textarea']
    place=request.POST['textfield2']
    city=request.POST['textfield3']
    state=request.POST['textfield4']
    cat=request.POST['category']
    nid=request.POST['nid']

    from datetime import datetime
    if 'fileField' in request.FILES:
         photos = request.FILES['fileField']

         fs = FileSystemStorage()
         d = "news/" + datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
         fn = fs.save(d, photos)

         d = News.objects.get(id=nid)
         d.title = title
         d.description = description
         d.photos = fs.url(fn)
         d.place = place
         d.city = city
         d.date = date
         d.state = state
         d.category = cat
         d.save()
         return HttpResponse('''<script>alert("SUCCESSFULLY UPDATED");window.location='/MyAPP/viewnews/'</script>''')
    else:
        d = News.objects.get(id=nid)
        d.title = title
        d.description = description
        d.place = place
        d.city = city
        d.state = state
        d.category = cat
        d.date = date
        d.save()
        return HttpResponse('''<script>alert("SUCCESSFULLY UPDATED");window.location='/MyAPP/viewnews/'</script>''')


def delete_news(request,id):
    v=News.objects.get(id=id)
    v.delete()
    return HttpResponse('''<script>alert("DELETED");window.location='/MyAPP/viewnews/'</script>''')


def login(request):
    return render(request,"login.html")


def login_post(request):
    username=request.POST['textfield']
    password=request.POST['textfield2']
    n=Login.objects.filter(username=username,password=password)
    if n.exists():
        e=Login.objects.get(username=username,password=password)
        request.session['lid']=e.id
        if e.type=='admin':
            return HttpResponse('''<script>alert("SUCCESSFULLY LOGGED IN");window.location='/MyAPP/adminhome/'</script>''')
        else:
            return HttpResponse('''<script>alert("INVALID USERNAME & PASSWORD");window.location='/MyAPP/login/'</script>''')
    else:
        return HttpResponse('''<script>alert("NOT FOUND");window.location='/MyAPP/login/'</script>''')



def mnguser(request):
    d=User.objects.filter(status='pending')
    return render(request,"ManageUser.html",{'r':d})

def mngusr_search(request):
    usr=request.POST['textfield']
    d=User.objects.filter(name__contains=usr)
    return render(request,"ManageUser.html",{'r':d})

def mngusernews(request,id):
    o=News.objects.filter(LOGIN_id=id,status='pending')
    return render(request,"ManageUserNews.html",{'data':o})


def mngusrnews_search(request):
    fromd=request.POST['textfield']
    tod=request.POST['textfield2']
    n = News.objects.filter(date__range=[fromd,tod])
    return render(request, "ManageUserNews.html", {'data': n})


def viewnews(request):
    n=News.objects.all()
    return render(request,"ViewNews.html",{'e':n})


def viewnews_search(request):

    # if request.POST["button"]=="Search":
        fromd=request.POST['textfield']
        tod=request.POST['textfield2']

        n = News.objects.filter(date__range=[fromd,tod])
        return render(request, "ViewNews.html", {'e': n})
    # else:
    #     category = request.POST['cate']
    #     n = News.objects.filter(category__icontains=category)
    #     return render(request, "ViewNews.html", {'e': n})


def viewnews_search_date(request):
    category = request.POST['cate']
    n = News.objects.filter(category__icontains=category)
    return render(request, "ViewNews.html", {'e': n})




def viewrep(request):
    s=Report.objects.all()
    return render(request,"ViewReports.html",{'w':s})

def remove_news(request,id):
    v=Report.objects.get(id=id)
    v.delete()
    return HttpResponse('''<script>alert("REMOVED");window.location='/MyAPP/adminhome/'</script>''')

def viewusernews(request):
    s=News.objects.filter(status='pending')
    return render(request,"ManageUserNews.html",{'data':s})

def approveusrnews(request,id):
    a=News.objects.filter(id=id).update(status='approve')
    return HttpResponse('''<script>alert("APPROVED");window.location='/MyAPP/viewusernews/'</script>''')


def viewapprovednews(request):
    e=News.objects.filter(status='approve')
    return render(request,"viewapproved.html",{'data':e})


def approvednews_search(request):
    fromd = request.POST['textfield']
    tod = request.POST['textfield2']
    n = News.objects.filter(date__range=[fromd, tod],status='approve')
    return render(request, "viewapproved.html",{'data': n})


def rejectusrnews(request,id):
    a=News.objects.filter(id=id).update(status='reject')
    return HttpResponse('''<script>alert("REJECTED");window.location='/MyAPP/viewusernews/'</script>''')

def viewrejectednews(request):
    e=News.objects.filter(status='reject')
    return render(request,"viewrejected.html",{'data':e})

def rejectednews_search(request):
    fromd = request.POST['textfield']
    tod = request.POST['textfield2']
    n = News.objects.filter(date__range=[fromd, tod],status='reject')
    return render(request, "viewrejected.html",{'data': n})


def blockusr(request,id):
    t=User.objects.filter(LOGIN=id).update(status='block')
    Login.objects.filter(id=id).update(type='blocked')
    return HttpResponse('''<script>alert("BLOCKED");window.location='/MyAPP/mnguser/'</script>''')

def viewblockedusr(request):
    e=User.objects.filter(status='block')
    return render(request,"blockeduser.html",{'r':e})


def blockedusr_search(request):
    usr=request.POST['textfield']
    d=User.objects.filter(name__contains=usr)
    return render(request,"blockeduser.html",{'r':d})


def unblockusr(request,id):
    a=User.objects.filter(LOGIN=id).update(status='pending')
    Login.objects.filter(id=id).update(type='user')
    return HttpResponse('''<script>alert("UNBLOCKED");window.location='/MyAPP/mnguser/'</script>''')

def viewunblockedusr(request):
    e=User.objects.filter(status='unblock')
    return render(request,"unblockeduser.html",{'r':e})


def unblockedusr_search(request):
    usr=request.POST['textfield']
    d=User.objects.filter(name__contains=usr)
    return render(request,"unblockeduser.html",{'r':d})

def logout(request):
    return HttpResponse('''<script>alert("Logged Out");window.location='/MyAPP/login/'</script>''')

def forgotpass(request):
    return render(request,"forgotpass.html")

def forgotpass_post(request):
    email=request.POST['textfield']
    import random
    password = random.randint(00000000, 99999999)
    log = Login.objects.filter(username=email)
    if log.exists():
        logg = Login.objects.get(username=email)
        message = 'temporary password is ' + str(password)
        send_mail(
            'temp password',
            message,
            settings.EMAIL_HOST_USER,
            [email, ],
            fail_silently=False
        )
        logg.password = password
        logg.save()
        return HttpResponse('<script>alert("success");window.location="/MyAPP/login/"</script>')
    else:
        return HttpResponse('<script>alert("invalid email");window.location="/MyAPP/login/"</script>')


##############################USER#################################################

def User_login_post(request):
    username = request.POST['username']
    password = request.POST['password']
    n = Login.objects.filter(username=username, password=password)
    if n.exists():
        e = Login.objects.get(username=username, password=password)
        s=User.objects.get(LOGIN_id=e.id)
        if e.type == 'user':
            return JsonResponse({'status':'ok',"lid":e.id,"name":s.name,"email":s.email,"photo":s.photo})
        else:
            return JsonResponse({'status':'bl',"lid":e.id,"name":s.name,"email":s.email,"photo":s.photo})
    else:
        return JsonResponse({'status': 'no',"lid":"id","name":"name","email":"email","photo":"photo"})

def User_signup_post(request):
    name = request.POST['name']
    dob= request.POST['date']
    gender = request.POST['gender']
    phone = request.POST['phone']
    place = request.POST['place']
    city = request.POST['city']
    state = request.POST['state']
    photo=request.POST['photo']
    import datetime
    import base64

    date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    a=base64.b64decode(photo)
    fh = open("C:\\Users\\USER\\PycharmProjects\\NewsDrod\\media\\user\\" + date + ".jpg", "wb")
    # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
    path = "/media/user/" + date + ".jpg"
    fh.write(a)
    fh.close()
    # fs=FileSystemStorage()
    # # fn=fs.save(date,photo)
    # path=fs.url(date)

    email = request.POST['email']
    password=request.POST['password']
    conpassword=request.POST['password']

    lobj=Login()
    lobj.username=email
    lobj.password=conpassword
    lobj.type='user'
    lobj.save()

    uobj=User()
    uobj.name=name
    uobj.dob=dob
    uobj.gender=gender
    uobj.phone=phone
    uobj.place=place
    uobj.city=city
    uobj.state=state
    uobj.email=email
    uobj.photo=path
    uobj.status='pending'
    uobj.LOGIN=lobj
    uobj.save()
    return JsonResponse({'status':'ok'})

def User_view_profile(request):
    lid=request.POST['lid']
    res=User.objects.get(LOGIN=Login.objects.get(pk=lid))
    return JsonResponse({'status': 'ok','id':res.id,'name':res.name,'dob':res.dob,'gender':res.gender,'phone':res.phone,'place':res.place,'city':res.city,'state':res.state,'email':res.email,'photos':res.photo})


def User_editprofile_post(request):
    lid=request.POST['lid']
    name = request.POST['name']
    dob = request.POST['date']
    gender = request.POST['gender']
    phone = request.POST['phone']
    place = request.POST['place']
    city = request.POST['city']
    state = request.POST['state']
    email = request.POST['email']
    photo = request.POST['photo']
    print(photo)

    eobj = User.objects.get(LOGIN_id=lid)

    if len(photo)>0:
        import datetime
        import base64
        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        a = base64.b64decode(photo)
        fh = open("C:\\Users\\USER\\PycharmProjects\\NewsDrod\\media\\user\\" + date + ".jpg", "wb")
        # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
        path = "/media/user/" + date + ".jpg"
        fh.write(a)
        fh.close()
        eobj.photo=path
        eobj.save()
    eobj.name = name
    eobj.dob = dob
    eobj.gender = gender
    eobj.phone = phone
    eobj.place = place
    eobj.city = city
    eobj.state = state
    eobj.email = email
    eobj.save()
    return JsonResponse({'status': 'ok'})

def User_addnews_post(request):
    lid = request.POST['lid']
    title = request.POST['textfield']
    description = request.POST['textarea']
    photos = request.POST['fileField']
    place = request.POST['textfield2']
    city = request.POST['textfield3']
    state = request.POST['textfield4']
    cat = request.POST['category']

    import datetime
    import base64
    date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    a = base64.b64decode(photos)
    fh = open("C:\\Users\\USER\\PycharmProjects\\NewsDrod\\media\\news\\" + date + ".jpg", "wb")
    # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
    path = "/media/news/" + date + ".jpg"
    fh.write(a)
    fh.close()

    nobj=News()
    nobj.date=datetime.datetime.now().date()
    nobj.title=title
    nobj.description=description
    nobj.photos=path
    nobj.place=place
    nobj.city=city
    nobj.state=state
    nobj.category=cat
    nobj.LOGIN_id=lid
    nobj.type='user'
    nobj.status='pending'
    nobj.save()
    return JsonResponse({'status':'ok'})

def User_editview_news(request):
    mnid=request.POST['mnid']
    res=News.objects.get(id=mnid)
    return JsonResponse({'status': 'ok','id':res.id,'title':res.title,'description':res.description,'place':res.place,'date':res.date,'city':res.city,'state':res.state,'cat':res.category,'photos':res.photos})



def User_editnews_post(request):
    id=request.POST['mnid']
    title = request.POST['textfield']
    description = request.POST['textarea']
    photos = request.POST['fileField']
    place = request.POST['textfield2']
    city = request.POST['textfield3']
    state = request.POST['textfield4']
    cat = request.POST['category']

    enobj = News.objects.get(id=id)


    if len(photos)>0:

        import datetime
        import base64
        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        a = base64.b64decode(photos)
        fh = open("C:\\Users\\USER\\PycharmProjects\\NewsDrod\\media\\news\\" + date + ".jpg", "wb")
        # fh = open("C:\\Users\\91815\\PycharmProjects\\cyber\\media\\" + date + ".jpg", "wb")
        path = "/media/news/" + date + ".jpg"
        fh.write(a)
        fh.close()
        enobj.photos = path
        enobj.save()
    enobj.title = title
    enobj.description = description
    enobj.place=place
    enobj.city = city
    enobj.status = state
    enobj.category = cat
    enobj.save()

    return JsonResponse({'status':'ok'})

def User_viewnews(request):
    search=request.POST['Search']
    n=News.objects.filter(status='approve',title__icontains=search).order_by('-date')|News.objects.filter(status='approve',category__icontains=search).order_by('-date')
    l=[]
    for i in n:
        l.append({"id":i.id,"title":i.title,"description":i.description,"photos":i.photos,"place":i.place,"city":i.city,"state":i.state,"date":i.date,"category":i.category})
    print(l)
    return JsonResponse({'status':'ok','data':l})

def User_viewnews_date(request):
    search=request.POST['date']
    n=News.objects.filter(status='approve',date__icontains=search)
    l=[]
    for i in n:
        l.append({"id":i.id,"title":i.title,"description":i.description,"photos":i.photos,"place":i.place,"city":i.city,"state":i.state,"date":i.date,"category":i.category})
    return JsonResponse({'status':'ok','data':l})


def User_viewmynews(request):
    lid=request.POST['lid']
    un=News.objects.filter(LOGIN_id=lid).order_by('-date')
    l = []
    for i in un:
        l.append({"id": i.id,"title":i.title,"description":i.description,"photos":i.photos,"place":i.place,"city":i.city,"state":i.state,"date":i.date,"category":i.category})
    return JsonResponse({'status': 'ok', 'data': l})


def User_reportnews_post(request):
    repmsg=request.POST['textarea']
    nid=request.POST['nid']
    lid=request.POST['lid']

    robj=Report()
    import datetime
    robj.date=datetime.datetime.now().date()
    robj.NEWS_id=nid
    robj.USER=User.objects.get(LOGIN=lid)
    robj.reportmsg=repmsg
    robj.status="pending"
    robj.save()
    return JsonResponse({'status':'ok'})

def User_chngpass_post(request):
    oldpass = request.POST['textfield']
    newpass = request.POST['textfield2']
    confpass = request.POST['textfield3']
    lid = request.POST['lid']
    w = Login.objects.get(id=lid)
    if w.password==oldpass:
        if newpass == confpass:
            s = Login.objects.filter(id=lid).update(password=confpass)
            return JsonResponse({'status': 'ok'})
        else:
            return JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status': 'no'})


def User_delete_news(request):
    id=request.POST['mnid']
    a=News.objects.get(id=id)
    a.delete()
    return JsonResponse({'status': 'ok'})



def forgot_pass_post(request):
    em = request.POST['em_add']
    import random
    password = random.randint(00000000,99999999)
    log=Login.objects.filter(username=em)
    if log.exists():
        logg = Login.objects.get(username=em)
        message = 'temporary password is ' + str(password)
        send_mail(
            'temp password',
            message,
            settings.EMAIL_HOST_USER,
            [em, ],
            fail_silently=False
        )
        logg.password=password
        logg.save()
        return JsonResponse({'status': 'ok'})
    else:
        return JsonResponse({'status': 'no'})
