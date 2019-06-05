Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3134E36315
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 20:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFESFV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 14:05:21 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40604 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFESFV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jun 2019 14:05:21 -0400
Received: by mail-qk1-f202.google.com with SMTP id n5so7232226qkf.7
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+LvoH0vaLRnePydTNhqA6OqqBmdGXoMJcCKR6797hFQ=;
        b=GI/SWdiSaQbOR4mrG9Kg3VbxJ6uZytM7SVpwZzfdTlrqCQ8aLY+Rs1DQ7XcvOYK3uY
         tIupQWgSBvUjITwvIBMA8PxuPqfQp7Vf1e7aWqlFXWIT6D9zUyc86Xpv9+HBv9hRKACz
         X1gE4ocEV5whME9fTRKeAfyquH+G5doLzRI9PNhWI7VgVWVRARFA3rGxLFETBIh/ewHI
         0pwxn47kUxBRAImPDcretyZFTAgfU4W2lv51nnEWlml9V7RilkVrZBkIpfEROWHry2T4
         uq3KZLfdFKuLj102ngL9JvRzzmZy4TBHbLFHhpF4/f0An8QFTPfPrLS9n3hDt6nsa7MQ
         ME9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+LvoH0vaLRnePydTNhqA6OqqBmdGXoMJcCKR6797hFQ=;
        b=BIysOpoGnM7960tL9r777B51xZDCmwaU38GVdzMtTmufFwu8iekb8R7m4nXqkOfBLX
         XHLa+qTUQWUSLHnSGF1r8yyXsGiB4fAckEtM1c1GztQHKMQPiBvE4eE8WcGwMEvBn8VW
         hCAXqMUMWXLyoBYOnVxwy6Y5JVHRFaJspBT/nY5Tasv0nkeGc6f6G05o0NRGjTZVufzP
         Cf3IyeHfOk96IJAnD5+033ZvzjRx1G3UDH8OskuhvIfOJbmM96w6+gWhPjf6cWEsL1F+
         UWEiMvAP2SlLdks9uOvgp4vju7ByDNQ4ePYMDhzn4t38AqJSvL9gjEflh1pgQxwANcnR
         mvFg==
X-Gm-Message-State: APjAAAX7lAqn8G3BTpXWziIWwt6hNbX1AgwlucPfbiVWn92izlY67iUB
        9MsLJrup1m1Mzp4yTogGDqUIiIRvfUOWZVZyAiFGCg==
X-Google-Smtp-Source: APXvYqyksZIhrUJc38DSHALKwApuiScIJLZgzn8zqF/heWaHISO0px+6Y2KLEBPpVEP+3vGfiJugqEMdiBQGmJ2gPaU+/w==
X-Received: by 2002:a0c:d78c:: with SMTP id z12mr1336627qvi.244.1559757918947;
 Wed, 05 Jun 2019 11:05:18 -0700 (PDT)
Date:   Wed,  5 Jun 2019 11:05:15 -0700
Message-Id: <20190605180515.25326-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH V2] tpm: Don't duplicate events from the final event log in
 the TCG2 log
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Joe Richey <joerichey@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After the first call to GetEventLog() on UEFI systems using the TCG2
crypto agile log format, any further log events (other than those
triggered by ExitBootServices()) will be logged in both the main log and
also in the Final Events Log. While the kernel only calls GetEventLog()
immediately before ExitBootServices(), we can't control whether earlier
parts of the boot process have done so. This will result in log entries
that exist in both logs, and so the current approach of simply appending
the Final Event Log to the main log will result in events being
duplicated.

We can avoid this problem by looking at the size of the Final Event Log
just before we call ExitBootServices() and exporting this to the main
kernel. The kernel can then skip over all events that occured before
ExitBootServices() and only append events that were not also logged to
the main log.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reported-by: Joe Richey <joerichey@google.com>
Suggested-by: Joe Richey <joerichey@google.com>
---

Unmodified other than changing the name of final_events_early_size to
final_events_preboot_size.

 drivers/char/tpm/eventlog/efi.c               | 11 ++++++-
 .../firmware/efi/libstub/efi-stub-helper.c    | 15 ++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  2 ++
 drivers/firmware/efi/libstub/fdt.c            | 27 ++++++-----------
 drivers/firmware/efi/libstub/tpm.c            | 30 +++++++++++++++++++
 drivers/firmware/efi/tpm.c                    |  2 +-
 include/linux/efi.h                           |  1 +
 7 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 9179cf6bdee9..be6540f2cb3d 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -80,6 +80,8 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 		goto out;
 	}
 
