Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95F39714
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 22:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfFGUwI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 16:52:08 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45395 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfFGUwI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 16:52:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id s3so2178072pgv.12
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6pLYyhqQeuj0nfWPWmquK23yXvqtHKTh9c3OL20t7TU=;
        b=K+gicTh9STX7n0eBpP62LfAZKCIGfzW7hWLmg3hap4oYgXETFCRjP2eUQBqWGvhr/Y
         DubIzlkwCayAMYRdpZUgSDlvaw3wV3YtAj1ipL9RCiniZ7pj7jpf++6dPNL3uTHaYusY
         mkzGSWGZaovDPTGhSxYVhSN6GnYawqamKAp7t8jivW2ZxveW55pKlTSQSTsprvOIiUWw
         C2edFgu074EB7S/ztVWi78P4HEWsuru/ZYGtbko1xlR0k8/NkDtj5PxShnahLzWZjwKM
         kI6z0NYpVfw6bNpeEf/OeM8Chhzm3Y2L0NbhWgOCQcw7/akdDF841uyqESnznOJh3nah
         FSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6pLYyhqQeuj0nfWPWmquK23yXvqtHKTh9c3OL20t7TU=;
        b=QOBjpln4FvTFm6TR5ClN+hl//AtqwzI650SCnXBqXiWUTK/4sIjQN4uZp0FiYgpmrH
         C6bAqmV9eJV6dHJtZu/PTjCy2k6x38qAn7wTirucMnwjHAqLVA1ImqAIly8KGXJcD/rp
         /D9KTxIZxpzYPh7Qo2Mo4tUqUJehbLB4C8qRtmHKyDhsKsgDi2MVO89GkRs5nXMuwAL1
         fyoZpVmCdIVfTd7uh2tTan1y2YBbRZY1tRAzxuGgmuyUzZ2P0gZOX8OOnJMk0fzWumrI
         RRSUZG/85QjyvgPUFJoJJgTWHYEQMx4aTOtVKOlU0EwEWj1gWROlU79oED4FrMBA+Y+7
         Lyww==
X-Gm-Message-State: APjAAAU+cSnrx16pDQBpe7Tp3sxqAabKSSLmZyEinWYFKveyYYDcwxXU
        hCSomOT9x5Hi/hrouyuXZYBID1lnrb+x4dOj4+xDfQ==
X-Google-Smtp-Source: APXvYqw655nDWNbL1gUcMERF+BfXVE/8j1Nov0615++EmZODKPuPntXlIKE0cUgD21qdsQmaDChA4Q1k9Y85t1Pz5WDAeA==
X-Received: by 2002:a63:2b92:: with SMTP id r140mr4811067pgr.363.1559940726994;
 Fri, 07 Jun 2019 13:52:06 -0700 (PDT)
Date:   Fri,  7 Jun 2019 13:51:47 -0700
In-Reply-To: <20190607205147.102904-1-matthewgarrett@google.com>
Message-Id: <20190607205147.102904-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH V2 2/2] tpm: Don't duplicate events from the final event log
 in the TCG2 log
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
 drivers/char/tpm/eventlog/efi.c    | 11 ++++++++++-
 drivers/firmware/efi/libstub/tpm.c | 30 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/tpm.c         |  2 +-
 include/linux/efi.h                |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 6b3b507a54eb..eb9af83e4d59 100644
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
+		while (i > 0) {
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
2.22.0.rc2.383.gf4fbbf30c2-goog

