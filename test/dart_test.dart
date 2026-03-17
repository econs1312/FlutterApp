import 'package:flutter_test/flutter_test.dart';

bool isPerfect(int num) {
 if (num < 1) return false;
 int sum = 0;
 for (int i = 1; i <= num ~/ 2; i++) {
   if (num % i == 0) {
     sum += i;
   }
 }
 return sum == num;
}


int factorial(int n) {
 if (n < 0) throw ArgumentError('Número deve ser não negativo.');
 int result = 1;
 int i = n;
 while (i > 1) {
   result *= i;
   i--;
 }
 return result;
}

bool isPrime(int number) {
for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) {
      return false; 
    }
  }
  return true;
}

int sumOfDigits(int number) {
if (number < 0) {
    print("Erro: O número deve ser positivo.");
    return -1; 
    }

  int soma = 0;

  while (number > 0) {
    soma += number % 10;
    
    number = number ~/ 10;
  }

  return soma;
}

void main() {
 ...
 group('Testes de Número primo', () {
   test('Número primo 7', () {
     expect(isPrime(7), isTrue);
   });
   test('Número não primo 10', () {
     expect(isPrime(10), isFalse);
   });
 });

 group('Testes de Soma dos dígitos', () {
   test('Soma dos dígitos de 123', () {
     expect(sumOfDigits(123), equals(6));
   });
   test('Soma dos dígitos de -1', () {
     expect(sumOfDigits(-1), throwsArgumentError);
   });
 });
}


void main() {
 ...
 group('Testes de Número primo', () {
   test('Número primo 7', () {
     expect(isPrime(7), isTrue);
   });
   test('Número não primo 10', () {
     expect(isPrime(10), isFalse);
   });
 });

 group('Testes de Soma dos dígitos', () {
   test('Soma dos dígitos de 123', () {
     expect(sumOfDigits(123), equals(6));
   });
   test('Soma dos dígitos de -1', () {
     expect(sumOfDigits(-1), throwsArgumentError);
   });
 });
}


void main() {
 group('Testes de Número perfeito', () {
   test('Número perfeito 6', () {
     expect(isPerfect(6), isTrue);
   });

   test('Número negativo não deve ser perfeito', () {
     expect(isPerfect(-6), isFalse);
   });
 });
}
