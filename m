Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B157A36BD
	for <lists+linux-efi@lfdr.de>; Sun, 17 Sep 2023 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjIQRHP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Sep 2023 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjIQRHB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Sep 2023 13:07:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EB1A6
        for <linux-efi@vger.kernel.org>; Sun, 17 Sep 2023 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694970395; x=1726506395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YibRteZ40emmTpaSir8jrZXq4KnJU4t1IMdC1I3URdo=;
  b=XDgimXyKXrfysxpsyWIi7azojt6jpKnOfVzVl0pUlOoeZilE0O3CpPH9
   daxZFd+h9HlZyWeoA3B4EOQkmc007i15fk1cbp4qJwYrGJII4TlUgdxnR
   pCoXfkjvXyq3mMGu+QLR0kPZQ9vKR1RTfiaPrbt3RCvgrQb/Vxgy+ygY7
   PMuvcZV22OJBc/vHgWvHI2czi1I5Qlz1mXpnRxCQBfb+7gtig7R/Dgzxw
   NGnfLgx8nE/sZ1a4Hpin/NnmoaF/jPpVKQo3Py4RhoJJPdhffwQwiyQ7Y
   TP+wE3byyKTk6jnaFw/tSz3IkKFum4bi2VEceW6b7OISV+2IamzrddI6M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="376833562"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="376833562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 10:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="738880275"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="738880275"
Received: from abobyr-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.48.142])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 10:06:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E82EB1099BA; Sun, 17 Sep 2023 20:06:29 +0300 (+03)
Date:   Sun, 17 Sep 2023 20:06:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI
 ranges
Message-ID: <20230917170629.d35gnwb6o54bdrhl@box.shutemov.name>
References: <20230816190557.3738-1-ardb@kernel.org>
 <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
 <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
 <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
 <20230907104914.a4nt23yuronohivo@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907104914.a4nt23yuronohivo@box.shutemov.name>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 07, 2023 at 01:49:14PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 06, 2023 at 11:17:12AM +0200, Ard Biesheuvel wrote:
> > On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > > > not going to be present in the direct mapping.
> > > > >
> > > > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > > > calculation.
> > > > >
> > > > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > > > tables and might be required by kernel to function properly.
> > > > >
> > > > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > > > can fit under the last E820_TYPE_ACPI range.
> > > > >
> > > > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > > > E820_TYPE_ACPI memory.
> > > > >
> > > > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > > > it between the kernels on kexec.
> > > > >
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > >
> > > > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > > > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > > > memory that can be used by the OS as ordinary RAM if it is not
> > > > interested in the contents (or has already consumed them). So this
> > > > could arguably be classified as E820_TYPE_RAM too.
> > >
> > > Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> > > IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> > > kexec, regardless if it is crash kernel or not. I'm not sure we would not
> > > break anything.
> > >
> > 
> > Yeah, you're right. So this patch is necessary in any case.
> > 
> > Do we also need the EFI side patch then?
> 
> Yes, we need it to get it mapped into the crashkernel direct mapping.

Ughh. The patch alone causes crash as EFI_ACPI_RELACLAIM_MEMORY is not
mapped into direct mapping during memory init.

The patch below fixes the issue.

I should have noticed it before, but I had essentially the same patch in
my tree for a different reason. Sorry for that :/

Please apply the patch below.

From b5d1faf9e515195c58cc5e34132284894fca17f2 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 14 Aug 2023 19:12:47 +0300
Subject: [PATCH] efi/unaccepted: Make sure unaccepted table is mapped in
 crashkernel case

Unaccepted table is now allocated from EFI_ACPI_RELACLAIM_MEMORY. It
translates into E820_TYPE_ACPI, which is not added to memblock and
therefore not mapped in the direct mapping.

It causes crash on the first touch of the table.

Use memblock_add() to make sure that the table is mapped in direct
mapping.

Align the range to the nearest page boarders. Ranges smaller than page
size are not going to be mapped.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: e7761d827e99 ("efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table")
---
 drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..4f409652b3c6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -623,6 +623,34 @@ static __init int match_config_table(const efi_guid_t *guid,
 	return 0;
 }
 
+/**
+ * reserve_unaccepted - Map and reserve unaccepted configuration table
+ * @unaccepted: Pointer to unaccepted memory table
+ *
+ * memblock_add() makes sure that the table is mapped in direct mapping. During
+ * normal boot it happens automatically because the table is allocated from
+ * usable memory. But during crashkernel boot only memory specifically
+ * reserved for crash scenario is mapped. memblock_add() forces the table to be
+ * mapped in crashkernel case.
+ *
+ * Align the range to the nearest page boarders. Ranges smaller than page size
+ * are not going to be mapped.
+ *
+ * memblock_reserve() makes sure that future allocations will not touch the
+ * table.
+ */
+
+static __init void reserve_unaccepted(struct efi_unaccepted_memory *unaccepted)
+{
+	phys_addr_t start, size;
+
+	start = PAGE_ALIGN_DOWN(efi.unaccepted);
+	size = PAGE_ALIGN(sizeof(*unaccepted) + unaccepted->size);
+
+	memblock_add(start, size);
+	memblock_reserve(start, size);
+}
+
 int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 				   int count,
 				   const efi_config_table_type_t *arch_tables)
@@ -751,11 +779,9 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 
 		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
 		if (unaccepted) {
-			unsigned long size;
 
 			if (unaccepted->version == 1) {
-				size = sizeof(*unaccepted) + unaccepted->size;
-				memblock_reserve(efi.unaccepted, size);
+				reserve_unaccepted(unaccepted);
 			} else {
 				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
 			}
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
