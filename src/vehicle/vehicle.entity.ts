import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('tb_veiculo', { schema: 'public' })
export class Vehicle {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  placa: string;

  @Column()
  ativo: boolean;

  // Adicione outras colunas conforme necessário
}
