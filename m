Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036D7A55A8
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjIRWSI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRWSH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 18:18:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8218F
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695075482; x=1726611482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X2hedbYJ0uMI5nvoV0NATDvj1JkZkDRsvYp2Y4Ov+GI=;
  b=i95yDCMdEGI/WpSLR7nppO0BeeprBWkqXFGb9hv9rexaAiOnVdr7wdva
   xy+FHpwqBEahtk//ShyDwH+a6ZVmxIcIFlhxU+E6Cao8An88ftuhE4bLQ
   /NLxkBsO8POLWrzkDiqEgtxd3bLaf14aum4xhDYzW1YV1wbvhoE6/14zv
   ppX0e1v7IRlPtVwjxwvoNct6AtWjkEYp0duyCe9OhHiFNPiLCMujvON+O
   pqW56uxiLDEnc3Eq4hU+l9p6WNB+k99kgAWsvcvRAQ9931So5EbVMai7H
   EXz3nPLbBuqTdkt+f/AOQ0TfQfzFR5MHRPt8hrTS2kupTwAyMTP9xqF0l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443880175"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="443880175"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 15:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992910453"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="992910453"
Received: from ppuente-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.47.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 15:10:57 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 180D2109D8B; Tue, 19 Sep 2023 01:10:54 +0300 (+03)
Date:   Tue, 19 Sep 2023 01:10:54 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
Message-ID: <20230918221054.nugkvobvfo6islsb@box.shutemov.name>
References: <20230816190557.3738-1-ardb@kernel.org>
 <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 18, 2023 at 05:03:59PM -0500, Tom Lendacky wrote:
> On 8/16/23 14:05, Ard Biesheuvel wrote:
> > Kyril reports that crashkernels fail to work on confidential VMs that
> > rely on the unaccepted memory table, and this appears to be caused by
> > the fact that it is not considered part of the set of firmware tables
> > that the crashkernel needs to map.
> > 
> > This is an oversight, and a result of the use of the EFI_LOADER_DATA
> > memory type for this table. The correct memory type to use for any
> > firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
> > EFI stub), even though the name suggests that is it specific to ACPI.
> > ACPI reclaim means that the memory is used by the firmware to expose
> > information to the operating system, but that the memory region has no
> > special significance to the firmware itself, and the OS is free to
> > reclaim the memory and use it as ordinary memory if it is not interested
> > in the contents, or if it has already consumed them. In Linux, this
> > memory is never reclaimed, but it is always covered by the kernel direct
> > map and generally made accessible as ordinary memory.
> > 
> > On x86, ACPI reclaim memory is translated into E820_ACPI, which the
> > kexec logic already recognizes as memory that the crashkernel may need
> > to to access, and so it will be mapped and accessible to the booting
> > crash kernel.
> > 
> > Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> > index ca61f4733ea58693..9a655f30ba47db01 100644
> > --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> > @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> >   	bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
> >   				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
> > -	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> 
> I bisected an SNP guest crash when using the tip tree to this commit. When
> the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
> unaccepted table is no longer mapped. Here's a copy of the stack trace:

Could you try this patch:
 https://lore.kernel.org/all/20230917170629.d35gnwb6o54bdrhl@box.shutemov.name

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
