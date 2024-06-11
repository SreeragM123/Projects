
from django.contrib import admin
from django.urls import path, include

from MyApp import views

urlpatterns = [
    path('login/',views.login),
    path('login_post/', views.login_post),

    path('logout/', views.logout),

    path('adminhome/', views.adminhome),

    path('add_saloon/',views.add_saloon),
    path('addsal_post/', views.addsal_post),

    path('chng_pass/',views.chng_pass),
    path('chngpass_post/', views.chngpass_post),

    path('don_his/', views.don_his),
    path('don_his_post/', views.don_his_post),

    # path('don_mng/', views.don_mng),
    # path('don_mng_post/', views.don_mng_post),
    #
    path('adaccdonreq/<id>', views.adaccdonreq),
    path('view_adaccdonreq/', views.view_adaccdonreq),
    path('viewadaccdon_post/', views.viewadaccdon_post),


    # path('rejectdon/<id>', views.rejectdon),
    # path('view_rejdon/', views.view_rejdon),
    # path('viewrejdon_post/', views.viewrejdon_post),

    path('view_org/', views.view_org),
    path('vieworg_post/', views.vieworg_post),

    path('view_apporg/', views.view_apporg),
    path('viewapporg_post/', views.viewapporg_post),

    path('approveorg/<id>', views.approveorg),

    path('view_rejorg/', views.view_rejorg),
    path('viewrejorg_post/', views.viewrejorg_post),

    path('rejectorg/<id>', views.rejectorg),

    path('edit_saloon/<id>', views.edit_saloon),
    path('editsal_post/', views.editsal_post),

    path('feedback/', views.feedback),
    path('feedback_post/', views.feedback_post),

    path('report/', views.report),
    path('report_post/', views.report_post),

    path('view_saloon/', views.view_saloon),
    path('view_saloon_post/', views.view_saloon_post),

    path('del_sal/<id>', views.del_sal),


    path('view_emp/', views.view_emp),
    path('view_emp_post/', views.view_emp_post),



    path('orghome/', views.orghome),

    path('orgchng_pass/', views.orgchng_pass),
    path('orgchng_pass_post/', views.orgchng_pass_post),

    path('don_req/', views.don_req),
    path('donreq_post/', views.donreq_post),

    path('org_signup/', views.org_signup),
    path('orgsignup_post/', views.orgsignup_post),

    path('view_donreq/', views.view_donreq),
    path('view_donreq_post/', views.view_donreq_post),

    path('view_appdon/', views.view_appdon),
    path('viewappdon_post/', views.viewappdon_post),
    path('view_rejdon/', views.view_rejdon),
    path('viewrejdon_post/', views.viewrejdon_post),



    path('saloonhome/', views.saloonhome),

    path('add_emp/', views.add_emp),
    path('addemp_post/', views.addemp_post),

    path('add_inv/', views.add_inv),
    path('addinv_post/', views.addinv_post),

    path('add_ser/<id>', views.add_ser),
    path('addser_post/', views.addser_post),

    path('more_book/<id>', views.more_book),

    # path('book_saloon/', views.book_saloon),
    # path('book_saloon_post/', views.book_saloon_post),

    path('sal_donreq/', views.sal_donreq),
    path('sal_donreq_post/', views.sal_donreq_post),

    path('accdonreq/<id>', views.accdonreq),
    path('view_accdonreq/', views.view_accdonreq),
    path('viewaccdonreq_post/', views.viewaccdonreq_post),

    path('rejdonreq/<id>', views.rejdonreq),
    path('view_rejdonreq/', views.view_rejdonreq),
    path('viewrejdonreq_post/', views.viewrejdonreq_post),

    path('edit_emp/<id>', views.edit_emp),
    path('editemp_post/', views.editemp_post),

    path('del_emp/<id>', views.del_emp),

    path('edit_inv/<id>', views.edit_inv),
    path('editinv_post/', views.editinv_post),

    path('edit_ser/<id>', views.edit_ser),
    path('editser_post/', views.editser_post),

    path('del_ser/<id>', views.del_ser),

    path('sal_feedback/', views.sal_feedback),
    path('sal_feedback_post/', views.sal_feedback_post),

    path('sal_inv/', views.sal_inv),
    path('sal_inv_post/', views.sal_inv_post),

    path('outofstock/<id>', views.outofstock),
    path('avl/<id>', views.avl),

    path('del_inv/<id>', views.del_inv),

    path('reply/<id>', views.reply),
    path('reply_post/', views.reply_post),

    path('sal_report/', views.sal_report),
    path('sal_report_post/', views.sal_report_post),

    path('salview_emp/', views.salview_emp),
    path('salview_emp_post/', views.salview_emp_post),

    path('view_booking/', views.view_booking),
    path('view_booking_post/', views.view_booking_post),
    path('accbook/', views.accbook),
    path('bookk/<id>', views.bookk),
    path('view_accbook/', views.view_accbook),
    path('viewaccbook_post/', views.viewaccbook_post),
    path('rejbook/<id>', views.rejbook),
    path('view_rejbook/', views.view_rejbook),
    path('viewrejbook_post/', views.viewrejbook_post),
    path('calview/', views.calview),
    path('calbook/<id>', views.calbook),
    path('saltime/<id>', views.saltime),


    path('view_ser/<id>', views.view_ser),
    path('view_ser_post/', views.view_ser_post),
    path('addsercat/', views.addsercat),
    path('addsercat_post/', views.addsercat_post),
    path('viewsercat/', views.viewsercat),
    path('view_sercat_post/', views.view_sercat_post),
    path('del_sercat/<id>', views.del_sercat),

    path('paymenthis/', views.paymenthis),
    path('paymenthis_post/', views.paymenthis_post),

    path('salchng_pass/', views.salchng_pass),
    path('salchng_pass_post/', views.salchng_pass_post),

    path('forgotpass/', views.forgotpass),
    path('forgotpass_post/', views.forgotpass_post),



    path('User_login_post/',views.User_login_post),
    path('User_signup_post/',views.User_signup_post),
    path('User_editprofile_post/', views.User_editprofile_post),
    path('User_view_profile/', views.User_view_profile),
    path('User_viewser/', views.User_viewser),
    path('User_viewserbycat/', views.User_viewserbycat),
    path('User_viewinv/', views.User_viewinv),
    path('User_viewsaloon/', views.User_viewsaloon),
    path('User_viewsercat/', views.User_viewsercat),
    path('User_book/', views.User_book),
    path('User_viewbookinghis/', views.User_viewbookinghis),
    path('User_viewbookinghismore/', views.User_viewbookinghismore),
    path('User_addcart/', views.User_addcart),
    path('User_viewcart/', views.User_viewcart),
    path('User_cartdel/', views.User_cartdel),
    path('User_cartbook/', views.User_cartbook),
    path('User_reschedule/', views.User_reschedule),
    path('User_bookcancel/', views.User_bookcancel),
    path('User_report_post/', views.User_report_post),
    path('User_viewreportreply/', views.User_viewreportreply),
    path('User_feedback_post/', views.User_feedback_post),
    path('User_chngpass_post/', views.User_chngpass_post),
    path('paid/', views.paid),
    path('User_paymenthis/', views.User_paymenthis),
    path('User_searchbook/', views.User_searchbook),
    path('forget_password_post/', views.forget_password_post),

]
