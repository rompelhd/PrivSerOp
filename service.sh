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

manage_service() {
  local action=$1
  local service=$2
  su -c "pm $action $service" 2>/dev/null
}

manage_advertising_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdService"
  manage_service $action "com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdNotificationService"
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.mediums.nearfieldcommunication.NfcAdvertisingService"
}

manage_analytics_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.analytics.service.AnalyticsService"
  manage_service $action "com.google.android.gms/com.google.android.gms.analytics.AnalyticsService"
  manage_service $action "com.google.android.gms/com.google.android.gms.analytics.AnalyticsTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService"
  manage_service $action "com.google.android.gms/com.google.android.gms.tron.CollectionService"
  manage_service $action "com.google.android.gms/com.google.android.gms.backup.stats.BackupStatsService"
  manage_service $action "com.google.android.gms/com.google.android.gms.stats.DropBoxEntryAddedService"
  manage_service $action "com.google.android.gms/com.google.android.gms.stats.eastworld.EastworldService"
  manage_service $action "com.google.android.gms/com.google.android.gms.common.stats.GmsCoreStatsService"
  manage_service $action "com.google.android.gms/com.google.android.gms.stats.PlatformStatsCollectorService"
  manage_service $action "com.google.android.gms/com.google.android.gms.common.stats.StatsUploadService"
  manage_service $action "com.google.android.gms/com.google.android.gms.checkin.CheckinApiService"
  manage_service $action "com.google.android.gms/com.google.android.gms.checkin.CheckinService"
  manage_service $action "com.google.android.gms/com.google.android.gms.common.config.PhenotypeCheckinService"
}

manage_ar_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.internal.server.HardwareArProviderService"
}

manage_bug_report_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.reporting.service.ReportingAndroidService"
  manage_service $action "com.google.android.gms/com.google.android.gms.locationsharingreporter.reporting.periodic.PeriodicReporterMonitoringService"
  manage_service $action "com.google.android.gms/com.google.android.gms.feedback.LegacyBugReportService"
  manage_service $action "com.google.android.gms/com.google.android.gms.common.stats.net.NetworkReportService"
  manage_service $action "com.google.android.gms/com.google.android.gms.feedback.OfflineReportSendTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.googlehelp.metrics.ReportBatchedMetricsGcmTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.reporting.service.ReportingSyncService"
  manage_service $action "com.google.android.gms/com.google.android.gms.usagereporting.service.UsageReportingIntentService"
  manage_service $action "com.google.android.gms/com.google.android.gms.feedback.FeedbackAsyncService"
}

manage_cast_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.service.CastPersistentService_Persistent"
  manage_service $action "com.google.android.gms/com.google.android.gms.chimera.CastPersistentBoundBrokerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService_Isolated"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRoute2ProviderService_Persistent"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService_Isolated"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastMediaRouteProviderService_Persistent"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService_Isolated"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.media.CastRemoteDisplayProviderService_Persistent"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService_Isolated"
  manage_service $action "com.google.android.gms/com.google.android.gms.cast.service.CastSocketMultiplexerLifeCycleService_Persistent"
}

manage_debug_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.clearcut.debug.ClearcutDebugDumpService"
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.messages.debug.DebugPokeService"
}

manage_discovery_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.discovery.service.DiscoveryService"
  manage_service $action "com.google.android.gms/com.google.android.gms.firebase.components.ComponentDiscoveryService"
  manage_service $action "com.google.android.gms/com.google.mlkit.common.internal.MlKitComponentDiscoveryService"
}

manage_logger_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService"
  manage_service $action "com.google.android.gms/com.google.android.gms.romanesco.ContactsLoggerUploadService"
  manage_service $action "com.google.android.gms/com.google.android.gms.magictether.logging.DailyMetricsLoggerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.checkin.EventLogService"
  manage_service $action "com.google.android.gms/com.google.android.gms.backup.component.FullBackupJobLoggerService"
}

manage_nearby_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.bootstrap.service.NearbyBootstrapService"
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.connection.service.NearbyConnectionsAndroidService"
  manage_service $action "com.google.android.gms/com.google.android.gms.location.nearby.direct.service.NearbyDirectService"
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.messages.service.NearbyMessagesService"
}

manage_security_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.droidguard.service.DroidGuardService"
  manage_service $action "com.google.android.gms/com.google.android.gms.droidguard.service.DroidGuardGcmTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.safebrowsing.SafeBrowsingUpdateTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.verifier.ApkUploadService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.verifier.InternalApkUploadService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.snet.SnetIdleTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.snet.SnetNormalTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.security.snet.SnetService"
  manage_service $action "com.google.android.gms/com.google.android.gms.pay.security.storagekey.service.StorageKeyCacheService"
  manage_service $action "com.google.android.gms/com.google.android.gms.tapandpay.security.StorageKeyCacheService"
}

