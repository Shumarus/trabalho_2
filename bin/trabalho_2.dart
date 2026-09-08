import 'dart:io';

void main() {
  String? linha = stdin.readLineSync();
  int? a;
  int? b;

  if (linha != null) {
    // Separa a linha por espaços (suporta mais de um espaço entre os números)
    List<String> partes = linha.trim().split(RegExp(r'\s+'));
    
    if (partes.length >= 2) {
      // Tenta converter as duas primeiras partes para inteiros
      a = int.tryParse(partes[0]);
      b = int.tryParse(partes[1]);
    }
  }

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


  // Saída: Números Perfeitos
  if (numerosPerfeitos.isEmpty) {
    print('Nenhum número perfeito encontrado na faixa entre $start e $end.');
  } else {
    for (var perfeito in numerosPerfeitos) {
      print('${perfeito['numero']} é um número perfeito.');
      print('Fatores: ${perfeito['fatores']}');
    }
  }

  // Saída: Número Abundante
  if (numeroAbundanteMaximo == null) {
    print('Nenhum número abundante encontrado na faixa entre $start e $end.');
  } else {
    print('Maior número abundante: $numeroAbundanteMaximo');
    print('Fatores: $fatoresAbundanteMaximo');
    print('Soma dos fatores: $somaMaximaFatores');
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
