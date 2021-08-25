Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990983F781C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhHYPSg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhHYPSf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Aug 2021 11:18:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB5C061757;
        Wed, 25 Aug 2021 08:17:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea700924cc147a25a6e09.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:924c:c147:a25a:6e09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1125B1EC0372;
        Wed, 25 Aug 2021 17:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629904664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FO6+ye2ARhv37fblyN9kntHmslFURj6Br/6bURSaFA8=;
        b=XyEZq224JnonmaHJCMuvIm1afOxBA6JMKYardJR/DD8BjMEzKlaXDzBrtr6FBv1M1Enw4/
        gxke1+tpIrJkpQxDa+eTmkP/F8GA0PqztXpalXYfwIGV6tcSdziceBXAUq0etCE22HJ2Jk
        vr+PcoGTNdWNIMSsWJFatz4uosM6v94=
Date:   Wed, 25 Aug 2021 17:18:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 26/38] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <YSZfPFrzXv0dImsv@zn.tnic>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-27-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820151933.22401-27-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 10:19:21AM -0500, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Future patches for SEV-SNP-validated CPUID will also require early
> parsing of the EFI configuration. Move the related code into a set of
> helpers that can be re-used for that purpose.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/Makefile |   1 +
>  arch/x86/boot/compressed/acpi.c   | 113 +++++--------------
>  arch/x86/boot/compressed/efi.c    | 178 ++++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/misc.h   |  43 ++++++++
>  4 files changed, 251 insertions(+), 84 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi.c

Ok, better, but this patch needs splitting. And I have a good idea how:
in at least three patches:

1. Add efi_get_system_table() and use it
2. Add efi_get_conf_table() and use it
3. Add efi_find_vendor_table() and use it

This will facilitate review immensely.

Also, here's a diff ontop of what to do also, style-wise.

- change how you look for the preferred vendor table along with commenting what you do
- shorten variable names so that you don't have so many line breaks.

Thx.

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 3a3f997d7210..c22b21e94a95 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -20,27 +20,29 @@
  */
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
-/*
- * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
- * ACPI_TABLE_GUID are found, take the former, which has more features.
- */
 static acpi_physical_address
-__efi_get_rsdp_addr(unsigned long config_table_pa,
-		    unsigned int config_table_len, bool efi_64)
+__efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len, bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
+
 #ifdef CONFIG_EFI
 	int ret;
 
-	ret = efi_find_vendor_table(config_table_pa, config_table_len,
-				    ACPI_20_TABLE_GUID, efi_64,
-				    (unsigned long *)&rsdp_addr);
-	if (ret == -ENOENT)
-		ret = efi_find_vendor_table(config_table_pa, config_table_len,
-					    ACPI_TABLE_GUID, efi_64,
-					    (unsigned long *)&rsdp_addr);
+	/*
+	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
+	 * ACPI_TABLE_GUID because it has more features.
+	 */
+	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_20_TABLE_GUID,
+				    efi_64, (unsigned long *)&rsdp_addr);
+	if (!ret)
+		return rsdp_addr;
+
+	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
+	ret = efi_find_vendor_table(cfg_tbl_pa, cfg_tbl_len, ACPI_TABLE_GUID,
+				    efi_64, (unsigned long *)&rsdp_addr);
 	if (ret)
 		debug_putstr("Error getting RSDP address.\n");
+
 #endif
 	return rsdp_addr;
 }
@@ -100,18 +102,16 @@ static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
 static acpi_physical_address efi_get_rsdp_addr(void)
 {
 #ifdef CONFIG_EFI
-	unsigned long config_table_pa = 0;
-	unsigned int config_table_len;
+	unsigned long cfg_tbl_pa = 0;
+	unsigned int cfg_tbl_len;
 	bool efi_64;
 	int ret;
 
-	ret = efi_get_conf_table(boot_params, &config_table_pa,
-				 &config_table_len, &efi_64);
-	if (ret || !config_table_pa)
+	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len, &efi_64);
+	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
-	return __efi_get_rsdp_addr(config_table_pa, config_table_len,
-				   efi_64);
+	return __efi_get_rsdp_addr(cfg_tbl_pa, cfg_tbl_len, efi_64);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 16ff5cb9a1fb..7ed31b943c04 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -12,14 +12,14 @@
 #include <asm/efi.h>
 
 /* Get vendor table address/guid from EFI config table at the given index */
