{
  config,
  lib,
  ...
}: {
  options = {
    programs.email.thunderbird.enable = lib.mkEnableOption "Enables the Thunderbrid email client with default config";
  };
  config = lib.mkIf config.programs.email.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles."default" = {
        isDefault = true;
        settings = {
          "calendar.timezone.local" = "America/Chicago";
          "calendar.timezone.useSystemTimezone" = true;
          "datareporting.healthreport.uploadEnabled" = false;
          "font.name.sans-serif.x-western" = "CaskaydiaCove NerdFont";
          "mail.incorporate.return_receipt" = 1;
          "mail.markAsReadOnSpam" = true;
          "mail.spam.logging.enabled" = true;
          "mail.spam.manualMark" = true;
          "offline.download.download_messages" = 1;
          "offline.send.unsent_messages" = 1;
        };
      };
    };
  };
}