+	efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;
+
 	tmp = krealloc(log->bios_event_log,
 		       log_size + efi_tpm_final_log_size,
 		       GFP_KERNEL);
@@ -90,8 +92,15 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	log->bios_event_log = tmp;
+
+	/*
+	 * Copy any of the final events log that didn't also end up in the
+	 * main log. Events can be logged in both if events are generated
+	 * between GetEventLog() and ExitBootServices().
+	 */
 	memcpy((void *)log->bios_event_log + log_size,
-	       final_tbl->events, efi_tpm_final_log_size);
+	       final_tbl->events + log_tbl->final_events_preboot_size,
+	       efi_tpm_final_log_size);
 	log->bios_event_log_end = log->bios_event_log +
 		log_size + efi_tpm_final_log_size;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e4610e72b78f..1db780c0f07b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -926,3 +926,18 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 fail:
 	return status;
 }
+
+void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
+{
+	efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
+	int i;
+
+	for (i = 0; i < sys_table->nr_tables; i++) {
+		if (efi_guidcmp(tables[i].guid, guid) != 0)
+			continue;
+
+		return (void *)tables[i].table;
+	}
+
+	return NULL;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 1b1dfcaa6fb9..7f1556fd867d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -65,6 +65,8 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
 
 efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
 
+void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
+
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
 #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 5440ba17a1c5..0bf0190917e0 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -363,26 +363,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 
 void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
-	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
-	efi_config_table_t *tables;
-	int i;
+	void *fdt;
 
-	tables = (efi_config_table_t *)sys_table->tables;
+	fdt = get_efi_config_table(sys_table, DEVICE_TREE_GUID);
 
-	for (i = 0; i < sys_table->nr_tables; i++) {
-		void *fdt;
+	if (!fdt)
+		return NULL;
 
-		if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
-			continue;
-
-		fdt = (void *)tables[i].table;
-		if (fdt_check_header(fdt) != 0) {
-			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
-			return NULL;
-		}
-		*fdt_size = fdt_totalsize(fdt);
-		return fdt;
+	if (fdt_check_header(fdt) != 0) {
+		pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+		return NULL;
 	}
-
-	return NULL;
+	*fdt_size = fdt_totalsize(fdt);
+	return fdt;
 }
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 6b3b507a54eb..6c900ba38ab1 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -64,11 +64,13 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 	efi_status_t status;
 	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
+	struct efi_tcg2_final_events_table *final_events_table;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
 	int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	void *tcg2_protocol = NULL;
+	int final_events_size = 0;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
 				&tcg2_protocol);
@@ -134,8 +136,36 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 		return;
 	}
 
+	/*
+	 * Figure out whether any events have already been logged to the
+	 * final events structure, and if so how much space they take up
+	 */
+	final_events_table = get_efi_config_table(sys_table_arg,
+						LINUX_EFI_TPM_FINAL_LOG_GUID);
+	if (final_events_table && final_events_table->nr_events) {
+		struct tcg_pcr_event2_head *header;
+		int offset;
+		void *data;
+		int event_size;
+		int i = final_events_table->nr_events;
+
+		data = (void *)final_events_table;
+		offset = sizeof(final_events_table->version) +
+			sizeof(final_events_table->nr_events);
+
+		while (i) {
+			header = data + offset + final_events_size;
+			event_size = __calc_tpm2_event_size(header,
+						   (void *)(long)log_location,
+						   false);
+			final_events_size += event_size;
+			i--;
+		}
+	}
+
 	memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
 	log_tbl->size = log_size;
+	log_tbl->final_events_preboot_size = final_events_size;
 	log_tbl->version = version;
 	memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
 
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 2c912ea08166..0bdceb5913aa 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -76,7 +76,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
+	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
 					    + sizeof(final_tbl->version)
 					    + sizeof(final_tbl->nr_events),
 					    final_tbl->nr_events,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e33c70a52a9d..2a26004a9bdb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1703,6 +1703,7 @@ struct linux_efi_random_seed {
 
 struct linux_efi_tpm_eventlog {
 	u32	size;
+	u32	final_events_preboot_size;
 	u8	version;
 	u8	log[];
 };
-- 
2.22.0.rc1.311.g5d7573a151-goog

