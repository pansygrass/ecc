template: m45_mesh(w1, w2) {
  layer : M4 {
     direction : horizontal
     width : @w1
     pitch : 6
     spacing : 1
     offset :
  }
  layer : M5 {
     direction : vertical
     width : @w2
     spacing : 1
     pitch : 6
     offset : 
  }
}
