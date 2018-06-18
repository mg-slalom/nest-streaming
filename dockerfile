FROM jrottenberg/ffmpeg

RUN apt-get update && apt-get install -y apache2 && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/mg-slalom/nest-streaming.git

RUN rm /var/www/html/index.html

RUN cp ./nest-streaming/index.html /var/www/html/

EXPOSE 80

ENTRYPOINT service apache2 start && ffmpeg -i rtsps://stream-us1-charlie.dropcam.com:443/live_stream/CjZ4M2xmS2ZhVDUwb2JlcVVzY1o1TmdBRlBLdFhDSHRVWTBOZ2ZCbEJ4MnBYUnpCWDZNaGlOa1ESFkZzOG8tS0lUZk1wRE9pQi01UUdOQ1EaNm55b005VjZjYUdRRTVhdzZmTXZFVFBUMEJ3QmhkeTNPdE42Y3VFN2tTZEFoNnI5TkVrNjMwUQ?auth=698am-6U6S86P2cKoLFzYSqzmriRUT_PZTO5MvLJabFTqOZb8t3GFqb8DjB-G5Ne4uuEd4w7s22FVI-fITchENJP2uImJ1El9FX0WmnosJ80itkpZEZq57kTD7i_nXf04egvAKLSw6u39QzREks8ETWRB5g4xrbPtuAFktCSYeOy3hWLiWBoc_iOkN7ALbZ8M7k4NXhogAmFd0 -map 0 -codec:v libx264 -codec:a copy -f ssegment -segment_list /var/www/html/playlist.m3u8 -segment_list_type hls -segment_list_size 10 -segment_list_flags +live -segment_time 10 /var/www/html/out%03d.ts
