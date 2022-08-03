public with sharing class noteController {
    @AuraEnabled
    public static String addNote(String payload) {
        takeNoteObject payloadObject = (takeNoteObject) JSON.deserialize(payload, takeNoteObject.class);
  
        // La siguiente linea es generica no hardcoded accepta cualquier SObject y lo trae por nombre no optima si se sabe objetivo o(n)?.
        SObject noteObj = (Sobject) Type.forName('takeNoteObject__c').newInstance(); 
        noteObj.put('Author_Name__c', payloadObject.aName);
        noteObj.put('Publication_Year__c', payloadObject.pYear);
        noteObj.put('Note_Description__c', payloadObject.dNote);
        noteObj.put('Note__c', payloadObject.mNote);
  
        insert noteObj;
  
        return String.valueOf(noteObj.Id);
    }

    public static List<takeNoteObject> getNotes(List<SObject> objs) {
        List<takeNoteObject> notes = new List<takeNoteObject>();
        for (SObject obj : objs) {
          takeNoteObject note = new takeNoteObject();
          note.noteId = obj.Id;
          note.noteAuthor = String.valueOf(obj.get('Author_Name__c'));
          note.noteYear = integer.valueOf(obj.get('Publication_Year__c'));
          note.descNote = String.valueOf(obj.get('Note_Description__c'));
          note.mainNote = String.valueOf(obj.get('Note__c'));
          notess.add(note);
        }
    
        return notes;
    }

    @AuraEnabled
    public static List<takeNoteObject> getSavedNotes() {
      List<SObject> savedNotes = Database.query(
        'SELECT Id, Author_Name__c, CreatedDate, Publication_Year__c, Note_Description__c, Note__c FROM takeNoteObject__c ORDER BY CreatedDate DESC LIMIT:100'
      );
      return getNotes(savedNotes);
    }

    public class takeNoteObject {
        @AuraEnabled
        public String noteId;
        @AuraEnabled
        public String noteAuthor;
        @AuraEnabled
        public integer noteYear;
        @AuraEnabled
        public String descNote;
        @AuraEnabled
        public String mainNote;
    }
}
