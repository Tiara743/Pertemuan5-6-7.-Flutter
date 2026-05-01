import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  State<RadiobuttonPage> createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  String? _selectedGender;
  String? _selectedJob;
  String? _selectedWorkType;

  /// PEKERJAAN (DESKRIPSI LEBIH VARIATIF)
  final List<Map<String, String>> jobs = [
    {"title": "Admin", "desc": "Atur & kelola data"},
    {"title": "Guru", "desc": "Mengajar & membimbing"},
    {"title": "Programmer", "desc": "Ngoding bikin aplikasi"},
  ];

  /// TIPE PEKERJAAN (LEBIH SINGKAT & BEDA)
  final List<Map<String, String>> workTypes = [
    {"title": "Full Time", "desc": "±40 jam/minggu • kerja tetap"},
    {"title": "Part Time", "desc": "<40 jam • fleksibel"},
    {"title": "Freelance", "desc": "Project-based • bebas tempat"},
    {"title": "Kontrak", "desc": "Durasi tertentu • sesuai perjanjian"},
  ];

  final Color primaryPink = const Color(0xFFE91E63);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        title: const Text("Form RadioButton"),
        backgroundColor: primaryPink,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// DATA DIRI
            _buildSectionTitle("Data Diri", Icons.person),

            _buildCard(
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      prefixIcon: Icon(Icons.person, color: primaryPink),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Tidak boleh kosong" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _umurController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Umur",
                      prefixIcon: Icon(Icons.cake, color: primaryPink),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// JENIS KELAMIN
            _buildSectionTitle("Jenis Kelamin", Icons.people),

            _buildCard(
              child: Row(
                children: [
                  Expanded(
                    child: _genderCard("Laki-laki", Icons.male, Colors.blue),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _genderCard("Perempuan", Icons.female, primaryPink),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PEKERJAAN
            _buildSectionTitle("Pekerjaan", Icons.work),

            _buildCard(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: jobs.map((job) {
                  final selected = _selectedJob == job['title'];

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedJob = job['title']);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selected ? primaryPink : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryPink),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            job['title']!,
                            style: TextStyle(
                              color:
                                  selected ? Colors.white : primaryPink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job['desc']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: selected
                                  ? Colors.white70
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// TIPE PEKERJAAN
            _buildSectionTitle("Tipe Pekerjaan", Icons.business),

            _buildCard(
              child: Column(
                children: workTypes.map((work) {
                  final selected = _selectedWorkType == work['title'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryPink.withOpacity(0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? primaryPink
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: RadioListTile(
                      activeColor: primaryPink,
                      value: work['title'],
                      groupValue: _selectedWorkType,
                      onChanged: (v) {
                        setState(() => _selectedWorkType = v);
                      },
                      title: Text(work['title']!),
                      subtitle: Text(
                        work['desc']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            /// BUTTON
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.save),
                    label: const Text("Simpan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPink,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryPink,
                      side: BorderSide(color: primaryPink),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// WIDGET
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryPink,
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _genderCard(String title, IconData icon, Color color) {
    final selected = _selectedGender == title;

    return GestureDetector(
      onTap: () => setState(() => _selectedGender = title),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  /// FUNCTION
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Data"),
          content: Text(
            "Nama: ${_namaController.text}\n"
            "Umur: ${_umurController.text}\n"
            "Gender: $_selectedGender\n"
            "Pekerjaan: $_selectedJob\n"
            "Tipe: $_selectedWorkType",
          ),
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _umurController.clear();

    setState(() {
      _selectedGender = null;
      _selectedJob = null;
      _selectedWorkType = null;
    });
  }
}