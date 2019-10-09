Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366AED1CA7
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfJIXTR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 19:19:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:49489 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbfJIXTQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Oct 2019 19:19:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:15 -0700
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="223748443"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:15 -0700
Subject: [PATCH v6 04/12] efi: Common enable/disable infrastructure for EFI
 soft reservation
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 09 Oct 2019 16:04:57 -0700
Message-ID: <157066229757.1059972.16873416956816693344.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
interpretation of the EFI Memory Types as "reserved for a specific
purpose".

The proposed Linux behavior for specific purpose memory is that it is
reserved for direct-access (device-dax) by default and not available for
any kernel usage, not even as an OOM fallback.  Later, through udev
scripts or another init mechanism, these device-dax claimed ranges can
be reconfigured and hot-added to the available System-RAM with a unique
node identifier. This device-dax management scheme implements "soft" in
the "soft reserved" designation by allowing some or all of the
reservation to be recovered as typical memory. This policy can be
disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
efi=nosoftreserve.

As for this patch, define the common helpers to determine if the
EFI_MEMORY_SP attribute should be honored. The determination needs to be
made early to prevent the kernel from being loaded into soft-reserved
memory, or otherwise allowing early allocations to land there. Follow-on
changes are needed per architecture to leverage these helpers in their
respective mem-init paths.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    9 ++++++++-
 drivers/firmware/efi/Kconfig                    |   21 +++++++++++++++++++++
 drivers/firmware/efi/efi.c                      |    9 +++++++++
 drivers/firmware/efi/libstub/efi-stub-helper.c  |   19 +++++++++++++++++++
 include/linux/efi.h                             |    8 ++++++++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..47478a730011 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1168,7 +1168,8 @@
 			Format: {"off" | "on" | "skip[mbr]"}
 
 	efi=		[EFI]
-			Format: { "old_map", "nochunk", "noruntime", "debug" }
+			Format: { "old_map", "nochunk", "noruntime", "debug",
+				  "nosoftreserve" }
 			old_map [X86-64]: switch to the old ioremap-based EFI
 			runtime services mapping. 32-bit still uses this one by
 			default.
@@ -1177,6 +1178,12 @@
 			firmware implementations.
 			noruntime : disable EFI runtime services support
 			debug: enable misc debug output
+			nosoftreserve: The EFI_MEMORY_SP (Specific Purpose)
+			attribute may cause the kernel to reserve the
+			memory range for a memory mapping driver to
+			claim. Specify efi=nosoftreserve to disable this
+			reservation and treat the memory by its base type
+			(i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..9fa79f9fa0af 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -75,6 +75,27 @@ config EFI_MAX_FAKE_MEM
 	  Ranges can be set up to this value using comma-separated list.
 	  The default value is 8.
 
+config EFI_SOFT_RESERVE
+	bool "Reserve EFI Specific Purpose Memory"
+	depends on EFI && ACPI_HMAT
+	default ACPI_HMAT
+	help
+	  On systems that have mixed performance classes of memory EFI
+	  may indicate specific purpose memory with an attribute (See
+	  EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
+	  attribute may have unique performance characteristics compared
+	  to the system's general purpose "System RAM" pool. On the
+	  expectation that such memory has application specific usage,
+	  and its base EFI memory type is "conventional" answer Y to
+	  arrange for the kernel to reserve it as a "Soft Reserved"
+	  resource, and set aside for direct-access (device-dax) by
+	  default. The memory range can later be optionally assigned to
+	  the page allocator by system administrator policy via the
+	  device-dax kmem facility. Say N to have the kernel treat this
+	  memory as "System RAM" by default.
+
+	  If unsure, say Y.
+
 config EFI_PARAMS_FROM_FDT
 	bool
 	help
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 68a4ec24b823..911a58be4a36 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -81,6 +81,12 @@ bool efi_runtime_disabled(void)
 	return disable_runtime;
 }
 
+bool __pure efi_soft_reserve_enabled(void)
+{
+	return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
+	       !efi_enabled(EFI_MEM_NO_SOFT_RESERVE);
+}
+
 static int __init parse_efi_cmdline(char *str)
 {
 	if (!str) {
@@ -94,6 +100,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "nosoftreserve"))
+		set_bit(EFI_MEM_NO_SOFT_RESERVE, &efi.flags);
+
 	return 0;
 }
 early_param("efi", parse_efi_cmdline);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f2cf56..5d901c56ac5f 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
 static int __section(.data) __novamap;
+static bool __section(.data) efi_nosoftreserve;
 
 int __pure nokaslr(void)
 {
@@ -45,6 +46,10 @@ int __pure novamap(void)
 {
 	return __novamap;
 }
+bool __pure efi_soft_reserve_enabled(void)
+{
+	return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) && !efi_nosoftreserve;
+}
 
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
@@ -211,6 +216,10 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (efi_soft_reserve_enabled() &&
+		    (desc->attribute & EFI_MEMORY_SP))
+			continue;
+
 		if (desc->num_pages < nr_pages)
 			continue;
 
@@ -305,6 +314,10 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (efi_soft_reserve_enabled() &&
+		    (desc->attribute & EFI_MEMORY_SP))
+			continue;
+
 		if (desc->num_pages < nr_pages)
 			continue;
 
@@ -489,6 +502,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			__novamap = 1;
 		}
 
+		if (IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
+		    !strncmp(str, "nosoftreserve", 7)) {
+			str += strlen("nosoftreserve");
+			efi_nosoftreserve = 1;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index baa275c56401..959c9650018f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1202,6 +1202,7 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_DBG			8	/* Print additional debug info at runtime */
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_MEM_NO_SOFT_RESERVE	11	/* Is the kernel configured to ignore soft reservations? */
 
 #ifdef CONFIG_EFI
 /*
@@ -1212,6 +1213,8 @@ static inline bool efi_enabled(int feature)
 	return test_bit(feature, &efi.flags) != 0;
 }
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
+
+bool __pure efi_soft_reserve_enabled(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1225,6 +1228,11 @@ efi_capsule_pending(int *reset_type)
 {
 	return false;
 }
+
+static inline bool efi_soft_reserve_enabled(void)
+{
+	return false;
+}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);

