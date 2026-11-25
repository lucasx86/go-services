# GO Services! — Flutter / Dart

Protótipo navegável inspirado nas cinco telas fornecidas e no DRS versão 1.0.

## Requisitos
- Flutter SDK e Dart instalados
- Android Studio ou VS Code com extensão Flutter

## Executar
Na pasta do projeto, execute:

```bash
flutter create . --platforms=android,ios,web
flutter pub get
flutter run
```

O comando `flutter create .` gera os arquivos nativos ausentes sem substituir o código em `lib/main.dart`.

## O que funciona neste protótipo
- Navegação por login, cadastro demonstrativo, início, perfil profissional, solicitação, pedidos, favoritos e painel do prestador.
- Busca e filtro de profissionais fictícios.
- Formulário de solicitação com validação básica.
- Aceitação e conclusão de solicitações em memória.
- Visual alinhado às referências de cores azul/verde.

## Limitações importantes
Este é um **MVP visual e local**. Login não autentica de verdade; dados são fictícios e se perdem ao reiniciar; a localização e as distâncias são ilustrativas. Ainda não existem banco de dados, GPS, comunicação entre dispositivos, avaliações reais, notificações ou proteção de dados de produção.

## Próxima etapa sugerida
Integrar Firebase ou Supabase para autenticação e banco, geolocator para localização autorizada, regras de acesso cliente/prestador, sistema real de pedidos e avaliações vinculadas a atendimentos concluídos.
