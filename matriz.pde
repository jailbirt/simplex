//Clase usada para dibujar la matriz y los resultados en pantalla.

class matriz {
  GTextField[][] camposIngresados;
  GLabel[][]     camposMostrar;
  float[][]      simplex;
  PApplet        parent;  
  //Cantidad de condiciones y variables
  int cantFilas, cantColumnas;
  GTabManager tt;

  //START Funcion constructora del panelIngreso2, ingreso uno son restricciones y tipo de problema. TODO!!!!!HERE!!!!
  matriz (int condiciones, int variables, PApplet parent) {
    this.parent=parent;
    cantFilas=condiciones;
    cantColumnas=variables+condiciones;//Las 'S'
    cantColumnas=variables+1;//La columna 'b'

    camposIngresados = new GTextField[condiciones][variables];
    camposMostrar    = new GLabel[condiciones][variables];
  }
  //END funcion Constructora

  //Getters.
  int cantFilas () {
    return cantFilas;
  }
  int cantColumnas () {
    return cantColumnas;
  }

  String devuelveValorFilaColumna(int fila, int columna) {
    return this.camposIngresados[fila][columna].getText();
  }
  //Fin Getters.
  //Setters.
  //Fin Setters.

  void dibujaInputMatrix(int condicion,int variable) {  
    System.out.println("c "+condicion+"v "+variable);
    this.camposIngresados[condicion][variable]= new GTextField(parent, condicion*20*4, variable*20*4, 60, 40); 
    this.camposIngresados[condicion][variable].tag = "F"+condicion+"C"+variable;
    this.camposIngresados[condicion][variable].setDefaultText("F"+(condicion+1)+"C"+(variable+1));
  }

  void recorreMatrixY(String operacion, float [][] matriz) {
    tt = new GTabManager();
    for (int condicion=0;condicion<cantFilas;condicion++) {
      for (int variable=0;variable<cantColumnas;variable++) {
       if (operacion == "dibujaInputMatrix"){
          dibujaInputMatrix(condicion,variable);
          // Create the tab manager and add these controls to it
          tt.addControl(camposIngresados[condicion][variable]);     
       }
        else if("dibujaOutputMatrix" == operacion) {
          dibujaOutputMatrix(condicion,variable,matriz);
          parent.line(300, cantColumnas*20*4, 300+(cantFilas*20*4), cantColumnas*20*4);
          parent.line(300+(cantFilas*20*4), 1, 300+(cantFilas*20*4), cantColumnas*20*4);
        }
        else {

        } 
      }
    }
  }

  void dibujaOutputMatrix(int fila,int columna,float[][] pasoActual) {
    parent.line(300+(fila*20*4), columna*20*4, 380+(fila*20*4), columna*20*4);
    parent.line(300+(fila*20*4), columna*20*4, 300+(fila*20*4), 70+(columna*20*4));
    camposMostrar[fila][columna] = new GLabel(parent, 300+(fila*20*4), columna*20*4, 60, 40);   
    camposMostrar[fila][columna].setText(Float.toString(pasoActual[fila][columna]));
    camposMostrar[fila][columna].setLocalColorScheme(G4P.GREEN_SCHEME);
    camposMostrar[fila][columna].setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  }
}

