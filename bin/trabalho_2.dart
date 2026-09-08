import 'dart:io';

void main() {
  print('Digite o valor inicial da faixa (a): ');
  String? inputA = stdin.readLineSync();

  print('Digite o valor final da faixa (b): ');
  String? inputB = stdin.readLineSync();

  // Validação de entrada estruturada para evitar falhas de tipagem
  int? a = int.tryParse(inputA ?? '');
  int? b = int.tryParse(inputB ?? '');

  if (a == null || b == null) {
    print('Erro: Por favor, insira números inteiros válidos.');
    return;
  }

  // Ordenação automática caso o usuário insira os valores invertidos
  int start = a < b ? a : b;
  int end = a > b ? a : b;

  List<Map<String, dynamic>> numerosPerfeitos = [];
  int? numeroAbundanteMaximo;
  int somaMaximaFatores = 0;
  List<int> fatoresAbundanteMaximo = [];

  for (int i = start; i <= end; i++) {
    if (i < 2) continue; // 0 e 1 não possuem divisores próprios que satisfaçam as regras

    List<int> divisores = obterDivisoresProprios(i);
    int somaDivisores = divisores.fold(0, (prev, atual) => prev + atual);

    // Validação de Número Perfeito
    if (somaDivisores == i) {
      numerosPerfeitos.add({
        'numero': i,
        'fatores': divisores,
      });
    }
    // Validação de Número Abundante 
    else if (somaDivisores > i) {
      if (somaDivisores > somaMaximaFatores) {
        somaMaximaFatores = somaDivisores;
        numeroAbundanteMaximo = i;
        fatoresAbundanteMaximo = divisores;
      }
    }
  }

  print('\n--- Resultados na faixa [$start, $end] ---');

  // Saída: Números Perfeitos
  if (numerosPerfeitos.isEmpty) {
    print('Não foram encontrados números perfeitos na faixa.');
  } else {
    print('\nNúmeros Perfeitos:');
    for (var perfeito in numerosPerfeitos) {
      print('- Número: ${perfeito['numero']} | Fatores: ${perfeito['fatores']}');
    }
  }

  // Saída: Número Abundante
  if (numeroAbundanteMaximo == null) {
    print('\nNão foram encontrados números abundantes na faixa.');
  } else {
    print('\nNúmero Abundante com maior soma de fatores:');
    print('- Número: $numeroAbundanteMaximo');
    print('- Soma dos fatores: $somaMaximaFatores');
    print('- Lista de fatores: $fatoresAbundanteMaximo');
  }
}

// Retorna uma List de divisores próprios (excluindo o próprio número)
List<int> obterDivisoresProprios(int n) {
  List<int> divisores = [];
  // Otimização: o maior divisor próprio possível é a metade exata do número
  for (int i = 1; i <= n ~/ 2; i++) {
    if (n % i == 0) {
      divisores.add(i);
    }
  }
  return divisores;
}
