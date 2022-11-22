Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D6633ADB
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiKVLNA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKVLMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:49 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E22679;
        Tue, 22 Nov 2022 03:12:48 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3BA8740737C9;
        Tue, 22 Nov 2022 11:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3BA8740737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115562;
        bh=6LbB1uBc1uJCmmb4a8uDsumRWsUg2xKiizxsfNVpfWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1F+9R+RWehzXcuBSqjA4fm/8ZLNLbdiiV9hfYVRBKJgSMWrJgMzf10J5xdAFjVi0
         MD/r1Jay3tfrKfn3wrEzzHSswIaAiqAOl8SRJolRSyV72NJCYvfDcWRFFXypHjh6EI
         O+3KQoFAfEVYL4AmCvR7yVoOMVPG0i3JAJFmKxGQ=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 08/24] x86/boot: Map memory explicitly
Date:   Tue, 22 Nov 2022 14:12:17 +0300
Message-Id: <661b7828c7a7b059dba1cca05e3fc80a0e31eccd.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Implicit mappings hide possible memory errors, e.g. allocations for
ACPI tables were not included in boot page table size.

Replace all implicit mappings from page fault handler with
explicit mappings.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/acpi.c  | 21 ++++++++++++++++++++-
 arch/x86/boot/compressed/efi.c   | 19 ++++++++++++++++++-
 arch/x86/boot/compressed/kaslr.c |  4 ++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..633ac56262ee 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -93,6 +93,8 @@ static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
 
 	end = start + length;
 
+	kernel_add_identity_map((unsigned long)start, (unsigned long)end, 0);
+
 	/* Search from given start address for the requested length */
 	for (address = start; address < end; address += ACPI_RSDP_SCAN_STEP) {
 		/*
@@ -128,6 +130,9 @@ static acpi_physical_address bios_get_rsdp_addr(void)
 	unsigned long address;
 	u8 *rsdp;
 
+	kernel_add_identity_map((unsigned long)ACPI_EBDA_PTR_LOCATION,
+				(unsigned long)ACPI_EBDA_PTR_LOCATION + 2, 0);
+
 	/* Get the location of the Extended BIOS Data Area (EBDA) */
 	address = *(u16 *)ACPI_EBDA_PTR_LOCATION;
 	address <<= 4;
@@ -215,6 +220,9 @@ static unsigned long get_acpi_srat_table(void)
 	if (!rsdp)
 		return 0;
 
+	kernel_add_identity_map((unsigned long)rsdp,
+				(unsigned long)(rsdp + 1), 0);
+
 	/* Get ACPI root table from RSDP.*/
 	if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
 	    !strncmp(arg, "rsdt", 4)) &&
@@ -235,6 +243,9 @@ static unsigned long get_acpi_srat_table(void)
 	if (len < sizeof(struct acpi_table_header) + size)
 		return 0;
 
+	kernel_add_identity_map((unsigned long)header,
+				(unsigned long)header + len, 0);
+
 	num_entries = (len - sizeof(struct acpi_table_header)) / size;
 	entry = (u8 *)(root_table + sizeof(struct acpi_table_header));
 
@@ -247,8 +258,16 @@ static unsigned long get_acpi_srat_table(void)
 		if (acpi_table) {
 			header = (struct acpi_table_header *)acpi_table;
 
-			if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_SRAT))
+			kernel_add_identity_map(acpi_table,
+						acpi_table + sizeof(*header),
+						0);
+
+			if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_SRAT)) {
+				kernel_add_identity_map(acpi_table,
+							acpi_table + header->length,
+							0);
 				return acpi_table;
+			}
 		}
 		entry += size;
 	}
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 6edd034b0b30..ce70103fbbc0 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -57,10 +57,14 @@ enum efi_type efi_get_type(struct boot_params *bp)
  */
 unsigned long efi_get_system_table(struct boot_params *bp)
 {
-	unsigned long sys_tbl_pa;
+	static unsigned long sys_tbl_pa __section(".data");
 	struct efi_info *ei;
+	unsigned long sys_tbl_size;
 	enum efi_type et;
 
+	if (sys_tbl_pa)
+		return sys_tbl_pa;
+
 	/* Get systab from boot params. */
 	ei = &bp->efi_info;
 #ifdef CONFIG_X86_64
@@ -73,6 +77,13 @@ unsigned long efi_get_system_table(struct boot_params *bp)
 		return 0;
 	}
 
+	if (efi_get_type(bp) == EFI_TYPE_64)
+		sys_tbl_size = sizeof(efi_system_table_64_t);
+	else
+		sys_tbl_size = sizeof(efi_system_table_32_t);
+
+	kernel_add_identity_map(sys_tbl_pa, sys_tbl_pa + sys_tbl_size, 0);
+
 	return sys_tbl_pa;
 }
 
@@ -92,6 +103,10 @@ static struct efi_setup_data *get_kexec_setup_data(struct boot_params *bp,
 
 	pa_data = bp->hdr.setup_data;
 	while (pa_data) {
+		unsigned long pa_data_end = pa_data + sizeof(struct setup_data)
+					  + sizeof(struct efi_setup_data);
+		kernel_add_identity_map(pa_data, pa_data_end, 0);
+
 		data = (struct setup_data *)pa_data;
 		if (data->type == SETUP_EFI) {
 			esd = (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
@@ -160,6 +175,8 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
 		return -EINVAL;
 	}
 
+	kernel_add_identity_map(*cfg_tbl_pa, *cfg_tbl_pa + *cfg_tbl_len, 0);
+
 	return 0;
 }
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e476bcbd9b42..7e09d65f7b57 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -688,6 +688,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 	u32 nr_desc;
 	int i;
 
+	kernel_add_identity_map((unsigned long)e, (unsigned long)(e + 1), 0);
+
 	signature = (char *)&e->efi_loader_signature;
 	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
 	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4))
@@ -704,6 +706,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 	pmap = (e->efi_memmap | ((__u64)e->efi_memmap_hi << 32));
 #endif
 
+	kernel_add_identity_map(pmap, pmap + e->efi_memmap_size, 0);
+
 	nr_desc = e->efi_memmap_size / e->efi_memdesc_size;
 	for (i = 0; i < nr_desc; i++) {
 		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
-- 
2.37.4

