Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB7797567
	for <lists+linux-efi@lfdr.de>; Thu,  7 Sep 2023 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjIGPrJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Sep 2023 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345036AbjIGPe0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Sep 2023 11:34:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C21BF
        for <linux-efi@vger.kernel.org>; Thu,  7 Sep 2023 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100847; x=1725636847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5V4mTl4sKZuPwFZuzzeqQlL1o2w130raoN5ENI0DL78=;
  b=CRQo0Ywlt1am9avFodLWlzIaNt+ZhTXOPHPnFn0Ms2oqe24sP/8bHJLU
   ZZgWltKoxt6fsoDaNUeN5mMKZaMAPNhCBqAjUkXTD2fgcs92KInN9bfIP
   1tqi+pJlUZdosk8NAhuHXjIkUBvESFZBsSztXOQ4fNQUt+yBEdx/rGimo
   KuBbVvRjwzJMxH8kcSPH5T4Z0nWewdcqkgIsOC2fzr8kLChKNJG+hzsEH
   PSZvxjj4Ot77S3SYbs1J9Kcvzo9wX/I3k3sU/C4rlamHHoHG2vUOM5gKp
   SFudalgDWijYGy7yP4To/ZrsfMdBBVnWr75eyu2mvYrVa15kjQ7D7jDb3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408319701"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="408319701"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="807498148"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="807498148"
Received: from rbhaumik-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.38])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 03:49:17 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6FCD910485E; Thu,  7 Sep 2023 13:49:14 +0300 (+03)
Date:   Thu, 7 Sep 2023 13:49:14 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI
 ranges
Message-ID: <20230907104914.a4nt23yuronohivo@box.shutemov.name>
References: <20230816190557.3738-1-ardb@kernel.org>
 <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
 <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
 <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 06, 2023 at 11:17:12AM +0200, Ard Biesheuvel wrote:
> On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > > not going to be present in the direct mapping.
> > > >
> > > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > > calculation.
> > > >
> > > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > > tables and might be required by kernel to function properly.
> > > >
> > > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > > can fit under the last E820_TYPE_ACPI range.
> > > >
> > > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > > E820_TYPE_ACPI memory.
> > > >
> > > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > > it between the kernels on kexec.
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > >
> > > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > > memory that can be used by the OS as ordinary RAM if it is not
> > > interested in the contents (or has already consumed them). So this
> > > could arguably be classified as E820_TYPE_RAM too.
> >
> > Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> > IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> > kexec, regardless if it is crash kernel or not. I'm not sure we would not
> > break anything.
> >
> 
> Yeah, you're right. So this patch is necessary in any case.
> 
> Do we also need the EFI side patch then?

Yes, we need it to get it mapped into the crashkernel direct mapping.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
