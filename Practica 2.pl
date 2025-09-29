
% Inventario por marcas

vehicle(toyota, corolla, sedan, 2500, 1974).
vehicle(toyota, land_cruiser, suv, 3800, 1978).
vehicle(ford, mustang, sport, 3600, 1971).
vehicle(ford, f100, pickup, 3200, 1975).
vehicle(bmw, 2002, sedan, 4000, 1973).
vehicle(bmw, 528, sedan, 5200, 1976).
vehicle(honda, civic, hatchback, 2300, 1977).
vehicle(chevrolet, c10, pickup, 3100, 1972).
vehicle(kia, brisa, sedan, 2100, 1976).
vehicle(mazda, rx3, coupe, 2700, 1979).

% Vehículos de bajo presupuesto (<= Budget)

toyota_under_budget(Type, Budget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(toyota, Ref, Type, Price, Year), Price =< Budget),
            Result).

ford_under_budget(Type, Budget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(ford, Ref, Type, Price, Year), Price =< Budget),
            Result).

bmw_under_budget(Type, Budget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(bmw, Ref, Type, Price, Year), Price =< Budget),
            Result).

chevrolet_under_budget(Type, Budget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(chevrolet, Ref, Type, Price, Year), Price =< Budget),
            Result).


% Vehículos de alto presupuesto (>= MinBudget)

toyota_over_budget(Type, MinBudget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(toyota, Ref, Type, Price, Year), Price >= MinBudget),
            Result).

ford_over_budget(Type, MinBudget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(ford, Ref, Type, Price, Year), Price >= MinBudget),
            Result).

bmw_over_budget(Type, MinBudget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(bmw, Ref, Type, Price, Year), Price >= MinBudget),
            Result).

chevrolet_over_budget(Type, MinBudget, Result) :-
    findall((Ref, Price, Year),
            (vehicle(chevrolet, Ref, Type, Price, Year), Price >= MinBudget),
            Result).


% Vehículos de una marca específica

vehicles_by_brand(Brand, Result) :-
    findall((Ref, Type, Price, Year),
            vehicle(Brand, Ref, Type, Price, Year),
            Result).

% Vehículos por tipo con límite de precio
vehicles_by_type_under_budget(Type, Budget, Result) :-
    findall((Brand, Ref, Price),
            (vehicle(Brand, Ref, Type, Price, _), Price =< Budget),
            Result).


% Reporte agrupado por marca y tipo
report_brand_type(Inventory) :-
    bagof((Brand, Type, Ref),
          vehicle(Brand, Ref, Type, _, _),
          Inventory).

% Reporte agrupado por marca y año
report_brand_year(Inventory) :-
    bagof((Brand, Year, Ref),
          vehicle(Brand, Ref, _, _, Year),
          Inventory).


% Utilidad: suma de precios

sum_prices([], 0).
sum_prices([(_,_,Price)|T], Total) :-
    sum_prices(T, Subtotal),
    Total is Price + Subtotal.

% Reporte por tipo con presupuesto máximo total
report_type_budget(Type, Budget, (Vehicles, Total)) :-
    findall((Brand, Ref, Price),
            (vehicle(Brand, Ref, Type, Price, _), Price =< Budget),
            Vehicles),
    sum_prices(Vehicles, Total).

% Predicado meet_budget que pide el enunciado
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

% Predicado generate_report que pide el enunciado
generate_report(Brand, Type, Budget, (Vehicles, TotalValue)) :-
    findall((Brand, Ref, Price, Year),
            (vehicle(Brand, Ref, Type, Price, Year),
             Price =< Budget),
            Vehicles),
    sum_prices(Vehicles, TotalValue),
    TotalValue =< 1000000.


% CASOS DE PRUEBA


% Caso 1: Listar todos los SUVs Toyota menores a $30,000
case1(Result) :-
    findall(Ref,
           (vehicle(toyota, Ref, suv, Price, _), Price < 30000),
           Result).

% Caso 2: Mostrar vehículos Ford usando bagof/3, agrupados por tipo y año
case2(Result) :-
    bagof((Type, Year, Ref),
          vehicle(ford, Ref, Type, _, Year),
          Result).

% Caso 3: Calcular el total de sedanes sin exceder $500,000
case3((Vehicles, Total)) :-
    report_type_budget(sedan, 500000, (Vehicles, Total)).



