Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3173B1D6822
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgEQM7C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgEQM7C (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:59:02 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FEC204EC;
        Sun, 17 May 2020 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720341;
        bh=K4bW9SUbhJFwMKYXQlU1RiO8Sw6g6tGuIMcVLffkWtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18z8pliLqz4DFmOz9J9BnY3COarwmndS4ufpOhNNlGWHJCAL/O4I7tbGdc2Jqp+ZI
         pgolYbCZG9MVlLz39aLLLZhL+JouD7SH2Ot+n3aAMdbFCzoGMCnYl0bo08ZcGA8dH/
         n9BOSSHYbE9UG3DOTmMwS9ZeZ1+iEdFHrtjsW794=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 7/7] tpm: check event log version before reading final events
Date:   Sun, 17 May 2020 14:57:54 +0200
Message-Id: <20200517125754.8934-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Loic Yhuel <loic.yhuel@gmail.com>

This fixes the boot issues since 5.3 on several Dell models when the TPM
is enabled. Depending on the exact grub binary, booting the kernel would
freeze early, or just report an error parsing the final events log.

We get an event log in the SHA-1 format, which doesn't have a
tcg_efi_specid_event_head in the first event, and there is a final events
table which doesn't match the crypto agile format.
__calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
either fails, or loops long enough for the machine to be appear frozen.

So we now only parse the final events table, which is per the spec always
supposed to be in the crypto agile format, when we got a event log in this
format.

Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1779611
Signed-off-by: Loïc Yhuel <loic.yhuel@gmail.com>
Link: https://lore.kernel.org/r/20200512040113.277768-1-loic.yhuel@gmail.com
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Matthew Garrett <mjg59@google.com>
[ardb: warn when final events table is missing or in the wrong format]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 5 +++--
 drivers/firmware/efi/tpm.c         | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 1d59e103a2e3..e9a684637b70 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -54,7 +54,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	efi_status_t status;
 	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
-	struct efi_tcg2_final_events_table *final_events_table;
+	struct efi_tcg2_final_events_table *final_events_table = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
@@ -127,7 +127,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 31f9f0e369b9..0543fbf60222 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,8 +62,11 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
 		goto out;
+	}
 
 	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
 
-- 
2.17.1

