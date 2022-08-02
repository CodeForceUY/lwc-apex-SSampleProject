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
}
