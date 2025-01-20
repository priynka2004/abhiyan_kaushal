import 'package:abhiyan_kaushal/referral_screen.dart';
import 'package:flutter/material.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  int _selectedPlan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DADC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 14),
              onPressed: () {
                Navigator.of(context);
              },
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 35,
              right: 16,
            ),
            child: Image.asset(
              'assets/images/Star 8.png',
              height: 44,
              width: 46,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40,left: 16,right: 16,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your plan",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "To complete the sign up process, please\nmake the payment",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            _buildPlanOption(0, "आजीवन सदस्य", "₹51000"),
            const SizedBox(height: 16),
            _buildPlanOption(1, "विशिट सदस्य", "₹11000/year"),
            const SizedBox(height: 16),
            _buildPlanOption(2, "सामान्य सदस्य", "₹100/year"),

            const Spacer(flex: 3),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const ReferralScreen();
                  }));
                  print("Proceed to pay for plan: $_selectedPlan");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0500),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed to pay',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanOption(int index, String title, String price) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPlan = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedPlan == index ? Colors.black : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(price),
              ],
            ),
            if (_selectedPlan == index)
              Radio<int>(
                value: index,
                groupValue: _selectedPlan,
                onChanged: (int? value) {
                  setState(() {
                    _selectedPlan = value!;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.black;
                      }
                      return Colors.grey;
                    }),
              ),
          ],
        ),
      ),
    );
  }

}
