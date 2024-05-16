# SVPI-TP2
Decoding information on envelopes with handwritten text

## Goal
> _**ING**_

Development of a programme in Matlab to analyse images representing envelopescontaining various elements, in particular the recipient's text, including a postcode in handwritten characters from the MNIST database ().
in handwritten characters from the MNIST database (http://yann.lecun.com/exdb/mnist),
which must be detected and processed. The programme must be able to interpret images provided
and generate the requested results and write them to a file, as described below. Example
example images will be provided to enable development, but the images used to obtain the evaluation results will be new.
results will be new. Although a significant part of the processes can be carried out using
traditional machine vision techniques, the detection of handwritten characters will require the use of techniques used in
in Artificial Intelligence, such as neural networks, particularly those capable of recognising the characters in the
from the MNIST dataset. Therefore, in addition to segmentation techniques to isolate the elements to be classified, it will be necessary to
define and train a neural network that will recognise the MNIST database as well as possible and integrate its
database and integrate its use into the final programme.

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

*Figure 1*



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

*Figure 2*

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

Starting with the **_Figure 3_**, as it can be seen, I thought that these 7 image windows were enough to show what the program does in a generic form. So, in
"Original Img" window is displayed the original image that enters the program to be analysed, in the second window "Oriented Image" is displayed the same
image but after it has been oriented, because, like it was said above, some pictures envelope may be rotated, which is the case that can be seen in 
**_Figure 4_**, which concludes that the first thing that the program does is, check the orientation and if needed, reorientate the envelope.

![setup](https://github.com/Nunoc99/SVPI-TP2/assets/114221939/c63d02c3-cb05-41a2-abe1-e12560c05ce2)

*Figure 3*

![setup3](https://github.com/Nunoc99/SVPI-TP2/assets/114221939/1949fb2b-402a-40c8-adba-9e12db1e070a)

*Figure 4*

The next step, already with the envelope with the correct orientation, is to start the process of classification of the stamp, first, as you can see in the third
window "Isolated Stamp" the stamp is already isolated from the rest of the envelope, which allowed me to start working with object descriptors like "BoundingBox",
"Area", "Circularity", "Solidity", etc, to try to find out differences between each type of stamp and classify each one of them correctly.

Having the process of classification of each stamp concluded, I moved on to the written part of the envelope, the characters. As it is possible to see, in the 
fourth window "Isolated Chars", I managed to isolate, from the rest of the enevlope, the part where the chars were at, this allowed me, once again, to work with 
object descriptors, "Centroid", to separate this image by lines. From the first line, I got the value of the variable "numNam", which I had to count the number of words in 
this line. From the second line, I got the value of two variables, "numAdd" and "numDoor", the first one being the number of words in this line excluding the
door number, and the second one, being the door number, can be seen in the seventh window "Line 2". Finally, from the third line, as it can be seen in the fifth window 
"Line 3", I displayed the postcode digits, after that, I cropped them and put them in 28x28 pixels images, sixth window "Char1, Char2, ...", so that it was able to send those 
images into the neural network, for them to be analysed and have a corresponding character.

![setup2](https://github.com/Nunoc99/SVPI-TP2/assets/114221939/5ff9b3c6-9aaa-456d-936c-0dda7319ce7f)

*Figure 5*

In conclusion, in **_Figure 5_**, there is a txt file which is created when the program ends. It has in sequence, separated by commas, the values of each parameter.






