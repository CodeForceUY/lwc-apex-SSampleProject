public class noteController {

    @AuraEnabled
    public static String addNote(String payload) {
        takeNoteObject payloadObject = (takeNoteObject) JSON.deserialize(payload, takeNoteObject.class);
  
        // La siguiente linea es generica no hardcoded accepta cualquier SObject y lo trae por nombre no optima si se sabe objetivo o(n)?.
        SObject noteObj = (Sobject) Type.forName('takeNoteObject__c').newInstance();
        noteObj.put('Name', '0x6432'); 
        noteObj.put('Author_Name__c', payloadObject.noteAuthor);
        noteObj.put('Publication_Year__c', payloadObject.noteYear);
        noteObj.put('Note_Description__c', payloadObject.descNote);
        noteObj.put('Note__c', payloadObject.mainNote);
  
        insert noteObj;
  
        return String.valueOf(noteObj.Id);
    }

    public static List<takeNoteObject> getNotes(List<SObject> objs) {
        List<takeNoteObject> notes = new List<takeNoteObject>();
        for (SObject obj : objs) {
          takeNoteObject note = new takeNoteObject();
          note.noteId = obj.Id;
          note.noteAuthor = String.valueOf(obj.get('Author_Name__c'));
          note.noteYear = Integer.valueOf(obj.get('Publication_Year__c'));
          note.descNote = String.valueOf(obj.get('Note_Description__c'));
          note.mainNote = String.valueOf(obj.get('Note__c'));
          notes.add(note);
        }
    
        return notes;
    }

    @AuraEnabled
    public static List<takeNoteObject> getSavedNotes() {
      List<SObject> savedNotes = Database.query(
        'SELECT Id, CreatedDate, Author_Name__c, Publication_Year__c, Note_Description__c, Note__c FROM takeNoteObject__c ORDER BY CreatedDate DESC LIMIT 100'
      );
      return getNotes(savedNotes);
    }

    @AuraEnabled
    public static void deleteNote(String noteId) {
      SObject note = (Sobject) Type.forName('takeNoteObject__c').newInstance();
      note.put('Id', noteId);
  
      delete note;
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
