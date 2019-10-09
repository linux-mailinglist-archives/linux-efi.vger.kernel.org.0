Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FBD1C97
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 01:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfJIXTF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 19:19:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:49484 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfJIXTE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Oct 2019 19:19:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:03 -0700
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="218836827"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:03 -0700
Subject: [PATCH v6 02/12] efi: Enumerate EFI_MEMORY_SP
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Oct 2019 16:04:45 -0700
Message-ID: <157066228577.1059972.15700844895497074116.stgit@dwillia2-desk3.amr.corp.intel.com>
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
purpose". The intent of this bit is to allow the OS to identify precious
or scarce memory resources and optionally manage it separately from
EfiConventionalMemory. As defined older OSes that do not know about this
attribute are permitted to ignore it and the memory will be handled
according to the OS default policy for the given memory type.

In other words, this "specific purpose" hint is deliberately weaker than
EfiReservedMemoryType in that the system continues to operate if the OS
takes no action on the attribute. The risk of taking no action is
potentially unwanted / unmovable kernel allocations from the designated
resource that prevent the full realization of the "specific purpose".
For example, consider a system with a high-bandwidth memory pool. Older
kernels are permitted to boot and consume that memory as conventional
"System-RAM" newer kernels may arrange for that memory to be set aside
(soft reserved) by the system administrator for a dedicated
high-bandwidth memory aware application to consume.

Specifically, this mechanism allows for the elimination of scenarios
where platform firmware tries to game OS policy by lying about ACPI SLIT
values, i.e. claiming that a precious memory resource has a high
distance to trigger the OS to avoid it by default. This reservation hint
allows platform-firmware to instead tell the truth about performance
characteristics by indicate to OS memory management to put immovable
allocations elsewhere.

Implement simple detection of the bit for EFI memory table dumps and
save the kernel policy for a follow-on change.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/efi.c |    5 +++--
 include/linux/efi.h        |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8d3e778e988b..68a4ec24b823 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -839,15 +839,16 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
-		     EFI_MEMORY_NV |
+		     EFI_MEMORY_NV | EFI_MEMORY_SP |
 		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
+			 attr & EFI_MEMORY_SP      ? "SP"  : "",
 			 attr & EFI_MEMORY_NV      ? "NV"  : "",
 			 attr & EFI_MEMORY_XP      ? "XP"  : "",
 			 attr & EFI_MEMORY_RP      ? "RP"  : "",
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..5c1dd0221384 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -112,6 +112,7 @@ typedef	struct {
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
+#define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 

