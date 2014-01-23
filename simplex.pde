/**
 * Based on EditTextControls
 */

import g4p_controls.*;

matriz simplex;


int valorCondiciones,valorVariables;
int numeroPaso=0;
GButton btnMdialogNext,btnMdialogPrev,btnMdialogCancela;
float[][] matrizOriginal;
float[][] pasoActual;
GLabel lblReply;
ArrayList<matriz> matrices;
GWindow paso;

public void setup() {
  size(1024, 768, JAVA2D);
  createGUI();
  matrices = new ArrayList();
  numeroPaso=0;
}

public void draw() {
  background(240, 240, 200);
  // Draw tab order
  stroke(0);
  strokeWeight(2);
  switch(numeroPaso) {
  case 1:
     if(simplex==null){
       text("X1", 10, 30);
       text("X2", 30, 30);
       simplex=new matriz(valorCondiciones, valorVariables,this);
       pasoActual=new float[simplex.cantFilasSimplex()][simplex.cantColumnasSimplex()];//Agrego las 'S'     
       simplex.recorreMatrixY("dibujaInputMatrix", pasoActual, this);
    }
    break;
  case 2: 
   if(simplex!=null){
     pasoActual=simplex.devuelveMatrizIngresada();
     simplex.recorreMatrixY("dibujaOutputMatrix",pasoActual,paso.papplet);
     matrices.add(simplex);
     label1 = new GLabel(paso.papplet, 472, 374, 80, 20);
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
  if(button == botonNext) {
    numeroPaso=2;
    ventanaPaso();

  }
  if(button == botonPrev) {
   numeroPaso=3;
  }
  if(button == botonCancela) {
   numeroPaso=0;
   //null para todo
   simplex.recorreMatrixY("disableInputMatrix",pasoActual,this);
   simplex.recorreMatrixY("disableOutputMatrix",pasoActual,paso.papplet);
   valorCondiciones=valorVariables=0;
   pasoActual=null;
   simplex=null;
  }
  if(button == botonCancelaVentana) {
   numeroPaso=0;
   //null para todo
   simplex.recorreMatrixY("disableOutputMatrix",pasoActual,paso.papplet);
   pasoActual=null;
  }
}
