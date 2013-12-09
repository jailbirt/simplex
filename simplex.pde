/**
 * Based on EditTextControls
 */

import g4p_controls.*;

matriz simplex;

GTabManager tt;

int condiciones=3;
int variables=2;
int paso=0;
GButton btnMdialog;
float[][] pasoActual;
GLabel lblReply;
ArrayList<float[] []> pasos;
  
public void setup() {
  size(640, 480);
  G4P.setGlobalColorScheme(GCScheme.RED_SCHEME);
  simplex=new matriz(condiciones, variables,this);
  pasoActual=new float[simplex.cantFilas()][simplex.cantColumnas()];//Agrego las 'S'
  simplex.recorreMatrixY("dibujaInputMatrix", pasoActual);
  btnMdialog = new GButton(this, 50, 200, 80, 20,  "Calc");
  btnMdialog = new GButton(this, 100, 200, 80, 20, "Next");
  btnMdialog = new GButton(this, 150, 200, 80, 20, "Prev");
  
}

public void draw() {
  background(240, 240, 200);
  // Draw tab order
  stroke(0);
  strokeWeight(2);
  switch(paso) {
  case 1: 
    //calculaSimplexOriginal();
    simplex.recorreMatrixY("dibujaOutputMatrix",pasoActual);
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
   paso=1;
  }
 }
