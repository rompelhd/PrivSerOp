#!/sbin/sh

check_boot_status() {
  BOOT_COMPLETED=false
  for i in {1..30}; do  # 30 * 10 s = 5 m
    BOOTMODE=$(getprop sys.boot_completed)
    if [ "$BOOTMODE" = "1" ]; then
      BOOT_COMPLETED=true
      break
    fi
    sleep 10
  done

  if [ "$BOOT_COMPLETED" != true ]; then
    exit 1
  fi
}

disable_service() {
    su -c "pm disable $1" 2>/dev/null
}

disable_advertising_services() {
    disable_service "com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdService"
    disable_service "com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdNotificationService"
    disable_service "com.google.android.gms/com.google.android.gms.nearby.mediums.nearfieldcommunication.NfcAdvertisingService"
}

disable_analytics_services() {
    disable_service "com.google.android.gms/com.google.android.gms.analytics.service.AnalyticsService"
    disable_service "com.google.android.gms/com.google.android.gms.analytics.AnalyticsService"
    disable_service "com.google.android.gms/com.google.android.gms.analytics.AnalyticsTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService"
    disable_service "com.google.android.gms/com.google.android.gms.tron.CollectionService"
    disable_service "com.google.android.gms/com.google.android.gms.backup.stats.BackupStatsService"
    disable_service "com.google.android.gms/com.google.android.gms.stats.DropBoxEntryAddedService"
    disable_service "com.google.android.gms/com.google.android.gms.stats.eastworld.EastworldService"
    disable_service "com.google.android.gms/com.google.android.gms.common.stats.GmsCoreStatsService"
    disable_service "com.google.android.gms/com.google.android.gms.stats.PlatformStatsCollectorService"
    disable_service "com.google.android.gms/com.google.android.gms.common.stats.StatsUploadService"
    disable_service "com.google.android.gms/com.google.android.gms.checkin.CheckinApiService"
    disable_service "com.google.android.gms/com.google.android.gms.checkin.CheckinService"
    disable_service "com.google.android.gms/com.google.android.gms.common.config.PhenotypeCheckinService"
}

disable_ar_services() {
    disable_service "com.google.android.gms/com.google.android.gms.internal.server.HardwareArProviderService"
}

disable_bug_report_services() {
    disable_service "com.google.android.gms/com.google.android.gms.reporting.service.ReportingAndroidService"
    disable_service "com.google.android.gms/com.google.android.gms.locationsharingreporter.reporting.periodic.PeriodicReporterMonitoringService"
    disable_service "com.google.android.gms/com.google.android.gms.feedback.LegacyBugReportService"
    disable_service "com.google.android.gms/com.google.android.gms.common.stats.net.NetworkReportService"
    disable_service "com.google.android.gms/com.google.android.gms.feedback.OfflineReportSendTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.googlehelp.metrics.ReportBatchedMetricsGcmTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.reporting.service.ReportingSyncService"
    disable_service "com.google.android.gms/com.google.android.gms.usagereporting.service.UsageReportingIntentService"
    disable_service "com.google.android.gms/com.google.android.gms.feedback.FeedbackAsyncService"
}

disable_cast_services() {
    disable_service "com.google.android.gms/com.google.android.gms.cast.service.CastPersistentService_Persistent"
    disable_service "com.google.android.gms/com.google.android.gms.chimera.CastPersistentBoundBrokerService"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService_Isolated"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService_Persistent"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService_Isolated"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService_Persistent"                          disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService_Isolated"
    disable_service "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService_Persistent"
    disable_service "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService"
    disable_service "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService_Isolated"
    disable_service "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService_Persistent"
}

disable_debug_services() {
    disable_service "com.google.android.gms/com.google.android.gms.clearcut.debug.ClearcutDebugDumpService"
    disable_service "com.google.android.gms/com.google.android.gms.nearby.messages.debug.DebugPokeService"
}

disable_discovery_services() {
    disable_service "com.google.android.gms/com.google.android.gms.nearby.discovery.service.DiscoveryService"
    disable_service "com.google.android.gms/com.google.android.gms.firebase.components.ComponentDiscoveryService"
    disable_service "com.google.android.gms/com.google.mlkit.common.internal.MlKitComponentDiscoveryService"
}

disable_logger_services() {                                                                                                                      disable_service "com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService"
    disable_service "com.google.android.gms/com.google.android.gms.romanesco.ContactsLoggerUploadService"
    disable_service "com.google.android.gms/com.google.android.gms.magictether.logging.DailyMetricsLoggerService"
    disable_service "com.google.android.gms/com.google.android.gms.checkin.EventLogService"
    disable_service "com.google.android.gms/com.google.android.gms.backup.component.FullBackupJobLoggerService"
}

disable_nearby_services() {
    disable_service "com.google.android.gms/com.google.android.gms.nearby.bootstrap.service.NearbyBootstrapService"
    disable_service "com.google.android.gms/com.google.android.gms.nearby.connection.service.NearbyConnectionsAndroidService"
    disable_service "com.google.android.gms/com.google.android.gms.location.nearby.direct.service.NearbyDirectService"
    disable_service "com.google.android.gms/com.google.android.gms.nearby.messages.service.NearbyMessagesService"
}

