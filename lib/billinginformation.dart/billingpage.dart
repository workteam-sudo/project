import 'package:flutter/material.dart';

class BillingInformationPage extends StatelessWidget {
  const BillingInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            const Text(
              "Billing Information",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Showing 4 recent bills",
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.filter_list, color: Colors.black87),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/viewdetails');
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInvoiceCard(
                context,
                invoiceNumber: "#INV-1024",
                status: "Pending",
                statusColor: Colors.red,
                totalAmount: "\$1,200.00",
                paidAmount: "\$800.00",
                balanceAmount: "\$400.00",
                balanceColor: Colors.red,
                buttonTitle: "View Details",
                buttonColor: const Color(0xFF007AFF),
                isHighlighted: true,
              ),
              const SizedBox(height: 16),
              _buildInvoiceCard(
                context,
                invoiceNumber: "#INV-1023",
                status: "Paid",
                statusColor: Colors.green,
                totalAmount: "\$2,500.00",
                paidAmount: "\$2,500.00",
                balanceAmount: "\$0.00",
                balanceColor: Colors.green,
                buttonTitle: "View Receipt",
                buttonColor: const Color(0xFF007AFF),
                isHighlighted: false,
              ),
              const SizedBox(height: 16),
              _buildInvoiceCard(
                context,
                invoiceNumber: "#INV-1022",
                status: "Overdue",
                statusColor: Colors.red,
                totalAmount: "\$450.00",
                paidAmount: "\$150.00",
                balanceAmount: "\$300.00",
                balanceColor: Colors.red,
                buttonTitle: "Send Reminder",
                buttonColor: const Color(0xFF007AFF),
                isHighlighted: true,
              ),
              const SizedBox(height: 16),
              _buildInvoiceCard(
                context,
                invoiceNumber: "#INV-1021",
                status: "Upcoming",
                statusColor: const Color(0xFF007AFF),
                totalAmount: "\$3,200.00",
                paidAmount: "\$0.00",
                balanceAmount: "Due Soon",
                balanceColor: const Color(0xFF007AFF),
                buttonTitle: "View Schedule",
                buttonColor: const Color(0xFF007AFF),
                isHighlighted: false,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF007AFF),
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Bill",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(
    BuildContext context, {
    required String invoiceNumber,
    required String status,
    required Color statusColor,
    required String totalAmount,
    required String paidAmount,
    required String balanceAmount,
    required Color balanceColor,
    required String buttonTitle,
    required Color buttonColor,
    required bool isHighlighted,
  }) {
    return GestureDetector(
      onTap: () {
        if (buttonTitle == "View Details") {
          Navigator.pushNamed(context, '/viewdetails');
        } else if (buttonTitle == "View Receipt") {
          Navigator.pushNamed(context, '/viewreceipt');
        } else if (buttonTitle == "Send Reminder") {
          Navigator.pushNamed(context, '/sendreminder');
        } else if (buttonTitle == "View Schedule") {
          Navigator.pushNamed(context, '/viewschedule');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: isHighlighted
              ? Border.all(color: Colors.red.withOpacity(0.3), width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoiceNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalAmount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Paid",
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      paidAmount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: balanceColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Balance",
                    style: TextStyle(
                      fontSize: 12,
                      color: balanceColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    balanceAmount,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: balanceColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (buttonTitle == "View Details") {
                    Navigator.pushNamed(context, '/viewdetails');
                  } else if (buttonTitle == "View Receipt") {
                    Navigator.pushNamed(context, '/viewreceipt');
                  } else if (buttonTitle == "Send Reminder") {
                    Navigator.pushNamed(context, '/sendreminder');
                  } else if (buttonTitle == "View Schedule") {
                    Navigator.pushNamed(context, '/viewschedule');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  buttonTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// Bill Details Page
// ============================================

class BillDetailsPage extends StatelessWidget {
  const BillDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          "Bill Details",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invoice Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F7FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#INV-1024",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "October 24, 2023",
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Hospital Services Section
              const Text(
                "Hospital Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Service Items
              _buildServiceItem("Consultation Fee", "\$200.00"),
              _buildServiceItem("Lab Tests", "\$400.00"),
              _buildServiceItem("Pharmacy", "\$600.00"),
              const SizedBox(height: 16),

              // Divider
              Container(
                height: 1,
                color: Colors.grey[200],
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),
              const SizedBox(height: 8),

              // Subtotal
              _buildSummaryRow("Subtotal", "\$1,200.00", false),
              const SizedBox(height: 8),

              // Insurance Deduction
              _buildSummaryRow("Insurance Deduction", "\$0.00", true),
              const SizedBox(height: 16),

              // Pending Balance
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Pending Balance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      "\$400.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Payment Button with Gradient
              _buildGradientButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, bool isInsurance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: isInsurance ? Colors.green[700] : Colors.black87,
            fontWeight: isInsurance ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isInsurance ? Colors.green[700] : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Fixed Gradient Button
  Widget _buildGradientButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF007AFF), Color(0xFF0056B3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007AFF).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Center(
              child: Text(
                "Proceed to Payment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
