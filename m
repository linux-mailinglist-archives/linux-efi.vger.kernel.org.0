Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B70D1CA5
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfJIXT2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 19:19:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:2147 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732387AbfJIXT2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Oct 2019 19:19:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:27 -0700
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="187772323"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 16:19:26 -0700
Subject: [PATCH v6 06/12] arm/efi: EFI soft reservation to memblock
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Wed, 09 Oct 2019 16:05:09 -0700
Message-ID: <157066230919.1059972.9000449870543851830.stgit@dwillia2-desk3.amr.corp.intel.com>
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

For this patch, update the ARM paths that consider
EFI_CONVENTIONAL_MEMORY to optionally take the EFI_MEMORY_SP attribute
into account as a reservation indicator. Publish the soft reservation as
IORES_DESC_SOFT_RESERVED memory, similar to x86.

(Based on an original patch by Ard)

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm64/mm/mmu.c                       |    2 ++
 drivers/firmware/efi/arm-init.c           |    9 +++++++++
 drivers/firmware/efi/arm-runtime.c        |   24 ++++++++++++++++++++++++
 drivers/firmware/efi/libstub/arm32-stub.c |    5 +++++
 drivers/firmware/efi/libstub/random.c     |    4 ++++
 5 files changed, 44 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 60c929f3683b..2c385fe05fde 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1061,6 +1061,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
 
+	memblock_clear_nomap(start, size);
+
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   restrictions);
 }
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 311cd349a862..904fa09e6a6b 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -163,6 +163,15 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
+		/*
+		 * Special purpose memory is 'soft reserved', which means it
+		 * is set aside initially, but can be hotplugged back in or
+		 * be assigned to the dax driver after boot.
+		 */
+		if (efi_soft_reserve_enabled() &&
+		    (md->attribute & EFI_MEMORY_SP))
+			return false;
+
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index e2ac5fa5531b..899b803842bb 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -121,6 +121,30 @@ static int __init arm_enable_runtime_services(void)
 		return 0;
 	}
 
+	if (efi_soft_reserve_enabled()) {
+		efi_memory_desc_t *md;
+
+		for_each_efi_memory_desc(md) {
+			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			struct resource *res;
+
+			if (!(md->attribute & EFI_MEMORY_SP))
+				continue;
+
+			res = kzalloc(sizeof(*res), GFP_KERNEL);
+			if (WARN_ON(!res))
+				break;
+
+			res->start	= md->phys_addr;
+			res->end	= md->phys_addr + md_size - 1;
+			res->name	= "Soft Reserved";
+			res->flags	= IORESOURCE_MEM;
+			res->desc	= IORES_DESC_SOFT_RESERVED;
+
+			insert_resource(&iomem_resource, res);
+		}
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..3cd54d2096c6 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -146,6 +146,11 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 			continue;
 
 		case EFI_CONVENTIONAL_MEMORY:
+			/* Skip soft reserved conventional memory */
+			if (efi_soft_reserve_enabled() &&
+			    (desc->attribute & EFI_MEMORY_SP))
+				continue;
+
 			/*
 			 * Reserve the intersection between this entry and the
 			 * region.
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index b4b1d1dcb5fd..6c188695e730 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -46,6 +46,10 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 	if (md->type != EFI_CONVENTIONAL_MEMORY)
 		return 0;
 
+	if (efi_soft_reserve_enabled() &&
+	    (md->attribute & EFI_MEMORY_SP))
+		return 0;
+
 	region_end = min((u64)ULONG_MAX, md->phys_addr + md->num_pages*EFI_PAGE_SIZE - 1);
 
 	first_slot = round_up(md->phys_addr, align);