-static int get_vendor_table(void *conf_table, unsigned int idx,
+static int get_vendor_table(void *cfg_tbl, unsigned int idx,
 			    unsigned long *vendor_table_pa,
 			    efi_guid_t *vendor_table_guid,
 			    bool efi_64)
 {
 	if (efi_64) {
 		efi_config_table_64_t *table_entry =
-			(efi_config_table_64_t *)conf_table + idx;
+			(efi_config_table_64_t *)cfg_tbl + idx;
 
 		if (!IS_ENABLED(CONFIG_X86_64) &&
 		    table_entry->table >> 32) {
@@ -32,7 +32,7 @@ static int get_vendor_table(void *conf_table, unsigned int idx,
 
 	} else {
 		efi_config_table_32_t *table_entry =
-			(efi_config_table_32_t *)conf_table + idx;
+			(efi_config_table_32_t *)cfg_tbl + idx;
 
 		*vendor_table_pa = table_entry->table;
 		*vendor_table_guid = table_entry->guid;
@@ -45,27 +45,25 @@ static int get_vendor_table(void *conf_table, unsigned int idx,
  * Given EFI config table, search it for the physical address of the vendor
  * table associated with GUID.
  *
- * @conf_table:        pointer to EFI configuration table
- * @conf_table_len:    number of entries in EFI configuration table
+ * @cfg_tbl:        pointer to EFI configuration table
+ * @cfg_tbl_len:    number of entries in EFI configuration table
  * @guid:              GUID of vendor table
  * @efi_64:            true if using 64-bit EFI
  * @vendor_table_pa:   location to store physical address of vendor table
  *
  * Returns 0 on success. On error, return params are left unchanged.
  */
-int
-efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
-		      efi_guid_t guid, bool efi_64,
-		      unsigned long *vendor_table_pa)
+int efi_find_vendor_table(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len,
+			  efi_guid_t guid, bool efi_64, unsigned long *vendor_table_pa)
 {
 	unsigned int i;
 
-	for (i = 0; i < conf_table_len; i++) {
+	for (i = 0; i < cfg_tbl_len; i++) {
 		unsigned long vendor_table_pa_tmp;
 		efi_guid_t vendor_table_guid;
 		int ret;
 
-		if (get_vendor_table((void *)conf_table_pa, i,
+		if (get_vendor_table((void *)cfg_tbl_pa, i,
 				     &vendor_table_pa_tmp,
 				     &vendor_table_guid, efi_64))
 			return -EINVAL;
@@ -88,9 +86,8 @@ efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
  *
  * Returns 0 on success. On error, return params are left unchanged.
  */
-int
-efi_get_system_table(struct boot_params *boot_params,
-		     unsigned long *sys_table_pa, bool *is_efi_64)
+int efi_get_system_table(struct boot_params *boot_params, unsigned long *sys_table_pa,
+			 bool *is_efi_64)
 {
 	unsigned long sys_table;
 	struct efi_info *ei;
@@ -137,22 +134,19 @@ efi_get_system_table(struct boot_params *boot_params,
  * address EFI configuration table.
  *
  * @boot_params:        pointer to boot_params
- * @conf_table_pa:      location to store physical address of config table
- * @conf_table_len:     location to store number of config table entries
+ * @cfg_tbl_pa:      location to store physical address of config table
+ * @cfg_tbl_len:     location to store number of config table entries
  * @is_efi_64:          location to store whether using 64-bit EFI or not
  *
  * Returns 0 on success. On error, return params are left unchanged.
  */
-int
-efi_get_conf_table(struct boot_params *boot_params,
-		   unsigned long *conf_table_pa,
-		   unsigned int *conf_table_len,
-		   bool *is_efi_64)
+int efi_get_conf_table(struct boot_params *boot_params, unsigned long *cfg_tbl_pa,
+		       unsigned int *cfg_tbl_len, bool *is_efi_64)
 {
 	unsigned long sys_table_pa = 0;
 	int ret;
 
-	if (!conf_table_pa || !conf_table_len || !is_efi_64)
+	if (!cfg_tbl_pa || !cfg_tbl_len || !is_efi_64)
 		return -EINVAL;
 
 	ret = efi_get_system_table(boot_params, &sys_table_pa, is_efi_64);
@@ -164,14 +158,14 @@ efi_get_conf_table(struct boot_params *boot_params,
 		efi_system_table_64_t *stbl =
 			(efi_system_table_64_t *)sys_table_pa;
 
-		*conf_table_pa	= stbl->tables;
-		*conf_table_len	= stbl->nr_tables;
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
 	} else {
 		efi_system_table_32_t *stbl =
 			(efi_system_table_32_t *)sys_table_pa;
 
-		*conf_table_pa	= stbl->tables;
-		*conf_table_len	= stbl->nr_tables;
+		*cfg_tbl_pa	= stbl->tables;
+		*cfg_tbl_len	= stbl->nr_tables;
 	}
 
 	return 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
