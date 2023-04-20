import 'package:flutter/material.dart';
import '../db_helper.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _controller = TextEditingController();
  String dropdownvalue = 'Latest';
  final items = ['Latest', 'Top', 'Categories'];

  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  // Get all data from database.
  void _refreshData() async{
    final data = await SQLHelper.getAllData();
    setState((){
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    await SQLHelper.createData(_titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(id, _titleController.text, _descController.text);
    _refreshData();
  }

  Future<void> _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    _refreshData();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Text Deleted"),
    ));
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void showBottomSheet(int? id) async {
    // if id is not null then it will update, or it will add new data
    // when edit icon is pressed then the id will be given to bottomsheet function
    // and the new title or description will be updated.
    if (id!=null){
      final existingData = _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding:EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
              ),
            ),
            const SizedBox(height:10),
            TextField(
              controller: _descController,
              maxLines:4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
            ),
            const SizedBox(height:10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  }
                  if (id != null) {
                    await _updateData(id);
                  }

                  _titleController.text = "";
                  _descController.text = "";

                  Navigator.of(context).pop();
                  print("New Post Added!");
                },
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Post" : "Save",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),
              )
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Center(
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 57, 60, 95),
            elevation: 0.0,
            title: const Text(
              'Community',
              textAlign: TextAlign.left,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {
                  // add code to execute when search icon is pressed
                },
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset(
                  'lib/images/profile_pic.jpg',
                ),
              ),
              const SizedBox(width: 8),
            ],
          )
        ),
      ),
      body:  SingleChildScrollView(
        // physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 50, 2, 139), width: 1.5),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon:  _controller.text.isEmpty ? null : Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: _controller.clear,
                              icon: const Icon(Icons.clear),
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.search, color: Color.fromARGB(255, 119, 52, 245)),
                    const SizedBox(width: 10),
                  ],
                ),
              )
            ),
            Row(
              children: [
                const SizedBox(width: 5, height: 50),
                DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: IntrinsicWidth(
                      child: SizedBox(
                        height: 35,
                        child: DropdownButton(
                          icon: const Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 94, 93, 93)),
                          isExpanded: true,
                          value: dropdownvalue,
                          style: const TextStyle(fontSize: 16),
                          dropdownColor: Colors.white,
                          items: items.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Center(
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black,),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if(mounted) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: const [
                  Text('Topic'),
                  Spacer(),
                  Text('Replies'),
                  SizedBox(width: 16),
                  Text('Activity'),
                ],
              ),
            ),
            Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
              _isLoading
              ? const Center(child: CircularProgressIndicator(),)
              : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allData.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        _allData[index]['title'],
                        style: const TextStyle(fontSize:20,)
                      )
                    ),
                    subtitle: Text(_allData[index]['desc']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showBottomSheet(_allData[index]['id']);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )
                        ),
                        IconButton(
                          onPressed: (){
                            _deleteData(_allData[index]['id']);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        )
                      ],
                    ),
                  )
                )
              ),
            ]
          ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(null);
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}
