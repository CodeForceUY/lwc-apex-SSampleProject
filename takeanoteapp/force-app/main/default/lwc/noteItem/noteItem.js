import { LightningElement, api } from 'lwc';

export default class NoteItem extends LightningElement {
    @api noteId;
    @api noteAuthor;
    @api noteYear;
    @api descNote;
    @api mainNote;
    @api saved;

    get containerClass(){
        saved = true;
        return this.saved ? "noteItem Notes" : "";
    }
}