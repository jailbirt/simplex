/**
 * Based on EditTextControls
 */

import g4p_controls.*;

matriz simplex;

GTabManager tt;
GTextField condicion,variable; //primer pantalla.
int condiciones,variables;
int paso=0;
GButton btnMdialog,btnMdialogNext,btnMdialogPrev,btnMdialogCancela;
float[][] matrizOriginal;
float[][] pasoActual;
GLabel lblReply;
ArrayList<matriz> matrices;
  
public void setup() {
  size(1024, 768);
  G4P.setGlobalColorScheme(GCScheme.RED_SCHEME);
  matrices = new ArrayList();
  
  //Ingreso de condicion/variables 1er pantalla
  condicion=new GTextField(this,0,0,80,20);
  condicion.tag = "condicion";
  condicion.setDefaultText("condicion");
  variable =new GTextField(this,90,0,80,20);
  variable.tag = "variable";
  variable.setDefaultText("variable");
  tt = new GTabManager();
  tt.addControls(condicion,variable);
  //Fin Ingreso
  btnMdialog = new GButton(this, 2, 300, 100, 20,  "Calcula");
  btnMdialogNext = new GButton(this, 112, 300, 100, 20, "Next");
  btnMdialogPrev = new GButton(this, 212, 300, 100, 20, "Prev");
  btnMdialogCancela = new GButton(this, 312, 300, 90, 20, "Cancela");
  
}

public void draw() {
  background(240, 240, 200);
  // Draw tab order
  stroke(0);
  strokeWeight(2);
  switch(paso) {
  case 1:
     if(simplex==null){
       text("X1", 10, 30);
       text("X2", 30, 30);
       simplex=new matriz(condiciones, variables,this);
       pasoActual=new float[simplex.cantFilasSimplex()][simplex.cantColumnasSimplex()];//Agrego las 'S'     
        simplex.recorreMatrixY("dibujaInputMatrix", pasoActual);
    }
    break;
  case 2: 
   if(simplex!=null){
     pasoActual=simplex.devuelveMatrizIngresada();
     simplex.recorreMatrixY("dibujaOutputMatrix",pasoActual);
     matrices.add(simplex);
   }
    break;
  default:
    break;    
  }
}

public void handleTextEvents(GEditableTextControl tc, GEvent event) { 
  System.out.print("\n" + tc.tag + "   Event type: ");
  switch(event) {
  case CHANGED:
    System.out.println("CHANGED");
    break;
  case SELECTION_CHANGED:
    System.out.println("SELECTION_CHANGED");
    System.out.println(tc.getSelectedText() + "\n");
    break;
  case ENTERED:
    System.out.println("ENTER KEY TYPED");
    System.out.println(tc.getSelectedText() + "\n");
    break;
  default:
    System.out.println("UNKNOWN");
  }
}

public void handleButtonEvents(GButton button, GEvent event) { 
  if(button == btnMdialog) {
    condiciones=int(condicion.getText());
    variables=int(variable.getText());
    if(condiciones == 0 || variables == 0)
      G4P.showMessage(this, "SETEAR VARIABLES Y CONDICIONES","SETEAR VARIABLES Y CONDICIONES", G4P.WARNING);
    else
      paso=1;
  }
  if(button == btnMdialogNext) {
   paso=2;
   System.out.println("Next");
  }
  if(button == btnMdialogPrev) {
   paso=3;
  }
  if(button == btnMdialogCancela) {
   paso=0;
   simplex=null;
   matrices=null;
   pasoActual=null;
  }
}
 
