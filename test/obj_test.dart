import 'package:flutter_test/flutter_test.dart';

// --- ITEM 4: Classes Base ---
abstract class Pessoa {
  late int _id;
  String nome;

  Pessoa(this.nome);

  int get id => _id;

  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser positivo.');
    }
  }
}

mixin Ano {
  late int _ano;

  int get ano => _ano;

  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser positivo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Disciplina {
  String nome;
  Disciplina(this.nome);
}

// --- ITEM 5: Implementação de Professor e ajuste na Turma ---
class Professor extends Pessoa {
  Professor(super.nome);
}

class Turma with Ano {
  Disciplina disciplina;
  Professor professor; // Atributo adicionado no Item 5
  final List<Aluno> _alunos = [];

  Turma(this.disciplina, this.professor, int ano) {
    this.ano = ano;
  }

  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano do aluno não compatível com a turma.');
    }
  }
}

// --- ITEM 6: Alteração no Histórico para verificar aprovação ---
class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};

  // Construtor atualizado para suportar o Item 5
  Historico(super.disciplina, super.professor, super.ano);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  // Método auxiliar para facilitar os testes
  void adicionarNota(Aluno aluno, double nota) {
    if (notas.containsKey(aluno)) {
      notas[aluno]!.add(nota);
    }
  }

  double media(Aluno aluno) {
    // Proteção para evitar erros caso o aluno não tenha notas
    if (!notas.containsKey(aluno) || notas[aluno]!.isEmpty) return 0.0;

    double soma = 0;
    for (double nota in notas[aluno]!) {
      soma += nota;
    }
    // Lógica corrigida: divide pelo total de notas do aluno específico
    return soma / notas[aluno]!.length;
  }

  // >>> ITEM 6 INÍCIO <<<
  bool isAprovado(Aluno aluno) {
    // Se a média for superior ou igual a seis, retorna true
    return media(aluno) >= 6.0;
  }

  // >>> ITEM 6 FIM <<<
}

// --- ITEM 7: Modificação dos testes ---
void main() {
  test('Testar matrícula e aprovação (Itens 6 e 7)', () {
    // Configuração inicial
    Disciplina disciplina1 = Disciplina('Flutter');
    Professor prof1 = Professor('Helio');
    prof1.id = 10;

    // Criando histórico com o professor (obrigatório após Item 5)
    Historico historico1 = Historico(disciplina1, prof1, 2023);

    // Teste de Aluno Aprovado
    Aluno aluno1 = Aluno('Maria', 2023);
    aluno1.id = 1;
    historico1.matricular(aluno1);

    // Adicionando notas para testar a média
    historico1.adicionarNota(aluno1, 7.0);
    historico1.adicionarNota(aluno1, 5.0); // Média 6.0

    expect(historico1.media(aluno1), 6.0);
    expect(historico1.isAprovado(aluno1), isTrue);

    // Teste de Aluno Reprovado
    Aluno aluno2 = Aluno('Jose', 2023);
    aluno2.id = 2;
    historico1.matricular(aluno2);
    historico1.adicionarNota(aluno2, 5.9); // Média abaixo de 6.0

    expect(historico1.isAprovado(aluno2), isFalse);

    // Teste de erro de ID (conforme original do roteiro)
    expect(() => aluno1.id = 0, throwsArgumentError);
  });
}
