# Generated by Django 4.0.1 on 2023-09-28 11:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MyAPP', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='status',
            field=models.CharField(default='pending', max_length=100),
            preserve_default=False,
        ),
    ]
