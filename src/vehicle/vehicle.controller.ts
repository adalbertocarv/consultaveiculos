import { Controller, Get, Param } from '@nestjs/common';
import { VehicleService } from './vehicle.service';

@Controller('vehicle')
export class VehicleController {
  constructor(private readonly vehicleService: VehicleService) {}

  @Get(':placa')
  async getVehicleStatus(@Param('placa') placa: string): Promise<{ status: string }> {
    const status = await this.vehicleService.getVehicleStatus(placa);
    return { status };
  }
}