manage_safety_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.thunderbird.service.EmergencyPersistentService"
  manage_service $action "com.google.android.gms/com.google.android.gms.thunderbird.service.EmergencyLocationService"
  manage_service $action "com.google.android.gms/com.google.android.gms.personalsafety.service.PersonalSafetyService"
  manage_service $action "com.google.android.gms/com.google.android.gms.kids.chimera.KidsServiceProxy"
}

manage_promotion_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.enpromo.service.PromoInternalPersistentService"
  manage_service $action "com.google.android.gms/com.google.android.gms.enpromo.service.PromoInternalService"
}

manage_trust_agent_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.auth.trustagent.GoogleTrustAgent"
  manage_service $action "com.google.android.gms/com.google.android.gms.trustagent.bridge.TrustAgentBridgeService"
  manage_service $action "com.google.android.gms/com.google.android.gms.trustagent.state.TrustAgentStateService"
}

manage_updater_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.instantapps.service.DomainFilterUpdateService"
  manage_service $action "com.google.android.gms/com.google.android.gms.auth.folsom.service.FolsomPublicKeyUpdateService"
  manage_service $action "com.google.android.gms/com.google.android.gms.icing.proxy.IcingInternalCorporaUpdateService"
  manage_service $action "com.google.android.gms/com.google.android.gms.phenotype.sync.service.PackageUpdateTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.mobiledataplan.service.PeriodicUpdaterService"
  manage_service $action "com.google.android.gms/com.google.android.gms.update.SystemUpdateGcmTaskService"
  manage_service $action "com.google.android.gms/com.google.android.gms.update.SystemUpdateService"
  manage_service $action "com.google.android.gms/com.google.android.gms.update.UpdateFromSdCardService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fonts.update.service.UpdateSchedulerService"
}

manage_wear_os_services() {
  local action=$1
  manage_service $action "com.google.android.gms/com.google.android.gms.dck.service.DckWearableListenerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.nearby.fastpair.service.WearableDataListenerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.wearable.service.WearableLocationService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fused.wearable.GmsWearableListenerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.mdm.services.MdmPhoneWearableListenerService"
  manage_service $action "com.google.android.gms/com.google.android.gms.tapandpay.wear.WearProxyService"
  manage_service $action "com.google.android.gms/com.google.android.gms.wearable.service.WearableControlService"
  manage_service $action "com.google.android.gms/com.google.android.gms.wearable.service.WearableService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncAccountService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncConfigService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncConnectionService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncMessageService"
  manage_service $action "com.google.android.gms/com.google.android.gms.fitness.wearable.service.WearableSyncService"
  manage_service $action "com.google.android.gms/com.google.android.gms.backup.wear.service.BackupSettingsListenerService"
}

manage_telemetry_services() {
  local action=$1
  manage_service $action "com.google.mainline.telemetry"
}

manage_oneplus_services() {
  local action=$1
  manage_service $action "com.oplus.wifitest"
  manage_service $action "com.oplus.nrMode" # If on 5G, do not deactivate; on 4G or 4G+, deactivate.
  manage_service $action "com.oplus.cast"
  manage_service $action "com.oplus.statistics.rom"
  manage_service $action "com.oplus.romupdate" # If your device has no further updates
  manage_service $action "com.oplus.ota" # Same as above, this process constantly checks for updates
  manage_service $action "com.oplus.ocs" # Haha, you have root you don't need official support
  manage_service $action "com.oplus.sau" # Auto update system, same as before
  manage_service $action "com.oplus.bttestmode"
  manage_service $action "com.oplus.opusermanual"
  manage_service $action "com.oneplus.account" # If you don't have a oneplus account
  manage_service $action "com.oneplus.opshelf"
  manage_service $action "com.qualcomm.qti.modemtestmode"
  manage_service $action "com.android.traceur"
  manage_service $action "com.google.android.apps.wellbeing"
  manage_service $action "com.oneplus.membership"
  manage_service $action "com.android.cts.priv.ctsshim"
  manage_service $action "com.android.cts.ctsshim"
  manage_service $action "com.oplus.interconnectcollectkit"
}

check_boot_status

action=${1:-disable}

manage_advertising_services $action
manage_analytics_services $action
manage_ar_services $action
manage_bug_report_services $action
manage_cast_services $action
manage_debug_services $action
manage_discovery_services $action
manage_logger_services $action
manage_nearby_services $action
manage_security_services $action
manage_safety_services $action
manage_promotion_services $action
manage_trust_agent_services $action
manage_updater_services $action
manage_wear_os_services $action
manage_telemetry_services $action
manage_oneplus_services $action

# Enable Google Account Fix (Keep enabled)
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.PersistentIntentOperationService_AuthAccountIsolated" 2>/dev/null
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.GmsIntentOperationService_AuthAccountIsolated com.google.android.gms/com.google.android.gms.chimera.GmsIntentOperationService_AuthAccountIsolated" 2>/dev/null
su -c "pm enable com.google.android.gms/com.google.android.gms.chimera.PersistentApiService_AuthAccountIsolated" 2>/dev/null

exit
