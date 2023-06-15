import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget(
      {Key? key, required this.transactions, required this.periodo})
      : super(key: key);
  final String periodo;
  final List<TransactionModel> transactions;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85,
      //
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(widget.transactions, widget.periodo),
          borderData: FlBorderData(
            border: const Border(),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _transforma(widget.periodo)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups(
      List<TransactionModel> transactions, String periodo) {
    DateTime hoje = DateTime.now();
    switch (periodo) {
      case 'Máx':
        int qtd_total = transactions.length;
        int qtd_periodo = 5;
        List<double> valores = List.filled(qtd_periodo, 0);
        List<String> listaAnual = [];
        for (int i = 4; i >= 0; i--) {
          int ano = hoje.year.toInt() - i;
          listaAnual.add(ano.toString());
        }
        int index = 0;
        listaAnual.forEach((ano) {
          transactions.forEach((element) {
            String dataFormatada = element.data.substring(0, 4);
            if (dataFormatada == ano) {
              if (element.tipoTransacao == 1) {
                valores[index] += element.valor;
              }
            }
          });
          index++;
        });
        List<PricePoint> points = [];
        double i = 0;
        valores.forEach((element) {
          points.add(PricePoint(x: i, y: element));
          i++;
        });

        return points
            .map((point) => BarChartGroupData(
                x: point.x.toInt(), barRods: [BarChartRodData(toY: point.y)]))
            .toList();
        break;
      case '1M':
        int index = 0;
        List<double> numbers = List.filled(5, 0);
        final formatador = DateFormat('dd-MM');

        final primeiro_dia = hoje.subtract(const Duration(days: 32));
        // final primeiro_dia_f = formatador.format(primeiro_dia);
        int dia_um = primeiro_dia.day;
        int mes_um = primeiro_dia.month;
        int ano_um = primeiro_dia.year;

        final segundo_dia = primeiro_dia.add(const Duration(days: 8));
        // final segundo_dia_f = formatador.format(segundo_dia);
        int dia_dois = segundo_dia.day;
        int mes_dois = segundo_dia.month;
        int ano_dois = segundo_dia.year;

        final terceiro_dia = segundo_dia.add(const Duration(days: 8));
        // final terceiro_dia_f = formatador.format(terceiro_dia);
        int dia_tres = terceiro_dia.day;
        int mes_tres = terceiro_dia.month;
        int ano_tres = terceiro_dia.year;

        final quarto_dia = terceiro_dia.add(const Duration(days: 8));
        // final quarto_dia_f = formatador.format(quarto_dia);
        int dia_quatro = quarto_dia.day;
        int mes_quatro = quarto_dia.month;
        int ano_quatro = quarto_dia.year;

        int dia_atual = hoje.day;
        int mes_atual = hoje.month;
        int ano_atual = hoje.year;
        // final dia_atual_f = formatador.format(hoje);

        // List<String> lista = [primeiro_dia_f,segundo_dia_f,terceiro_dia_f,quarto_dia_f,dia_atual_f];;

        List<int> dias = [dia_um, dia_dois, dia_tres, dia_quatro, dia_atual];
        List<int> meses = [mes_um, mes_dois, mes_tres, mes_quatro, mes_atual];
        List<int> anos = [ano_um, ano_dois, ano_tres, ano_quatro, ano_atual];
        List<int> meses_distintos = [];

        meses.forEach((element) {
          if (!meses_distintos.contains(element)) {
            meses_distintos.add(element);
          }
        });
        List<double> valores = List.filled(5, 0);

        transactions.forEach((transact) {
          int index = 0;
          dias.forEach((dia) {
            List<String> campos = transact.data.split('-');
            int ano = int.parse(campos[0]);
            int mes = int.parse(campos[1]);
            int dia = int.parse(campos[2]);
            DateTime data_transact = DateTime(ano, mes, dia);
            DateTime data_param =
                DateTime(anos[index], meses[index], dias[index]);
            if (transact.tipoTransacao == 1) {
              if (!(index == 0)) {
                if (data_transact.difference(data_param).inDays < 8 &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              } else {
                DateTime dia_index =
                    DateTime(anos[index], meses[index], dias[index]);
                if (dia_index.difference(data_transact).inDays <
                        data_transact.day &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              }
            }
            index++;
          });
        });
        int index2 = 0;
        valores.forEach((element) {
          if (index2 > 0) {
            if (element == 0.0) {
              if (meses[index2] == meses[index2 - 1]) {
                valores[index2] += valores[index2 - 1];
              }
            }
          }
          index2++;
        });
        List<PricePoint> points = [];
        double i = 0;
        valores.forEach((element) {
          points.add(PricePoint(x: i, y: element));
          i++;
        });
        return points
            .map((point) => BarChartGroupData(
                x: point.x.toInt(), barRods: [BarChartRodData(toY: point.y)]))
            .toList();
        break;
      case '3M':
        int index = 0;
        List<double> numbers = List.filled(5, 0);
        final formatador = DateFormat('dd-MM');

        final primeiro_dia = hoje.subtract(const Duration(days: 96));
        // final primeiro_dia_f = formatador.format(primeiro_dia);
        int dia_um = primeiro_dia.day;
        int mes_um = primeiro_dia.month;
        int ano_um = primeiro_dia.year;

        final segundo_dia = primeiro_dia.add(const Duration(days: 24));
        // final segundo_dia_f = formatador.format(segundo_dia);
        int dia_dois = segundo_dia.day;
        int mes_dois = segundo_dia.month;
        int ano_dois = segundo_dia.year;

        final terceiro_dia = segundo_dia.add(const Duration(days: 24));
        // final terceiro_dia_f = formatador.format(terceiro_dia);
        int dia_tres = terceiro_dia.day;
        int mes_tres = terceiro_dia.month;
        int ano_tres = terceiro_dia.year;

        final quarto_dia = terceiro_dia.add(const Duration(days: 24));
        // final quarto_dia_f = formatador.format(quarto_dia);
        int dia_quatro = quarto_dia.day;
        int mes_quatro = quarto_dia.month;
        int ano_quatro = quarto_dia.year;

        int dia_atual = hoje.day;
        int mes_atual = hoje.month;
        int ano_atual = hoje.year;
        // final dia_atual_f = formatador.format(hoje);

        // List<String> lista = [primeiro_dia_f,segundo_dia_f,terceiro_dia_f,quarto_dia_f,dia_atual_f];;

        List<int> dias = [dia_um, dia_dois, dia_tres, dia_quatro, dia_atual];
        List<int> meses = [mes_um, mes_dois, mes_tres, mes_quatro, mes_atual];
        List<int> anos = [ano_um, ano_dois, ano_tres, ano_quatro, ano_atual];
        List<int> meses_distintos = [];

        meses.forEach((element) {
          if (!meses_distintos.contains(element)) {
            meses_distintos.add(element);
          }
        });
        List<double> valores = List.filled(5, 0);

        transactions.forEach((transact) {
          int index = 0;
          dias.forEach((dia) {
            List<String> campos = transact.data.split('-');
            int ano = int.parse(campos[0]);
            int mes = int.parse(campos[1]);
            int dia = int.parse(campos[2]);
            DateTime data_transact = DateTime(ano, mes, dia);
            DateTime data_param =
                DateTime(anos[index], meses[index], dias[index]);
            if (transact.tipoTransacao == 1) {
              if (!(index == 0)) {
                if (data_transact.difference(data_param).inDays < 8 &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              } else {
                DateTime dia_index =
                    DateTime(anos[index], meses[index], dias[index]);
                if (dia_index.difference(data_transact).inDays <
                        data_transact.day &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              }
            }
            index++;
          });
        });
        int index2 = 0;
        valores.forEach((element) {
          if (index2 > 0) {
            if (element == 0.0) {
              if (meses[index2] == meses[index2 - 1]) {
                valores[index2] += valores[index2 - 1];
              }
            }
          }
          index2++;
        });
        List<PricePoint> points = [];
        double i = 0;
        valores.forEach((element) {
          points.add(PricePoint(x: i, y: element));
          i++;
        });
        return points
            .map((point) => BarChartGroupData(
                x: point.x.toInt(), barRods: [BarChartRodData(toY: point.y)]))
            .toList();
        break;
      case '6M':
        int index = 0;
        List<double> numbers = List.filled(5, 0);
        final formatador = DateFormat('dd-MM');

        final primeiro_dia = hoje.subtract(const Duration(days: 182));
        // final primeiro_dia_f = formatador.format(primeiro_dia);
        int dia_um = primeiro_dia.day;
        int mes_um = primeiro_dia.month;
        int ano_um = primeiro_dia.year;

        final segundo_dia = primeiro_dia.add(const Duration(days: 48));
        // final segundo_dia_f = formatador.format(segundo_dia);
        int dia_dois = segundo_dia.day;
        int mes_dois = segundo_dia.month;
        int ano_dois = segundo_dia.year;

        final terceiro_dia = segundo_dia.add(const Duration(days: 48));
        // final terceiro_dia_f = formatador.format(terceiro_dia);
        int dia_tres = terceiro_dia.day;
        int mes_tres = terceiro_dia.month;
        int ano_tres = terceiro_dia.year;

        final quarto_dia = terceiro_dia.add(const Duration(days: 48));
        // final quarto_dia_f = formatador.format(quarto_dia);
        int dia_quatro = quarto_dia.day;
        int mes_quatro = quarto_dia.month;
        int ano_quatro = quarto_dia.year;

        int dia_atual = hoje.day;
        int mes_atual = hoje.month;
        int ano_atual = hoje.year;
        // final dia_atual_f = formatador.format(hoje);

        // List<String> lista = [primeiro_dia_f,segundo_dia_f,terceiro_dia_f,quarto_dia_f,dia_atual_f];;

        List<int> dias = [dia_um, dia_dois, dia_tres, dia_quatro, dia_atual];
        List<int> meses = [mes_um, mes_dois, mes_tres, mes_quatro, mes_atual];
        List<int> anos = [ano_um, ano_dois, ano_tres, ano_quatro, ano_atual];
        List<int> meses_distintos = [];

        meses.forEach((element) {
          if (!meses_distintos.contains(element)) {
            meses_distintos.add(element);
          }
        });
        List<double> valores = List.filled(5, 0);

        transactions.forEach((transact) {
          int index = 0;
          dias.forEach((dia) {
            List<String> campos = transact.data.split('-');
            int ano = int.parse(campos[0]);
            int mes = int.parse(campos[1]);
            int dia = int.parse(campos[2]);
            DateTime data_transact = DateTime(ano, mes, dia);
            DateTime data_param =
                DateTime(anos[index], meses[index], dias[index]);
            if (transact.tipoTransacao == 1) {
              if (!(index == 0)) {
                if (data_transact.difference(data_param).inDays < 8 &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              } else {
                DateTime dia_index =
                    DateTime(anos[index], meses[index], dias[index]);
                if (dia_index.difference(data_transact).inDays <
                        data_transact.day &&
                    data_param.month == data_transact.month) {
                  valores[index] += transact.valor;
                }
              }
            }
            index++;
          });
        });
        int index2 = 0;
        valores.forEach((element) {
          if (index2 > 0) {
            if (element == 0.0) {
              if (meses[index2] == meses[index2 - 1]) {
                valores[index2] += valores[index2 - 1];
              }
            }
          }
          index2++;
        });
        List<PricePoint> points = [];
        double i = 0;
        valores.forEach((element) {
          points.add(PricePoint(x: i, y: element));
          i++;
        });
        return points
            .map((point) => BarChartGroupData(
                x: point.x.toInt(), barRods: [BarChartRodData(toY: point.y)]))
            .toList();
        break;
      case '1Y':
        break;
      default:
        break;
    }

    List<BarChartGroupData> lista = [];

    return lista;
  }

  SideTitles _transforma(String periodo) {
    DateTime hoje = DateTime.now();
    List<double> numbers = List.filled(5, 0);
    final formatador = DateFormat('dd-MM');
    int dayslongos = 0;
    int dayscurtos = 0;
    if (periodo == 'Máx') {
      List<String> listaAnual = [];
      for (int i = 4; i >= 0; i--) {
        int ano = hoje.year.toInt() - i;
        listaAnual.add(ano.toString());
      }
      return _bottomTitles(listaAnual);
    } else if (periodo == '1M') {
      dayslongos = 32;
      dayscurtos = 8;
    } else if (periodo == '3M') {
      dayslongos = 96;
      dayscurtos = 24;
    } else if (periodo == '6M') {
      dayslongos = 182;
      dayscurtos = 48;
    } else if (periodo == '1Y') {
      dayslongos = 365;
      dayscurtos = 91;
    }

    List<String> formatados = [];

    final primeiro_dia = hoje.subtract(Duration(days: dayslongos));
    final primeiro_dia_f = formatador.format(primeiro_dia);
    formatados.add(primeiro_dia_f);

    final segundo_dia = primeiro_dia.add(Duration(days: dayscurtos));
    final segundo_dia_f = formatador.format(segundo_dia);
    formatados.add(segundo_dia_f);

    final terceiro_dia = segundo_dia.add(Duration(days: dayscurtos));
    final terceiro_dia_f = formatador.format(terceiro_dia);
    formatados.add(terceiro_dia_f);

    final quarto_dia = terceiro_dia.add(Duration(days: dayscurtos));
    final quarto_dia_f = formatador.format(quarto_dia);
    formatados.add(quarto_dia_f);
    formatados.add(formatador.format(hoje));

    return _bottomTitles(formatados);
  }

  SideTitles _bottomTitles(List<String> datas_formatadas) => SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = ' ';
          switch (value.toInt()) {
            case 0:
              text = datas_formatadas[value.toInt()].replaceAll('-', '/');
              break;
            case 1:
              text = datas_formatadas[value.toInt()].replaceAll('-', '/');
              break;
            case 2:
              text = datas_formatadas[value.toInt()].replaceAll('-', '/');
              break;
            case 3:
              text = datas_formatadas[value.toInt()].replaceAll('-', '/');
              break;
            case 4:
              text = datas_formatadas[value.toInt()].replaceAll('-', '/');
              break;
          }

          return Text(text);
        },
      );
}

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}
