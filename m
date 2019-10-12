Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F64D4FDF
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2019 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfJLNBq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Oct 2019 09:01:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40385 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfJLNBq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Oct 2019 09:01:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so14702796wrv.7;
        Sat, 12 Oct 2019 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uLp6NajyklaXJuw7py6f5SAsRw2iuNXDZQAXk26f2mg=;
        b=N9b/tMB9cdzSE1xgiE783A8yBC0yOO3wXxmIQBu7RcYAFu1ihsVb58pBiD6QzDyX2n
         cN57K5Qsy7qy5KPrk0lFx/EiqIQ4xg84qDoLTfIxtSIV4uyVYV62J4+94dzpRHWmAzW6
         TlP2XN7AmgFn+VT89quh/yjjmbMoWxYzQTe3Vi2EH2ScfdGNfi/jzfG4h3NE7EFdZxPX
         Rsg94u7XfsElhk9hiJ9QZv3FAemocxaH3kzH1fSc4GaffD38kyIATpuRBx2UK2rnpdE8
         YxbyrIB6YrrSga9RLCaW4Kyz6DPxrdT8SdCV6Qh7IUbvbDOkLfgSEYc++fP//RSjRANr
         RuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uLp6NajyklaXJuw7py6f5SAsRw2iuNXDZQAXk26f2mg=;
        b=FEFUkz2J3HDOimgh+H+QedFSIDVIvfjeddMSoHadNS/t+L2dh0M0SsDt3pDLudchyc
         3IymH6boGN6FkBzCA/Li+gTQHC4HuK3iBpFXSVf5LXyEBUa+3Rmcl+rI4CmEQps08qtN
         y88EAOYTW/99hTKw1UKuYWfPQzb9LjVGFuQ5LpTS8hBw12jROrQKKlItd1+esyEJMDJe
         qxaObOLL5ZnOpjLh4BiZ1u7qpNeLW+zp+Ew2FAVd6SvFTUtM5VwHW5Q93LkrifnY+zCJ
         bU7jyhxguSlIsQGC45FhRA7aZdUyAmoPIz7bp/WMHdWmQMmtVnO3HXrpcUTnHAv3sgq4
         RtFQ==
X-Gm-Message-State: APjAAAWpt/16s7uRz3g4bvVZyx5HdVPeQGfnFv+8SFOElCQEJ/SInjop
        I7ihoR9pVGKr4O5xSUzuTKI=
X-Google-Smtp-Source: APXvYqz/V/vzy7M81Wiyeyed8Ar0AMjd+EXgsTZPMzBOv6BXTN6q8QCClJTpdJvnjAB39GjzFVoILQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr18968221wrl.189.1570885302863;
        Sat, 12 Oct 2019 06:01:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b15sm13107305wmb.28.2019.10.12.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 06:01:42 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:01:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20191012130139.GA10386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: be59d57f98065af0b8472f66a0a969207b168680 efi/tpm: Fix sanity check of unsigned tbl_size being less than zero

Misc EFI fixes all across the map: CPER error report fixes, fixes to TPM 
event log parsing, fix for a kexec hang, a Sparse fix and other fixes.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efivar/ssdt: Don't iterate over EFI vars if no SSDT override was specified

Ben Dooks (1):
      efi: Make unexported efi_rci2_sysfs_init() static

Colin Ian King (1):
      efi/tpm: Fix sanity check of unsigned tbl_size being less than zero

Dave Young (1):
      efi/x86: Do not clean dummy variable in kexec path

Jerry Snitselaar (1):
      efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing

Lukas Wunner (1):
      efi/cper: Fix endianness of PCIe class code

Peter Jones (2):
      efi/tpm: Don't access event->count when it isn't mapped
      efi/tpm: Don't traverse an event log with no events


 arch/x86/platform/efi/efi.c       |  3 ---
 drivers/firmware/efi/cper.c       |  2 +-
 drivers/firmware/efi/efi.c        |  3 +++
 drivers/firmware/efi/rci2-table.c |  2 +-
 drivers/firmware/efi/tpm.c        | 26 +++++++++++++++++++-------
 include/linux/tpm_eventlog.h      | 16 ++++++++++++----
 6 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index c202e1b07e29..425e025341db 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -917,9 +917,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index addf0749dd8b..b1af0de2e100 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -381,7 +381,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
 		       pcie->device_id.vendor_id, pcie->device_id.device_id);
 		p = pcie->device_id.class_code;
-		printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
+		printk("%s""class_code: %02x%02x%02x\n", pfx, p[2], p[1], p[0]);
 	}
 	if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
 		printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8d3e778e988b..69f00f7453a3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -267,6 +267,9 @@ static __init int efivar_ssdt_load(void)
 	void *data;
 	int ret;
 
+	if (!efivar_ssdt[0])
+		return 0;
+
 	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
 
 	list_for_each_entry_safe(entry, aux, &entries, list) {
diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 3e290f96620a..76b0c354a027 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -76,7 +76,7 @@ static u16 checksum(void)
 	return chksum;
 }
 
-int __init efi_rci2_sysfs_init(void)
+static int __init efi_rci2_sysfs_init(void)
 {
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 1d3f5ca3eaaf..ebd7977653a8 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	unsigned int tbl_size;
+	int tbl_size;
 	int ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
@@ -75,16 +75,28 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
-					    + sizeof(final_tbl->version)
-					    + sizeof(final_tbl->nr_events),
-					    final_tbl->nr_events,
-					    log_tbl->log);
+	tbl_size = 0;
+	if (final_tbl->nr_events != 0) {
+		void *events = (void *)efi.tpm_final_log
+				+ sizeof(final_tbl->version)
+				+ sizeof(final_tbl->nr_events);
+
+		tbl_size = tpm2_calc_event_log_size(events,
+						    final_tbl->nr_events,
+						    log_tbl->log);
+	}
+
+	if (tbl_size < 0) {
+		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		goto out_calc;
+	}
+
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
-	early_memunmap(final_tbl, sizeof(*final_tbl));
 	efi_tpm_final_log_size = tbl_size;
 
+out_calc:
+	early_memunmap(final_tbl, sizeof(*final_tbl));
 out:
 	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return ret;
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 63238c84dc0b..131ea1bad458 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -152,7 +152,7 @@ struct tcg_algorithm_info {
  * total. Once we've done this we know the offset of the data length field,
  * and can calculate the total size of the event.
  *
- * Return: size of the event on success, <0 on failure
+ * Return: size of the event on success, 0 on failure
  */
 
 static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
@@ -170,6 +170,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	u16 halg;
 	int i;
 	int j;
+	u32 count, event_type;
 
 	marker = event;
 	marker_start = marker;
@@ -190,16 +191,22 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	}
 
 	event = (struct tcg_pcr_event2_head *)mapping;
+	/*
+	 * The loop below will unmap these fields if the log is larger than
+	 * one page, so save them here for reference:
+	 */
+	count = READ_ONCE(event->count);
+	event_type = READ_ONCE(event->event_type);
 
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (event->count > efispecid->num_algs) {
+	if (count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
 
-	for (i = 0; i < event->count; i++) {
+	for (i = 0; i < count; i++) {
 		halg_size = sizeof(event->digests[i].alg_id);
 
 		/* Map the digest's algorithm identifier */
@@ -256,8 +263,9 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 		+ event_field->event_size;
 	size = marker - marker_start;
 
-	if ((event->event_type == 0) && (event_field->event_size == 0))
+	if (event_type == 0 && event_field->event_size == 0)
 		size = 0;
+
 out:
 	if (do_mapping)
 		TPM_MEMUNMAP(mapping, mapping_size);
