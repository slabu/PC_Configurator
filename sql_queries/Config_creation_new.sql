USE HardWare



DELETE FROM dbo.configgg


INSERT INTO dbo.configgg(CPU_Name, CPU_Cores, CPU_Threads, CPU_Multithreading, CPU_Integrated_GPU, CPU_Unlocked_multiplier, CPU_TDP_W, Motherboard_name, CPU_Radiator_name, CPU_Radiator_TDP_W, Ram_Name, RAM_Amount_GB, RAM_Frequency_MHz, GPU_Name, GPU_Ram_GB, GPU_RTX_Support, GPU_Series, PSU_Name, PSU_Output_capacity_W, HDD_Name, HDD_Size_GB, SSD_Name, SSD_Type, SSD_Size, SSD_Read_Speed_MBpS, SSD_Write_Speed_MBpS, CPU_Price_UAH, CPU_Radiator_Price_UAH, Motherboard_Price_UAH, RAM_Price_UAH, GPU_Price_UAH, PSU_Price_UAH, HDD_Price_UAH, SSD_Price_UAH, Configuration_price)


SELECT  * FROM(
SELECT	cpu.CPU_Name,
		cpu.CPU_Cores,
		cpu.CPU_Threads,
		cpu.CPU_Multithreading,
		cpu.CPU_Intergrated_GPU,
		cpu.CPU_Unlocked_multiplier,
		cpu.CPU_TDP_W,
		mb.Motherboard_name, 
		cr.CPU_Radiator_Name,
		cr.CPU_Radiator_TDP_W, 
		ram.RAM_Name,
		ram.RAM_Amount_GB,
		ram.RAM_Frequency_MHz, 
		gpu.GPU_Name,
		gpu.GPU_Ram_GB,
		gpu.GPU_RTX_Support, 
		gpu.GPU_Series,
		psu.PSU_Name,
		psu.PSU_Output_capacity_W,
		hdd.HDD_Name,
		hdd.HDD_Size_GB,
		ssd.SSD_Name,
		ssd.SSD_Form_factor,
		ssd.SSD_Size_GB,
		ssd.SSD_Read_Speed_MBpS,
		ssd.SSD_Write_Speed_MBpS,
		
		--------------------PRICE------------------------------ 
		cpu.CPU_Price_UAH, 
		cr.CPU_Radiator_Price_UAH,
		mb.Motherboard_Price_UAH,
		ram.RAM_Price_UAH,
		gpu.GPU_Price_UAH,
		psu.PSU_Price_UAH,
		hdd.HDD_Price_UAH,
		ssd.SSD_Pirce_UAH,
		-------------------TOTAL PRICE-------------------------
		cpu.CPU_Price_UAH+
		cr.CPU_Radiator_Price_UAH+
		mb.Motherboard_Price_UAH+
		ram.RAM_Price_UAH+
		gpu.GPU_Price_UAH+
		psu.PSU_Price_UAH+
		hdd.HDD_Price_UAH+
		ssd.SSD_Pirce_UAH
		AS Configuration_price

FROM dbo.CPU AS cpu

JOIN dbo.Motherboard AS mb ON cpu.CPU_Socket = mb.Motherboard_Socket
JOIN dbo.RAM AS ram ON ram.RAM_Type = mb.Motherboard_Type_of_RAM
JOIN dbo.CPU_Radiator AS cr ON cpu.CPU_Socket LIKE CONCAT('%', mb.Motherboard_Socket, '%')
JOIN dbo.GPU AS gpu ON gpu.GPU_Name LIKE('%%')
JOIN dbo.PSU AS psu ON psu.PSU_Output_capacity_W > cpu.CPU_TDP_W+gpu.GPU_TDP_W+50+psu.PSU_Output_capacity_W*0.2
JOIN dbo.HDD AS hdd ON hdd.HDD_Name LIKE('%%')
JOIN dbo.SSD AS ssd ON mb.Motherboard_SSD_Type_Connection LIKE CONCAT('%', ssd.SSD_Form_factor, '%')

) A
EXCEPT
SELECT * FROM(
	SELECT	cpu.CPU_Name,
			cpu.CPU_Cores,
			cpu.CPU_Threads,
			cpu.CPU_Multithreading,
			cpu.CPU_Intergrated_GPU,
			cpu.CPU_Unlocked_multiplier,
			cpu.CPU_TDP_W,
			mb.Motherboard_name, 
			cr.CPU_Radiator_Name,
			cr.CPU_Radiator_TDP_W, 
			ram.RAM_Name,
			ram.RAM_Amount_GB,
			ram.RAM_Frequency_MHz, 
			gpu.GPU_Name,
			gpu.GPU_Ram_GB,
			gpu.GPU_RTX_Support, 
			gpu.GPU_Series,
			psu.PSU_Name,
			psu.PSU_Output_capacity_W,
			hdd.HDD_Name,
			hdd.HDD_Size_GB,
			ssd.SSD_Name,
			ssd.SSD_Form_factor,
			ssd.SSD_Size_GB,
			ssd.SSD_Read_Speed_MBpS,
			ssd.SSD_Write_Speed_MBpS,
		
			--------------------PRICE------------------------------ 
			cpu.CPU_Price_UAH, 
			cr.CPU_Radiator_Price_UAH,
			mb.Motherboard_Price_UAH,
			ram.RAM_Price_UAH,
			gpu.GPU_Price_UAH,
			psu.PSU_Price_UAH,
			hdd.HDD_Price_UAH,
			ssd.SSD_Pirce_UAH,
			-------------------TOTAL PRICE-------------------------
			cpu.CPU_Price_UAH+
			cr.CPU_Radiator_Price_UAH+
			mb.Motherboard_Price_UAH+
			ram.RAM_Price_UAH+
			gpu.GPU_Price_UAH+
			psu.PSU_Price_UAH+
			hdd.HDD_Price_UAH+
			ssd.SSD_Pirce_UAH
			AS Configuration_price

	FROM dbo.CPU AS cpu

	JOIN dbo.Motherboard AS mb ON cpu.CPU_Socket = mb.Motherboard_Socket
	JOIN dbo.RAM AS ram ON ram.RAM_Type = mb.Motherboard_Type_of_RAM
	JOIN dbo.CPU_Radiator AS cr ON cpu.CPU_Socket LIKE CONCAT('%', mb.Motherboard_Socket, '%')
	JOIN dbo.GPU AS gpu ON gpu.GPU_Name LIKE('%%')
	JOIN dbo.PSU AS psu ON psu.PSU_Output_capacity_W > cpu.CPU_TDP_W+gpu.GPU_TDP_W+50+psu.PSU_Output_capacity_W*0.2
	JOIN dbo.HDD AS hdd ON hdd.HDD_Name LIKE('%%')
	JOIN dbo.SSD AS ssd ON mb.Motherboard_SSD_Type_Connection LIKE CONCAT('%', ssd.SSD_Form_factor, '%')
	WHERE hdd.HDD_Price_UAH = 0 AND ssd.SSD_Pirce_UAH = 0
	) B