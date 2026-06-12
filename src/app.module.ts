import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { SitesModule } from './sites/sites.module';
import { AnalyticsModule } from './analytics/analytics.module';
import { TrackingModule } from './tracking/tracking.module';
import { BillingModule } from './billing/billing.module';
import { JobsModule } from './jobs/jobs.module';

@Module({
  imports: [AuthModule, UsersModule, SitesModule, AnalyticsModule, TrackingModule, BillingModule, JobsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
