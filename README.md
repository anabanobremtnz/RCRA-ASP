# Yin Yang Puzzle

## TODO
- [ ] Cambiar variables para non repetir o de negro para blanco.
- [ ] Revisar encode.py para refacer manualmente.
- [ ] Mirar por que da tantas solucións xa para o exemplo 02.

Resolver puzzle Yin Yang utilizando **Clingo** (ASP). O obxectivo é colorear cada celda dunha cuadrícula \(N \times N\) con celdas negras e brancas cumplindo:

1. Todas as celdas negras deben estar ortogonalmente conectadas.
2. Todas as celdas brancas deben estar ortogonalmente conectadas.
3. Non pode haber bloques \(2 \times 2\) da mesma cor.

## Files

- **yinyangKB.lp**: regras que definen o puzzle en **ASP**.
- **encode.py**: convirte unha instancia de texto nun arquivo **ASP**.
- **decode.py**: resolve o **ASP** usando Clingo e xenera a solución en txt.
- **domXX.txt**: exemplo dunha instancia do puzzle.
- **solXX.txt**: solución do puzzle.

## Execute

### 1. Xerar o arquivo instancia **ASP**:

Para convertir **domXX.txt** nun arquivo **domXX.lp** utilizando `encode.py`:

```bash
python encode.py domXX.txt domXX.lp
```

### 2. Resolver o puzzle con **Clingo**:

Executar `decode.py` para resolver o puzzle e xerar a solución:

```bash
python decode.py yinyangKB.lp domXX.lp solXX.txt
```
Este programa usa dous predicados: 
- `gridsize(N)` especifica o tamaño da cuadrícula \(N \times N\).
- `_drawcircle(X,Y,C)` imprime na fila \(X\) e na columna \(Y\) o número 1 se \(C = \text{black}\), e o 0 si \(C = \text{white}\).


### 3. Ver a solución:

Mostrar a saída gráficamente utilizando `display.py` y `drawyinyang.lp`:

```bash
python3 display.py yinyangKB.lp dom02.lp drawyinyang.lp
```
