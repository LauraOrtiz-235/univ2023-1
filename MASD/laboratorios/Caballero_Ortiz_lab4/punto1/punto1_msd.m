for i=1:100
    
    figure('units','pixels','position',[0 0 1440 1080]) %este comando es opcional. Mejorará la calidad del video al crear imágenes en full hd: 1140 X 1080 pixeles
    
    plot(i/100,1,'o','MarkerSize',10,'MarkerFaceColor','red','MarkerEdgeColor','black') %graficamos el punto en la posición deseada
    
    axis([0,1,0,2]) %estos serán los límites del plano Cartesiano en el haremos nuestras gráficas
    
    secuencia_frames(i)=getframe(gcf); %guardamos la gráfica que acabamos de hacer en nuestra secuencia de frames. Esta secuencia puede entenderse como un vector de imágenes.
    
    cla %borramos la gráfica actual para dibujar la siguiente gráfica sobre el plano cartesiano vacío

end



video = VideoWriter('punto_mov');
video.FrameRate=10;

open(video);
writeVideo(video,secuencia_frames);
close(video);
