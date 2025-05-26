# ================================================
# FILE: README.md
# ================================================
# Infraestructura AWS con Terraform

Esta infraestructura despliega una aplicación web completa en AWS usando Terraform, incluyendo:

- **Red (VPC)**: VPC con subnets públicas y privadas
- **Seguridad**: Security Groups configurados para cada componente
- **Cómputo**: Instancias EC2 para frontend y backend
- **Base de Datos**: RDS SQL Server en subnets privadas
- **Almacenamiento**: Bucket S3 con acceso IAM

## Arquitectura

```
Internet
    |
Internet Gateway
    |
Public Subnets (Frontend & Backend EC2)
    |
Private Subnets (RDS)
    |
S3 Bucket (archivos/assets)
```

## Prerrequisitos

1. **AWS CLI configurado** con credenciales válidas
2. **Terraform >= 1.3.0** instalado
3. **Par de llaves SSH** creado en AWS
4. **GitHub Personal Access Token** para repos privados

## Configuración

1. **Clonar el repositorio y configurar variables:**
```bash
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars con tus valores
```

2. **Crear el par de llaves SSH en AWS:**
```bash
aws ec2 create-key-pair --key-name mi-key-pair --query 'KeyMaterial' --output text > mi-key-pair.pem
chmod 400 mi-key-pair.pem
```

3. **Inicializar y aplicar Terraform:**
```bash
terraform init
terraform plan
terraform apply
```

## Variables Importantes

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `key_pair_name` | Nombre del key pair SSH | `"mi-key-pair"` |
| `github_token` | Token de GitHub | `"ghp_xxxxxxxx"` |
| `github_org` | Organización GitHub | `"mi-empresa"` |
| `bucket_name` | Nombre único del bucket S3 | `"mi-app-bucket-12345"` |
| `db_password` | Contraseña de RDS | `"MiPasswordSeguro123!"` |

## Estructura del Proyecto

```
.
├── main.tf                 # Configuración principal
├── variables.tf            # Variables del root module
├── outputs.tf             # Outputs del root module
├── terraform.tfvars       # Valores de variables (no incluir en git)
├── modules/
│   ├── network/           # Módulo de red (VPC, subnets)
│   ├── security/          # Módulo de seguridad (Security Groups)
│   ├── compute/           # Módulo de cómputo (EC2)
│   ├── rds/              # Módulo de base de datos
│   └── s3/               # Módulo de almacenamiento
└── README.md
```

## Outputs

Después del despliegue, obtendrás:

- `frontend_public_ip`: IP pública del servidor frontend
- `backend_public_ip`: IP pública del servidor backend  
- `rds_endpoint`: Endpoint de la base de datos
- `s3_bucket_name`: Nombre del bucket S3

## Acceso a los Servidores

```bash
# Frontend
ssh -i mi-key-pair.pem ec2-user@<frontend_public_ip>

# Backend  
ssh -i mi-key-pair.pem ec2-user@<backend_public_ip>
```

## Personalización de User Data

Los scripts de inicialización están en:
- `modules/compute/user_data_frontend.sh`
- `modules/compute/user_data_backend.sh`

Puedes modificarlos según las necesidades de tu aplicación.

## Limpieza

Para destruir toda la infraestructura:
```bash
terraform destroy
```

## Seguridad

- RDS está en subnets privadas (no accesible desde internet)
- Security Groups configurados con mínimos permisos necesarios
- Bucket S3 con acceso restringido y cifrado habilitado
- IAM roles con permisos específicos para S3

## Troubleshooting

### Error: Key pair no encontrado
```bash
aws ec2 describe-key-pairs --key-names tu-key-pair-name
```

### Error: Bucket name ya existe
Cambiar `bucket_name` en `terraform.tfvars` por un nombre único.

### Logs de User Data
```bash
# En las instancias EC2
sudo tail -f /var/log/user-data.log
```

## Mejoras Sugeridas

1. **Usar Remote State Backend** (S3 + DynamoDB)
2. **Implementar HTTPS** con certificados SSL/TLS
3. **Agregar Load Balancer** para alta disponibilidad
4. **Configurar Auto Scaling Groups**
5. **Implementar monitoring** con CloudWatch
6. **Usar Secrets Manager** para contraseñas
7. **Configurar backups automáticos**