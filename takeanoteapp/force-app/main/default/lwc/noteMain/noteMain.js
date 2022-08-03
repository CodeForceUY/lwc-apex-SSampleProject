import { LightningElement, track } from 'lwc';
import addNote from "@salesforce/apex/noteController.addNote";
import getSavedNotes from "@salesforce/apex/noteController.getSavedNotes";


export default class NoteMain extends LightningElement {

    @track noteList = [];

    //metodo que se llama ni bien se inicia la coneccion sirve para precargar cosas
    connectedCallback(){ //metodo ciclo de vida
        this.fetchToDos();
    }

    addNotesHandler(){
        //por el momento obtenemos los imputs de este modo buscando por el cuerpo del html un string id (Revisar)
        const aName1 = this.template.querySelector(".authorName");
        const pYear1 = this.template.querySelector(".pubYear");
        const dNote1 = this.template.querySelector(".descNote");
        const mNote1 = this.template.querySelector(".mainNote");
        const noteItem = {
            aName: aName1.value,
            pYear: pYear1.value,
            dNote: dNote1.value,
            mNote: mNote1.value,
            saved: false
        }
        addNote({payload: JSON.stringify(noteItem)}).then( response =>{
            console.log('Item inserted sucessfully');
            this.fetchToDos();
        }).catch( error => {
            console.error('Error inserting item'+ error);
        })
        inputBox.value = "";
    }

    get savedNotes(){
        return this.noteItem && this.noteList.length ? this.noteItem.filter( noteItem => !noteItem.saved): [];
    }

    //metodo para llamar algo del backend en nuestro caso una clase de apex 
    fetchToDos(){
        getSavedNotes().then(result => {
            if(result){
                this.noteItem = result;
            }
        }).catch(error => {
            console.error('Error fetching'+ error);
        })
    }

}