from django import forms

class Bootstrap:
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
            field.widget.attrs['placeholder'] = field.label

class BootStrapModelForm(Bootstrap,forms.ModelForm):
    pass

class BootStrapForm(Bootstrap,forms.Form):
    pass