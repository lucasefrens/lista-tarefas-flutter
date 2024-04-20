import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {    
    const String title = 'Lista de Afazeres';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _tarefas[index].status ? const Color.fromARGB(255, 22, 177, 99) : Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (!_tarefas[index].status)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _tarefas[index].status = true;
                                });
                              },
                              icon: const Icon(Icons.done, color: Color.fromARGB(255, 22, 177, 99),),
                            ),
                            const SizedBox(width: 15,),
                            Text(
                              _tarefas[index].descricao,
                              style: TextStyle(
                                color: _tarefas[index].status ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0)
                              )
                            ),
                          ],
                        ),
                        if (!_tarefas[index].status) 
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                TextEditingController controller = TextEditingController(text: _tarefas[index].descricao);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Editar Tarefa',
                                      ),
                                      content: TextField(
                                        controller: controller,
                                        decoration: const InputDecoration(
                                          hintText: 'Descrição da tarefa',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _tarefas[index].descricao = controller.text;
                                            });
                                            Navigator.of(context).pop(); // Fecha o modal
                                          },
                                          child: const Text('Salvar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Fecha o modal
                                          },
                                          child: const Text('Fechar'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                              icon: const Icon(Icons.edit, color: Color.fromARGB(255, 91, 148, 255),),
                            ),
                            const SizedBox(width: 15,),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _tarefas.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 151, 47, 47),)
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controlador,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(200, 60))),
                    child: const Text('Adicionar Tarefa'),
                    onPressed: () {
                      if (controlador.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        _tarefas.add(
                          Tarefa(
                            descricao: controlador.text,
                            status: false,
                          ),
                        );
                      });
                      controlador.clear();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
