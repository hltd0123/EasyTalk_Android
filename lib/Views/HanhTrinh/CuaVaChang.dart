import 'package:dacn/Model/Gate.dart';
import 'package:dacn/Model/Stage.dart';
import 'package:dacn/Model/UserProgress.dart';
import 'package:dacn/Views/HanhTrinh/QuestionStageProvider.dart';
import 'package:dacn/Views/WidgetBuiding/customPageRoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuaVaChang extends StatefulWidget {
  final List<Gate> gateList;
  final UserProgress userProgress;

  const CuaVaChang({super.key, required this.gateList, required this.userProgress});

  @override
  State<CuaVaChang> createState() => _CuaVaChangState();
}

class _CuaVaChangState extends State<CuaVaChang> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cửa và Chặng',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: widget.gateList.length,
        itemBuilder: (context, gateIndex) {
          final gate = widget.gateList[gateIndex];
          final isGateDisabled = !widget.userProgress.unlockedGates.contains(gate.id);

          return Column(
            children: [
              // Gate Tile (Cửa)
              _buildGateTile(
                gate.title,
                screenWidth,
                screenHeight,
                isGateDisabled,
              ),
              const SizedBox(height: 20),
              // Stage Tiles (Chặng)
              ...List.generate(gate.stages.length, (stageIndex) {
                final stage = gate.stages[stageIndex];
                final isStageDisabled = !widget.userProgress.unlockedStages.contains(stage.id);
                return Column(
                  children: [
                    _buildArrowDown(),
                    const SizedBox(height: 20),
                    _buildStageTile(
                      stage,
                      screenWidth,
                      screenHeight,
                      isStageDisabled,
                      context
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // Gate Tile (Cửa) Widget
  Widget _buildGateTile(String title, double screenWidth, double screenHeight, bool isDisabled) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        height: screenHeight * 0.3,
        width: screenWidth,
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade300 : Colors.blue.shade200, // Màu nền
          borderRadius: BorderRadius.circular(12), // Bo góc
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Đổ bóng
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isDisabled ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Stage Tile (Chặng) Widget
  Widget _buildStageTile(Stage stage, double screenWidth, double screenHeight, bool isDisabled, BuildContext context) {
    return GestureDetector(
      onTap: isDisabled
          ? null // Không làm gì nếu bị disabled
          : () async {
        // Thực hiện hành động khi nhấn và Stage không bị disabled
        await Navigator.push(
          context, customPageRoute(BaiTapScreen(questionStage: stage.questions, stateId: stage.id))
        );
      },
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          height: screenHeight * 0.15,
          width: screenWidth * 0.6,
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey.shade300 : Colors.green.shade200, // Màu nền
            borderRadius: BorderRadius.circular(12), // Bo góc
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Đổ bóng
              ),
            ],
          ),
          child: Center(
            child: Text(
              stage.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.grey : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Arrow Down Widget
  Widget _buildArrowDown() {
    return const Icon(
      Icons.arrow_downward,
      size: 40,
      color: Colors.black,
    );
  }
}

class BaiTapScreen extends StatefulWidget {
  final List<QuestionStage> questionStage;
  final String stateId;

  BaiTapScreen({super.key, required this.questionStage, required this.stateId});

  @override
  State<BaiTapScreen> createState() => _BaiTapScreenState();
}

class _BaiTapScreenState extends State<BaiTapScreen> {
  String _currentAnswer = '';

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => QuestionStageProvider(widget.questionStage),
      child: Consumer<QuestionStageProvider>(
        builder: (context, provider, _) {
          final currentQuestion = provider.questionStage[provider.currentQuestionIndex];
          int numQuestion = provider.questionStage.length;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Bài Tập'),
              backgroundColor: Colors.blue.shade700,
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async => {
                    if (await _showExitDialog(context)){
                      await provider.endQuestion(context, widget.stateId)
                    }
                  },
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hiển thị câu hỏi
                  Center(
                    child: Text(
                      currentQuestion.question,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Hiển thị giao diện dựa vào type của câu hỏi
                  if (currentQuestion.type == 'multiple-choice')
                    _buildMultipleChoice(currentQuestion.options, provider)
                  else if (currentQuestion.type == 'translation' ||
                      currentQuestion.type == 'fill-in-the-blank')
                    _buildTranslationAndFill(provider),

                  const SizedBox(height: 20),

                  // Nút xem kết quả và hiển thị giải thích
                  if (provider.isQuestionResult(provider.currentQuestionIndex) == null)
                    ElevatedButton(
                      onPressed: () {
                        provider.checkAnswer(
                          _currentAnswer,
                          currentQuestion,
                        );
                      },
                      child: const Text('Xem kết quả'),
                    ),
                  if (provider.isQuestionResult(provider.currentQuestionIndex) != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          if(provider.isQuestionResult(provider.currentQuestionIndex)!)
                            const Text(
                              'Bạn đã trả lời đúng',
                              style: TextStyle(fontSize: 16, color: Colors.greenAccent),
                            )
                          else
                            const Text(
                              'Bạn đã trả lời sai',
                              style: TextStyle(fontSize: 16, color: Colors.redAccent),
                            ),
                          Text(
                            'Giải thích: ${currentQuestion.explanation}',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      )
                    ),
                  const Spacer(),

                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      numQuestion,
                          (index) => GestureDetector(
                        onTap: () {
                           provider.goToQuestion(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: provider.currentQuestionIndex == index
                                ? Colors.blue
                                : (provider.isQuestionResult(index) == null
                                ? Colors.grey.shade300
                                : (provider.isQuestionResult(index) == false
                                ? Colors.red.shade300
                                : Colors.green)),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: provider.currentQuestionIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    // showDialog trả về một giá trị kiểu Object? nên cần ép kiểu về bool?
    bool? exit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cảnh báo'),
          content: const Text('Bạn có chắc muốn kết thúc bài thi không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );

    // Kiểm tra exit có null hay không, trả về giá trị boolean
    return exit ?? false;
  }

  // Widget cho multiple-choice
  Widget _buildMultipleChoice(List<String> options, QuestionStageProvider provider) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: options.asMap().entries.map((entry) {
        int idx = entry.key;
        String option = entry.value;
        return ElevatedButton(
          onPressed: () {
            if(provider.isQuestionResult(provider.currentQuestionIndex) == null){
              _currentAnswer = option;
              provider.setAnswer(option);
            }
          },
          style: ElevatedButton.styleFrom(
            // Kiểm tra xem câu trả lời hiện tại có trùng với option này không
            backgroundColor: provider.answered[provider.currentQuestionIndex] == option
                ? Colors.green // Nền xanh lá nếu câu trả lời đúng
                : Colors.white, // Nền trắng nếu câu trả lời sai hoặc chưa chọn
          ),
          child: Text(
            option,
            style: TextStyle(
              // Kiểm tra lại câu trả lời đã được chọn, để thay đổi màu chữ
              color: provider.answered[provider.currentQuestionIndex]  == option
                  ? Colors.black
                  : Colors.blueAccent
            ),
          ),
        );
      }).toList(),
    );
  }

  // Widget cho translation và fill-in-the-blank
  Widget _buildTranslationAndFill(QuestionStageProvider provider) {
    TextEditingController textController = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Nhập câu trả lời của bạn...',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}



