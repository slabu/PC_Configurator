USE HardWare
SELECT	a.CPU_Price_UAH, a.CPU_Radiator_Price_UAH, a.GPU_Price_UAH, a.HDD_Price_UAH, a.SSD_Pirce_UAH, a.RAM_Price_UAH, psu.PSU_Price_UAH,
		a.CPU_Price_UAH+a.CPU_Radiator_Price_UAH+a.GPU_Price_UAH+a.Motherboard_Price_UAH+a.HDD_Price_UAH+a.SSD_Pirce_UAH+a.RAM_Price_UAH+psu.PSU_Price_UAH AS Price
		

FROM(
SELECT	cpu.CPU_Name,
		cpu.CPU_Cores,
		cpu.CPU_Threads, 
		cpu.CPU_Multithreading, 
		cpu.CPU_Intergrated_GPU,
		mb.Motherboard_name, 
		ram.RAM_Name, 
		ram.RAM_Frequency_MHz,
		ram.RAM_Range, -- don't include
		cr.CPU_Radiator_Name, 
		gpu.GPU_Name,
		gpu.GPU_Ram_GB,
		gpu.GPU_RTX_Support,
		gpu.GPU_Series,
		cpu.CPU_TDP_W+gpu.GPU_TDP_W+50 AS POW, 
		hdd.HDD_Name,
		hdd.HDD_Size_GB,
		ssd.SSD_Name,
		ssd.SSD_Form_factor,
		ssd.SSD_Size_GB,
		cpu.CPU_Price_UAH,
		gpu.GPU_Price_UAH,
		ram.RAM_Price_UAH,
		cr.CPU_Radiator_Price_UAH,
		mb.Motherboard_Price_UAH,
		hdd.HDD_Price_UAH,
		ssd.SSD_Pirce_UAH

		
		
FROM dbo.CPU AS cpu

JOIN dbo.Motherboard AS mb ON cpu.CPU_Socket = mb.Motherboard_Socket
JOIN dbo.RAM AS ram ON mb.Motherboard_Type_of_RAM = ram.RAM_Type
JOIN dbo.CPU_Radiator AS cr ON cr.CPU_Radiator_Socket LIKE CONCAT('%', mb.Motherboard_Socket, '%')
JOIN dbo.GPU AS gpu ON gpu.GPU_Name LIKE('%%')
JOIN dbo.HDD AS hdd ON hdd.HDD_Name LIKE('%%')
JOIN dbo.SSD AS ssd ON ssd.SSD_Name LIKE('%%')
) AS a
JOIN dbo.PSU AS psu ON psu.PSU_Output_capacity_W > a.POW+psu.PSU_Output_capacity_W*0.2
--WHERE a.HDD_Name = 'None' AND a.SSD_Name = 'None'



SELECT cpu.CPU_Name, mb.Motherboard_name
FROM dbo.CPU AS cpu
JOIN dbo.Motherboard AS mb ON cpu.CPU_Socket = mb.Motherboard_Socket