disable_security_services() {
    disable_service "com.google.android.gms/com.google.android.gms.droidguard.service.DroidGuardService"
    disable_service "com.google.android.gms/com.google.android.gms.droidguard.service.DroidGuardGcmTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.security.safebrowsing.SafeBrowsingUpdateTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.security.verifier.ApkUploadService"
    disable_service "com.google.android.gms/com.google.android.gms.security.verifier.InternalApkUploadService"
    disable_service "com.google.android.gms/com.google.android.gms.security.snet.SnetIdleTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.security.snet.SnetNormalTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.security.snet.SnetService"
    disable_service "com.google.android.gms/com.google.android.gms.pay.security.storagekey.service.StorageKeyCacheService"
    disable_service "com.google.android.gms/com.google.android.gms.tapandpay.security.StorageKeyCacheService"
}

disable_safety_services() {
    disable_service "com.google.android.gms/com.google.android.gms.thunderbird.service.EmergencyPersistentService"
    disable_service "com.google.android.gms/com.google.android.gms.thunderbird.service.EmergencyLocationService"                                 disable_service "com.google.android.gms/com.google.android.gms.personalsafety.service.PersonalSafetyService"
    disable_service "com.google.android.gms/com.google.android.gms.kids.chimera.KidsServiceProxy"
}

disable_promotion_services() {
    disable_service "com.google.android.gms/com.google.android.gms.enpromo.service.PromoInternalPersistentService"
    disable_service "com.google.android.gms/com.google.android.gms.enpromo.service.PromoInternalService"
}

disable_trust_agent_services() {
    disable_service "com.google.android.gms/com.google.android.gms.auth.trustagent.GoogleTrustAgent"
    disable_service "com.google.android.gms/com.google.android.gms.trustagent.bridge.TrustAgentBridgeService"
    disable_service "com.google.android.gms/com.google.android.gms.trustagent.state.TrustAgentStateService"
}

disable_updater_services() {
    disable_service "com.google.android.gms/com.google.android.gms.instantapps.service.DomainFilterUpdateService"                                disable_service "com.google.android.gms/com.google.android.gms.auth.folsom.service.FolsomPublicKeyUpdateService"
    disable_service "com.google.android.gms/com.google.android.gms.icing.proxy.IcingInternalCorporaUpdateService"
    disable_service "com.google.android.gms/com.google.android.gms.phenotype.sync.service.PackageUpdateTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.mobiledataplan.service.PeriodicUpdaterService"
    disable_service "com.google.android.gms/com.google.android.gms.update.SystemUpdateGcmTaskService"
    disable_service "com.google.android.gms/com.google.android.gms.update.SystemUpdateService"
    disable_service "com.google.android.gms/com.google.android.gms.update.UpdateFromSdCardService"
    disable_service "com.google.android.gms/com.google.android.gms.fonts.update.service.UpdateSchedulerService"
}

disable_wear_os_services() {
    disable_service "com.google.android.gms/com.google.android.gms.dck.service.DckWearableListenerService"
    disable_service "com.google.android.gms/com.google.android.gms.nearby.fastpair.service.WearableDataListenerService"
    disable_service "com.google.android.gms/com.google.android.gms.wearable.service.WearableLocationService"
    disable_service "com.google.android.gms/com.google.android.gms.fused.wearable.GmsWearableListenerService"
    disable_service "com.google.android.gms/com.google.android.gms.mdm.services.MdmPhoneWearableListenerService"
    disable_service "com.google.android.gms/com.google.android.gms.tapandpay.wear.WearProxyService"
    disable_service "com.google.android.gms/com.google.android.gms.wearable.service.WearableControlService"                                      disable_service "com.google.android.gms/com.google.android.gms.wearable.service.WearableService"
    disable_service "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncAccountService"
    disable_service "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncConfigService"
    disable_service "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncConnectionService"
    disable_service "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncMessageService"
    disable_service "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncService"
    disable_service "com.google.android.gms/com.google.android.gms.backup.wear.service.BackupSettingsListenerService"
}

disable_telemetry_services() {
    disable_service "com.google.mainline.telemetry"
}

disable_oneplus_services() {
    disable_service "com.oplus.wifitest"
    disable_service "com.oplus.nrMode" # If on 5G, do not deactivate; on 4G or 4G+, deactivate.
    disable_service "com.oplus.cast"                                                                                                             disable_service "com.oplus.statistics.rom"
    disable_service "com.oplus.romupdate" # If your device has no further updates
    disable_service "com.oplus.ota" # Same as above, this process constantly checks for updates
    disable_service "com.oplus.ocs" # Haha, you have root you don't need official support
    disable_service "com.oplus.sau" # Auto update system, same as before
    disable_service "com.oplus.bttestmode"
    disable_service "com.oplus.opusermanual"
    disable_service "com.oneplus.account" # If you don't have a oneplus account
}

check_boot_status

disable_advertising_services
disable_analytics_services
disable_ar_services
disable_bug_report_services
disable_cast_services
disable_debug_services
disable_discovery_services
disable_logger_services                                                                                                                      disable_nearby_services
disable_security_services
disable_safety_services
disable_promotion_services
disable_trust_agent_services
disable_updater_services
disable_wear_os_services
disable_telemetry_services
disable_oneplus_services

# Enable Google Account Fix (Keep enabled)
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.PersistentIntentOperationService_AuthAccountIsolated" 2>/dev/null
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.GmsIntentOperationService_AuthAccountIsolated com.google.android.gms/com.google.android.gms.chimera.GmsIntentOperationService_AuthAccountIsolated" 2>/dev/null
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.PersistentApiService_AuthAccountIsolated" 2>/dev/null

exit
