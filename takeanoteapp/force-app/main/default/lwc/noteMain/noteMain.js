import { LightningElement, track } from 'lwc';
//import addTodo from "@salesforce/apex/toDoController.addTodo";
//import getCurrentTodo from "@salesforce/apex/toDoController.addTodo";


export default class NoteMain extends LightningElement {

    //metodo que se llama ni bien se inicia la coneccion sirve para precargar cosas
    connectedCallback(){ //metodo ciclo de vida
        
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
            mNote: mNote1.value
        }
        addTodo({payload: JSON.stringify(noteItem)}).then( response =>{
            console.log('Item inserted sucessfully');
            this.fetchToDos();
        }).catch( error => {
            console.error('Error inserting item'+ error);
        })
        inputBox.value = "";
    }

    get upComingTasks(){
        return this.taskItem && this.tasksList.length ? this.taskItem.filter( taskItem => !taskItem.done): [];
    }

    get completedTasks(){
        return this.taskItem && this.tasksList.length ? this.taskItem.filter( taskItem => taskItem.done): [];
    }

    //metodo para llamar algo del backend en nuestro caso una clase de apex 
    fetchToDos(){
        getCurrentTodo().then(result => {
            if(result){
                this.taskItem = result;
            }
        }).catch(error => {
            console.error('Error fetching'+ error);
        })
    }

}