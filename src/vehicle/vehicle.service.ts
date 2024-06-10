import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicle } from './vehicle.entity';

@Injectable()
export class VehicleService {
  private readonly logger = new Logger(VehicleService.name);
  constructor(
    @InjectRepository(Vehicle)
    private readonly vehicleRepository: Repository<Vehicle>,
  ) {
    this.logger.log('VehicleService initialized');
  }

  async getVehicleStatus(placa: string): Promise<string> {
    this.logger.log(`Querying status for vehicle with plate: ${placa}`);
    try {
      const result = await this.vehicleRepository.query(
        'SELECT * FROM cco2.public.tb_veiculo WHERE TRIM(placa) LIKE TRIM($1)',
        [placa.trim()],
      );
      this.logger.log(`Query result: ${JSON.stringify(result)}`);

      if (result.length > 0) {
        const vehicle = result[0];
        const valorBooleano = vehicle.ativo; // Acessar o campo ativo corretamente
        this.logger.log(`Vehicle status: ${valorBooleano}`);
        return valorBooleano ? 'Ativo' : 'Inativo';
      }
      this.logger.log('Vehicle not found');
      return 'Veículo não encontrado';
    } catch (error) {
      this.logger.error('Error querying vehicle status', error.stack);
      return 'Erro ao consultar o banco de dados';
    }
  }
}
