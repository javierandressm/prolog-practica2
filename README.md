
LINK VIDEO: https://youtu.be/CmW4AxYOprE

Sistema de Gestión de Ventas de Vehículos (Prolog)
📌 Descripción
Sistema en Prolog para gestión de inventario vehicular con consultas por marca, tipo y presupuesto.

Práctica II - Lenguajes y Paradigmas de Programación - Universidad EAFIT

👥 Integrantes
Javier Andrés Sierra Machado

Sebastián Roldán Giraldo

Miguel Ángel Álvarez Orozco

⚙️ Predicados Principales
under_budget/4 - Vehículos dentro de presupuesto

vehicles_by_brand/2 - Vehículos por marca

report_brand_type/1 - Reporte por marca/tipo

case1/1, case2/1, case3/1 - Casos de prueba

🧪 Ejemplos de Uso
prolog
% SUVs Toyota < $30,000
?- case1(R).
R = [land_cruiser].

% Sedanes total < $500,000  
?- case3(R).
R = ([(toyota,corolla,2500), (bmw,2002,4000), ...], 13800).
🛠️ Herramientas
Editor: IntelliJ IDEA

Asistentes: ChatGPT & BlackBox AI
