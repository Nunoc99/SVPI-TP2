# SVPI-TP2
Decoding information on envelopes with handwritten text

## Goal
> _**ING**_
> TO BE WRITTEN...

> _**PT**_

 _Desenvolvimento de um programa em Matlab para fazer análise de imagens que representam envelopes
com moradas que contêm elementos vários, em especial o texto do destinatário, incluindo um código
postal em caracteres manuscritos da base de dados do MNIST (http://yann.lecun.com/exdb/mnist),
que devem ser detetados e processados. O programa deve ser capaz de interpretar imagens fornecidas
e de gerar os resultados pedidos e de os escrever num ficheiro, conforme descrito adiante. Serão dadas
imagens exemplo para permitir o desenvolvimento, mas as imagens usadas para obter os resultados
de avaliação serão novas. Embora uma parte significativa dos processos se possa fazer por técnicas
tradicionais de visão artificial, para a deteção dos caracteres manuscritos devem usar-se técnicas usuais
na Inteligência Artificial como redes neuronais, em particular as capacitadas para reconhecer os caracteres
do dataset MNIST. Assim, além das técnicas de segmentação para isolar os elementos a classificar, será
necessário definir e treinar uma rede neuronal que fará o reconhecimento o melhor possível da base de
dados do MNIST e integrar a sua utilização no programa final._

![image](https://github.com/Nunoc99/SVPI-TP2/assets/114221939/14fc3279-4fb1-4277-9ea9-734807deddaa)


> _**ING**_

The main caracteristics of the images are as follows:
+ The images are colored (RGB).
+ The images may be rotated and the background area outside the envelope will be in grayscale.
+ The images contain 4 lines of variably positioned text.
+ The images may contain a stamp which may have a variable position and orientation.
+ Envelopes can have different colours, as in the examples provided.
+ There may be other accessory elements on the envelopes (symbols, stamps, etc.), as illustrated in the examples provided.
in the examples provided, but which do not need to be analysed or classified for this paper.

> _**PT**_

_As características gerais das imagens são as seguintes:_
+ _As imagens são a cores._
+ _As imagens podem estar rodadas e a zona do fundo fora do envelope será em nível de cinzento._
+ _As imagens contêm 4 linhas de texto em posição variável._
+ _As imagens podem conter um selo que poderá ter uma posição e orientação variável._
+ _Os envelopes podem ter cores diversas, como presente nos exemplos fornecidos._
+ _Nos envelopes pode haver outros elementos acessórios (símbolos, carimbos, etc.), como ilustrado
nos exemplos disponibilizados, mas que não carecem de análise ou classificação para este trabalho._

 
## Parameters to detect in each image
> _**ING**_

 In each image, the main parameters and caracteristics that the program has to detect are:
+ Possible stamp type from the list shown below (1,2,3, ...,7).
+ Number of words in the recipient's name (2,3,...).
+ Number of words in the first line of the adress excluding the door number (2,3,...).
+ Door number to the right of the first line of the address (10 a 999).
+ Dígitos do código postal (dois grupos de 4 dígitos cada um).
+ Postcode digits (two groups of 4 digits each).

> _**PT**_

 _Em cada imagem, os principais parâmetros e características a detetar pelo programa do aluno são:_
+ _Tipo de selo dos possíveis da lista indicada na figura 2 (1,2,3, ...,7)._
+ _Número de palavras no nome do destinatário (2,3,...)._
+ _Número de palavras na primeira linha da morada excluindo o número de porta (2,3,...)._
+ _Número da porta à direita da primeira linha da morada (10 a 999)._
+ _Dígitos do código postal (dois grupos de 4 dígitos cada um)._
  
 **_Nota:_** _pode dar-se o caso de o selo estar ausente da imagem. Nesse caso o valor é 0 (zero)._

![image](https://github.com/Nunoc99/SVPI-TP2/assets/114221939/5a1cabf0-b84b-47f4-a3c5-41f3f247e1d6)


## Variables to get from each object
+ **numMec** - Number of the student.
+ **numSeq** - Image sequence number (Gf. image's filename)
+ **numImg** - Image number in the sequence (Gf. image's filename).
+ **stampN** - Number of the stamp on envelope, or 0 if absent.
+ **numNam** - Number of words in the recipient's name (2,3,...).
+ **numAdd** - Number of words in the first line of the address excluding the door number (2,3,...).
+ **numDoor** - Door number on the right in the first line of the address (value between 10 and 999).
+ **D1** - Digit 1 (leftmost) of the postcode (0 to 9).
+ **D2** - Digit 2 of the postcode (0 to 9).
+ **D3** - Digit 3 of the postcode (0 to 9).
+ **D4** - Digit 4 of the postcode (0 to 9).
+ **D5** - Digit 5 of the postcode (0 to 9).
+ **D6** - Digit 6 of the postcode (0 to 9).
+ **D7** - Digit 7 of the postcode (0 to 9).
+ **D8** - Digit 8 of the postcode (0 to 9).

> _**PT**_
+ _**numMec** - Número mecanográfico do aluno._
+ _**numSeq** - Número da sequência da imagem (Cf. nome do ficheiro de imagem)._
+ _**numImg** - Número da imagem na sequência (Cf. nome do ficheiro de imagem)._
+ _**stampN** - Número do selo presente no envelope, ou 0 se ausente._
+ _**numNam** - Número de palavras no nome do destinatário (2,3,...)._
+ _**numAdd** - Número de palavras na primeira linha da morada excluindo o número da porta (2,3,...)._
+ _**numDoor** - Número de porta que está à direita na primeira linha da morada (valor entre 10 e 999)._
+ _**D1** - Dígito 1 (mais à esquerda) do código postal (0 a 9)._
+ _**D2** - Dígito 2 do código postal (0 a 9)._
+ _**D3** - Dígito 3 do código postal (0 a 9)._
+ _**D4** - Dígito 4 do código postal (0 a 9)._
+ _**D5** - Dígito 5 do código postal (0 a 9)._
+ _**D6** - Dígito 6 do código postal (0 a 9)._
+ _**D7** - Dígito 7 do código postal (0 a 9)._
+ _**D8** - Dígito 8 do código postal (0 a 9)._


## RESULTS
Visual demonstration of the program working.

On the left there's a figure with 6 subplots where it can be seen the original image, then the whole image treatment process to isolate the image's objects from the background, through binarization and edge detection process it was able to delete the noise in the background.

On the right side of the picture, there's a figure with, in this case, 32 subplots because in this image there are 32 objects in the image, know that, the image subplot size addpats to the number of objects in the image. From this image, each object will be analyzed 1 by 1 to get all the parameters in question, this means, each identified barcode will go through a process of 4 types of scaling, 4 types of rotation and 3 types of axial reflection and it will stop when the barcode is in the correct scale, orientation and if there is a axial reflection or not. Now, for the QR codes, each one will also go through a process of 4 types of scaling and 4 types of orientation till it founds it's correct scale and orientation, then, get it's properties.

At the bottom of the picture, there is a txt file which is created when the program ends. It has in sequence, separated by commas, the values of each parameter.

![setup](https://github.com/Nunoc99/SVPI-TP1/assets/114221939/68917b7a-296c-45d2-bec9-b803da5c5c24)

