import { LightningElement, api } from 'lwc';

export default class NoteItem extends LightningElement {
    @api noteId;
    @api noteAuthor;
    @api noteYear;
    @api descNote;
    @api mainNote;
    @api saved; 


    get containerClass(){
        return !this.saved ? "noteItem Notes" : "";
    }
}