import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/widgets/back_nav.dart';

class FeedbackPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const FeedbackPage(),
      );
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackNav(
                  text: 'Feedback',
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 30),
                _buildFeedbackForm(),
                const SizedBox(height: 30),
                const Text(
                  'Feedback History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: _buildFeedbackList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _message,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            maxLines: null,
            style: const TextStyle(color: AppColors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: AppColors.gray,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: AppColors.gray,
                ),
              ),
              hintText: 'Your feedback',
              hintStyle: TextStyle(color: AppColors.gray),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              maximumSize: const Size(double.infinity, 45),
              minimumSize: const Size(double.infinity, 45),
              backgroundColor: AppColors.gray,
              foregroundColor: Colors.white,
            ),
            onPressed: isLoading ? null : _handleSubmit,
            child: isLoading
                ? const SizedBox(
                    height: 35, width: 35, child: CircularProgressIndicator())
                : const Text('Send Feedback'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('feedback')
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading feedback'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No feedback available'));
        }

        return ListView.separated(
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) =>
              const Divider(color: AppColors.gray),
          itemBuilder: (context, index) {
            var feedbackData = snapshot.data!.docs[index];
            String message = feedbackData['message'];
            DateTime createdAt =
                DateTime.fromMillisecondsSinceEpoch(feedbackData['created_at']);
            return _buildFeedbackItem(message, createdAt);
          },
        );
      },
    );
  }

  Widget _buildFeedbackItem(String message, DateTime createdAt) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      String feedback = _message.text.trim();
      setState(() {
        isLoading = true;
      });
      final res = await sendFeedback(feedback);
      setState(() {
        isLoading = false;
      });
      showAlert(res);
      _message.clear();
    }
  }

  showAlert(bool feedback) {
    AwesomeDialog(
      context: context,
      dialogType: feedback ? DialogType.success : DialogType.error,
      animType: AnimType.topSlide,
      title: feedback ? 'Success' : 'Error',
      desc: feedback ? 'Feedback sent successfully' : 'Failed to send feedback',
      btnOkOnPress: () {},
    ).show();
  }

  Future<bool> sendFeedback(String text) async {
    try {
      await _db.collection('feedback').add({
        'message': text,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
