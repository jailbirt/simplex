//Clase usada para dibujar la matriz y los resultados en pantalla.

class matriz {
  GTextField[][] camposIngresar;
  GLabel[][]     camposMostrar;
  float[][]      simplex;
  PApplet        parent;  
  //Cantidad de condiciones y variables
  int cantFilasOriginal, cantColumnasOriginal, cantFilasSimplex,cantColumnasSimplex;
  GTabManager tt;

  //START Funcion constructora del panelIngreso2, ingreso uno son restricciones y tipo de problema. TODO!!!!!HERE!!!!
  matriz (int condiciones, int variables, PApplet parent) {
    this.parent=parent;
    cantFilasOriginal=cantFilasSimplex=condiciones;
    cantColumnasOriginal=variables+1;
    cantColumnasSimplex=(variables+condiciones+1);//Las 'S' y la condición última.
    
    camposIngresar  = new GTextField[cantColumnasOriginal][cantColumnasOriginal]; //Input
    camposMostrar   = new GLabel[cantFilasSimplex][cantColumnasSimplex];//lavels que se muestran
    simplex         = new float[cantFilasSimplex][cantColumnasSimplex];  //Operaciones aca.
  }
  //END funcion Constructora

  //Getters.
  int cantFilasOriginal () {
    return cantFilasOriginal;
  }
  int cantColumnasOriginal () {
    return cantColumnasOriginal;
  }
  int cantFilasSimplex () {
    return cantFilasSimplex;
  }
  int cantColumnasSimplex () {
    return cantColumnasSimplex;
  }
  String devuelveValorFilaColumna(int fila, int columna) {
    return this.camposIngresar[fila][columna].getText();
  }
  GLabel[][] devuelveMatrizAMostrar(){
    return this.camposMostrar;
  }
  float[][] devuelveMatrizIngresada(){
    for (int fila=0;fila<cantFilasOriginal;fila++) 
      for (int columna=0;columna<cantColumnasOriginal;columna++) 
        simplex[fila][columna]=Float.parseFloat(camposIngresar[fila][columna].getText());
    return simplex;
  }
  //Fin Getters.
  //Setters.
  //Fin Setters.

  void dibujaInputMatrix(int fila,int columna) {  
    this.camposIngresar[fila][columna]= new GTextField(parent, fila*20*4, columna*20*4, 60, 40); 
    this.camposIngresar[fila][columna].tag = "F"+fila+"C"+columna;
    this.camposIngresar[fila][columna].setDefaultText("F"+(fila+1)+"C"+(columna+1));
  }
  void recorreMatrixY(String operacion, float [][] matriz) {
    tt = new GTabManager();
       
    for (int fila=0;fila<matriz.length;fila++) {
      for (int columna=0;columna<matriz[0].length  ;columna++) {
       if ("dibujaInputMatrix" == operacion){
          dibujaInputMatrix(fila,columna);
          // Create the tab manager and add these controls to it
          tt.addControl(camposIngresar[fila][columna]);     
       }
        else if("dibujaOutputMatrix" == operacion) { //convierte a simplex.
          convierteOriginalASimplex(fila,columna,matriz);
          dibujaOutputMatrix(fila,columna);
          parent.line(300, cantColumnasSimplex*20*4, 300+(cantFilasSimplex*20*4), cantColumnasSimplex*20*4);
          parent.line(300+(cantFilasSimplex*20*4), 1, 300+(cantFilasSimplex*20*4), cantColumnasSimplex*20*4);
        }
        else {

        } 
      }
    }
  }

 void dibujaOutputMatrix(int fila,int columna) {
          parent.line(300+(fila*20*4), columna*20*4, 380+(fila*20*4), columna*20*4);
          parent.line(300+(fila*20*4), columna*20*4, 300+(fila*20*4), 70+(columna*20*4));
          camposMostrar[fila][columna] = new GLabel(parent, 300+(fila*20*4), columna*20*4, 60, 40);   
          camposMostrar[fila][columna].setText(Float.toString(simplex[fila][columna]));
          camposMostrar[fila][columna].setLocalColorScheme(G4P.GREEN_SCHEME);
          camposMostrar[fila][columna].setTextAlign(GAlign.CENTER, GAlign.MIDDLE); 
 }
 
 void convierteOriginalASimplex(int fila,int columna,float [][] matriz) //Se usa la primera vez para convertir el input, en SIMPLEX
 {
    simplex[fila][columna]=matriz[fila][columna];
 }
 
}
