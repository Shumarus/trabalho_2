// ignore_for_file: non_constant_identifier_names

import 'dart:io';

void main() {
  String? input = stdin.readLineSync();
  int? a;
  int? b;

  if (input != null) {
    List<String> partes = input.trim().split(RegExp(r'\s+'));
    
    if (partes.length >= 2) {
      a = int.tryParse(partes[0]);
      b = int.tryParse(partes[1]);
    }
  }

  if (a == null || b == null) {
    print('Por favor forneça dois números inteiros positivos.');
    return;
  }

  if (a < 0 || b < 0) {
    print('Por favor forneça dois números inteiros positivos.');
    return;
  }

  if(a > b) {
    print('O primeiro número deve ser menor ou igual ao segundo.');
    return;
  }

  int start = a < b ? a : b;
  int end = a > b ? a : b;

  List<Map<String, dynamic>> numPerfeitos = [];
  int? numAbundante;
  int somaFatores = 0;
  List<int> fatAbundantes = [];

  for (int i = start; i <= end; i++) {
    if (i < 2) continue; 

    List<int> div = divProprios(i);
    int somaDivisores = div.fold(0, (prev, atual) => prev + atual);

    if (somaDivisores == i) {
      numPerfeitos.add({
        'numero': i,
        'fatores': div,
      });
    }
    else if (somaDivisores > i) {
      if (somaDivisores > somaFatores) {
        somaFatores = somaDivisores;
        numAbundante = i;
        fatAbundantes = div;
      }
    }
  }

  if (numPerfeitos.isEmpty) {
    print('Nenhum número perfeito encontrado na faixa entre $start e $end.');
  } else {
    for (var perfeito in numPerfeitos) {
      print('${perfeito['numero']} é um número perfeito.');
      print('Fatores: ${perfeito['fatores']}');
    }
  }

  if (numAbundante == null) {
    print('Nenhum número abundante encontrado na faixa entre $start e $end.');
  } else {
    print('Maior número abundante: $numAbundante');
    print('Fatores: $fatAbundantes');
    print('Soma dos fatores: $somaFatores');
  }
}

List<int> divProprios(int n) {
  List<int> divisores = [];
  for (int i = 1; i <= n ~/ 2; i++) {
    if (n % i == 0) {
      divisores.add(i);
    }
  }
  return divisores;
}
