App.StatusController = Ember.Controller.extend({
  status: 'Saved',
  needs: ['editor'],
  isSavingBinding: 'controllers.editor.section.isSaving',
  activityObserver: function(){
    var isSaving = this.get('isSaving');
    isSaving ? this.set('status', 'Saving') : this.set('status', 'Saved');
  }.observes('isSaving')  
});

App.StatusView = Ember.View.extend({
  isSavingBinding:   'controller.isSaving',
  classNameBindings: [':status', 'isSaving:active'],
});