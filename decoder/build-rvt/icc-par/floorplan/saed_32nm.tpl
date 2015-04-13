template: m45_mesh(w1, w2) {
  layer : M4 {
     direction : vertical
     width : @w1
     pitch : 8
     spacing : 1
     offset :
  }
  layer : M5 {
     direction : horizontal
     width : @w2
     spacing : 1
     pitch : 8
     offset : 
  }
}
