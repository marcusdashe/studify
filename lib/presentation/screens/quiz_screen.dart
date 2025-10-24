
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studify_flutter_challenge/presentation/screens/quiz_result_screen.dart';

import '../../core/constants/studify_image_paths.dart';
import '../../data/models/quiz_option_model.dart';
import '../../data/models/quiz_question_model.dart';
import '../widgets/circular_back_button.dart';

class QuizData {
  static List<QuizQuestion> getSampleQuestions() {
    return [
      QuizQuestion(
        question: 'In 8086 assembly, what is the primary purpose of the AX register, which is often referred to by a specific name related to its function in arithmetic operations?',
        options: [
          QuizOption(label: 'A', text: 'Base Address Register'),
          QuizOption(label: 'B', text: 'Data Register'),
          QuizOption(label: 'C', text: 'Count Register'),
          QuizOption(label: 'D', text: 'Accumulator Register'),
        ],
        correctAnswer: 'D',
      ),
      QuizQuestion(
        question: 'What is the size of a word in 8086 assembly language?',
        options: [
          QuizOption(label: 'A', text: '8 bits'),
          QuizOption(label: 'B', text: '16 bits'),
          QuizOption(label: 'C', text: '32 bits'),
          QuizOption(label: 'D', text: '64 bits'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'Which instruction is used to move data from source to destination in x86 assembly?',
        options: [
          QuizOption(label: 'A', text: 'LOAD'),
          QuizOption(label: 'B', text: 'STORE'),
          QuizOption(label: 'C', text: 'MOV'),
          QuizOption(label: 'D', text: 'TRANSFER'),
        ],
        correctAnswer: 'C',
      ),
      QuizQuestion(
        question: 'What does the CMP instruction do in assembly language?',
        options: [
          QuizOption(label: 'A', text: 'Copies data between registers'),
          QuizOption(label: 'B', text: 'Compares two operands by subtraction'),
          QuizOption(label: 'C', text: 'Complements the bits of an operand'),
          QuizOption(label: 'D', text: 'Compiles the program'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'Which flag is set when an arithmetic operation results in zero in x86 assembly?',
        options: [
          QuizOption(label: 'A', text: 'Carry Flag (CF)'),
          QuizOption(label: 'B', text: 'Zero Flag (ZF)'),
          QuizOption(label: 'C', text: 'Sign Flag (SF)'),
          QuizOption(label: 'D', text: 'Overflow Flag (OF)'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'What is the purpose of the PUSH instruction in assembly?',
        options: [
          QuizOption(label: 'A', text: 'Adds two numbers'),
          QuizOption(label: 'B', text: 'Stores data on the stack'),
          QuizOption(label: 'C', text: 'Removes data from the stack'),
          QuizOption(label: 'D', text: 'Compares two values'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'In x86 assembly, which register is commonly used as a loop counter?',
        options: [
          QuizOption(label: 'A', text: 'AX'),
          QuizOption(label: 'B', text: 'BX'),
          QuizOption(label: 'C', text: 'CX'),
          QuizOption(label: 'D', text: 'DX'),
        ],
        correctAnswer: 'C',
      ),
      QuizQuestion(
        question: 'What does the JMP instruction do in assembly language?',
        options: [
          QuizOption(label: 'A', text: 'Jumps to a subroutine'),
          QuizOption(label: 'B', text: 'Unconditionally transfers control to another instruction'),
          QuizOption(label: 'C', text: 'Jumps only if zero flag is set'),
          QuizOption(label: 'D', text: 'Returns from a procedure'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'Which directive is used to define a byte variable in assembly?',
        options: [
          QuizOption(label: 'A', text: 'DW'),
          QuizOption(label: 'B', text: 'DD'),
          QuizOption(label: 'C', text: 'DB'),
          QuizOption(label: 'D', text: 'DQ'),
        ],
        correctAnswer: 'C',
      ),
      QuizQuestion(
        question: 'What is the function of the INT instruction in x86 assembly?',
        options: [
          QuizOption(label: 'A', text: 'Performs integer addition'),
          QuizOption(label: 'B', text: 'Generates a software interrupt'),
          QuizOption(label: 'C', text: 'Initializes a variable'),
          QuizOption(label: 'D', text: 'Inverts all bits'),
        ],
        correctAnswer: 'B',
      ),
      QuizQuestion(
        question: 'Which addressing mode uses the contents of a register as the memory address?',
        options: [
          QuizOption(label: 'A', text: 'Immediate addressing'),
          QuizOption(label: 'B', text: 'Direct addressing'),
          QuizOption(label: 'C', text: 'Register indirect addressing'),
          QuizOption(label: 'D', text: 'Indexed addressing'),
        ],
        correctAnswer: 'C',
      ),
      // QuizQuestion(
      //   question: 'What does the LEA instruction stand for in assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Load Effective Address'),
      //     QuizOption(label: 'B', text: 'Link External Address'),
      //     QuizOption(label: 'C', text: 'Load Extended Accumulator'),
      //     QuizOption(label: 'D', text: 'Logical Exclusive Address'),
      //   ],
      //   correctAnswer: 'A',
      // ),
      // QuizQuestion(
      //   question: 'Which instruction is used to shift bits to the left in x86 assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'SHR'),
      //     QuizOption(label: 'B', text: 'SHL'),
      //     QuizOption(label: 'C', text: 'ROL'),
      //     QuizOption(label: 'D', text: 'ROR'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'What is the purpose of the RET instruction?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Resets the program'),
      //     QuizOption(label: 'B', text: 'Returns from a procedure'),
      //     QuizOption(label: 'C', text: 'Retrieves data from memory'),
      //     QuizOption(label: 'D', text: 'Repeats a loop'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'In 8086, which segment register is used for accessing the code segment?',
      //   options: [
      //     QuizOption(label: 'A', text: 'DS'),
      //     QuizOption(label: 'B', text: 'SS'),
      //     QuizOption(label: 'C', text: 'CS'),
      //     QuizOption(label: 'D', text: 'ES'),
      //   ],
      //   correctAnswer: 'C',
      // ),
      // QuizQuestion(
      //   question: 'What does the XOR instruction do when both operands are the same?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Sets the operand to 1'),
      //     QuizOption(label: 'B', text: 'Sets the operand to 0'),
      //     QuizOption(label: 'C', text: 'Doubles the operand value'),
      //     QuizOption(label: 'D', text: 'Has no effect'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which instruction is used to multiply two numbers in x86 assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'ADD'),
      //     QuizOption(label: 'B', text: 'MUL'),
      //     QuizOption(label: 'C', text: 'MULT'),
      //     QuizOption(label: 'D', text: 'IMUL'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'What is the purpose of the NOP instruction?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Negates the operand'),
      //     QuizOption(label: 'B', text: 'No operation (does nothing)'),
      //     QuizOption(label: 'C', text: 'Normalizes the result'),
      //     QuizOption(label: 'D', text: 'Nullifies the previous instruction'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which register pair is used to store the result of multiplication in 8086?',
      //   options: [
      //     QuizOption(label: 'A', text: 'AX:BX'),
      //     QuizOption(label: 'B', text: 'DX:AX'),
      //     QuizOption(label: 'C', text: 'CX:DX'),
      //     QuizOption(label: 'D', text: 'BX:CX'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'What does the LOOP instruction do in assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Creates an infinite loop'),
      //     QuizOption(label: 'B', text: 'Decrements CX and jumps if CX is not zero'),
      //     QuizOption(label: 'C', text: 'Increments CX and continues'),
      //     QuizOption(label: 'D', text: 'Exits the current loop'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which flag indicates a negative result in signed arithmetic?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Zero Flag (ZF)'),
      //     QuizOption(label: 'B', text: 'Carry Flag (CF)'),
      //     QuizOption(label: 'C', text: 'Sign Flag (SF)'),
      //     QuizOption(label: 'D', text: 'Parity Flag (PF)'),
      //   ],
      //   correctAnswer: 'C',
      // ),
      // QuizQuestion(
      //   question: 'What is the purpose of the AND instruction in assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Performs bitwise addition'),
      //     QuizOption(label: 'B', text: 'Performs logical AND operation'),
      //     QuizOption(label: 'C', text: 'Adds two numbers'),
      //     QuizOption(label: 'D', text: 'Multiplies two operands'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which instruction is used to call a subroutine in x86 assembly?',
      //   options: [
      //     QuizOption(label: 'A', text: 'JMP'),
      //     QuizOption(label: 'B', text: 'CALL'),
      //     QuizOption(label: 'C', text: 'INT'),
      //     QuizOption(label: 'D', text: 'PROC'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'What does the INC instruction do?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Includes a file'),
      //     QuizOption(label: 'B', text: 'Increments the operand by 1'),
      //     QuizOption(label: 'C', text: 'Initializes a counter'),
      //     QuizOption(label: 'D', text: 'Inverts the carry flag'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which directive is used to define a double word (32-bit) variable?',
      //   options: [
      //     QuizOption(label: 'A', text: 'DB'),
      //     QuizOption(label: 'B', text: 'DW'),
      //     QuizOption(label: 'C', text: 'DD'),
      //     QuizOption(label: 'D', text: 'DQ'),
      //   ],
      //   correctAnswer: 'C',
      // ),
      // QuizQuestion(
      //   question: 'What is the function of the NEG instruction?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Negates (two\'s complement) the operand'),
      //     QuizOption(label: 'B', text: 'Performs NOT operation'),
      //     QuizOption(label: 'C', text: 'Sets negative flag'),
      //     QuizOption(label: 'D', text: 'Resets the operand to zero'),
      //   ],
      //   correctAnswer: 'A',
      // ),
      // QuizQuestion(
      //   question: 'Which conditional jump instruction jumps if the zero flag is set?',
      //   options: [
      //     QuizOption(label: 'A', text: 'JNZ'),
      //     QuizOption(label: 'B', text: 'JZ'),
      //     QuizOption(label: 'C', text: 'JC'),
      //     QuizOption(label: 'D', text: 'JNC'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'What does the POP instruction do?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Pushes data onto the stack'),
      //     QuizOption(label: 'B', text: 'Removes and retrieves data from the stack'),
      //     QuizOption(label: 'C', text: 'Performs power operation'),
      //     QuizOption(label: 'D', text: 'Points to a memory location'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'In x86 assembly, what is the maximum value that can be stored in an 8-bit register?',
      //   options: [
      //     QuizOption(label: 'A', text: '127'),
      //     QuizOption(label: 'B', text: '255'),
      //     QuizOption(label: 'C', text: '256'),
      //     QuizOption(label: 'D', text: '511'),
      //   ],
      //   correctAnswer: 'B',
      // ),
      // QuizQuestion(
      //   question: 'Which instruction is used for bitwise OR operation?',
      //   options: [
      //     QuizOption(label: 'A', text: 'AND'),
      //     QuizOption(label: 'B', text: 'XOR'),
      //     QuizOption(label: 'C', text: 'OR'),
      //     QuizOption(label: 'D', text: 'NOT'),
      //   ],
      //   correctAnswer: 'C',
      // ),
      // QuizQuestion(
      //   question: 'What is the purpose of the TEST instruction?',
      //   options: [
      //     QuizOption(label: 'A', text: 'Tests if program is running'),
      //     QuizOption(label: 'B', text: 'Performs logical AND and sets flags without storing result'),
      //     QuizOption(label: 'C', text: 'Tests for errors'),
      //     QuizOption(label: 'D', text: 'Validates data types'),
      //   ],
      //   correctAnswer: 'B',
      // ),
    ];
  }
}

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> _questions = QuizData.getSampleQuestions();
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _hasAnswered = false;
  int _score = 0;

  // Timer
  late Timer _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _selectAnswer(String label) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswer = label;
      _hasAnswered = true;

      // Check if answer is correct
      if (label == _questions[_currentQuestionIndex].correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _hasAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswer = null;
        _hasAnswered = false;
      });
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your Score: $_score/${_questions.length}\nTime: ${_formatTime(_secondsElapsed)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizResultScreen(
                    totalScore: 20,
                    accuracy: 76,
                    timeTaken: '2m 43s',
                    rank: '12th / 50',
                    totalQuestions: 30,
            ),
        ),
      );
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  Color _getOptionBorderColor(String label) {
    if (!_hasAnswered) {
      return _selectedAnswer == label
          ? const Color(0xFF7C3AED)
          : const Color(0xFFE0E0E0);
    }

    // After answering
    final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;

    if (label == correctAnswer) {
      return const Color(0xFF4CAF50); // Green for correct
    }

    if (label == _selectedAnswer && label != correctAnswer) {
      return const Color(0xFFEF5350); // Red for incorrect
    }

    return const Color(0xFFE0E0E0);
  }

  Color _getOptionBackgroundColor(String label) {
    if (!_hasAnswered) {
      return _selectedAnswer == label
          ? const Color(0xFFF3F0FF)
          : Colors.white;
    }

    // After answering
    final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;

    if (label == correctAnswer) {
      return const Color(0xFFE8F5E9); // Light green for correct
    }

    if (label == _selectedAnswer && label != correctAnswer) {
      return const Color(0xFFFFEBEE); // Light red for incorrect
    }

    return Colors.white;
  }

  Widget _buildOptionIcon(String label) {
    if (!_hasAnswered) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedAnswer == label
                ? const Color(0xFF7C3AED)
                : const Color(0xFFBDBDBD),
            width: 2,
          ),
          color: _selectedAnswer == label
              ? const Color(0xFF7C3AED)
              : Colors.transparent,
        ),
        child: _selectedAnswer == label
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      );
    }

    // After answering
    final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;

    if (label == correctAnswer) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF4CAF50),
        ),
        child: const Icon(Icons.check, size: 16, color: Colors.white),
      );
    }

    if (label == _selectedAnswer && label != correctAnswer) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEF5350),
        ),
        child: const Icon(Icons.close, size: 16, color: Colors.white),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFBDBDBD), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: buildCircularBackButton(context),
        title: Text(
          _formatTime(_secondsElapsed),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    '$_score',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    StudifyImagePaths.diamond,
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question number
                  Text(
                    'Question ${_currentQuestionIndex + 1} / ${_questions.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Question text
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Options
                  ...currentQuestion.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _selectAnswer(option.label),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _getOptionBackgroundColor(option.label),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _getOptionBorderColor(option.label),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildOptionIcon(option.label),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${option.label}. ${option.text}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Bottom navigation
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: _previousQuestion,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF7C3AED),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 60),

                const Spacer(),

                GestureDetector(
                  onTap: _hasAnswered ? _nextQuestion : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: _hasAnswered
                          ? const LinearGradient(
                        colors: [Color(0xFF9575CD), Color(0xFF7C3AED)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                          : null,
                      color: _hasAnswered ? null : const Color(0xFFE0E0E0),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}