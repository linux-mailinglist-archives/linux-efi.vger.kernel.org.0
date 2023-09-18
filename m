Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E67A495B
	for <lists+linux-efi@lfdr.de>; Mon, 18 Sep 2023 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbjIRMOF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Sep 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbjIRMNx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Sep 2023 08:13:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818BA0
        for <linux-efi@vger.kernel.org>; Mon, 18 Sep 2023 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695039204; x=1726575204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6uJo9fVMUcgKXeNQrEhW6advvpO2XMkvObE1BHC4H5A=;
  b=WXkWfSn8luy1in2hvdthbRTfWWVdTKf7pN8ywHmS0bd3jS4zvAnPfPP9
   vAYt1tjUtWhyjFWQ09+0JbxVkW3Ama54K+xVXiuUHSnDznS+xzTjGV/Tm
   iljZoNKFRV9EUpf5ki0QsUSA4Mag1JR+gmZ5cFWhuXw1t46OmDgrB+4TZ
   YepzDE4JdB4HBLzUih448WVEMEvXGDdNUJbenEiy/q+D6DE8Cu2G8arQM
   iPanxkOlL5GzPauipoiVdjTBIvDRHL7r4TkHcBBpuM6JEyeJmKIyI1wbV
   zMnLf7Ibw7B0yJwZnJ/4X3Nc4+xPHtuaSlF1peVna7GsrtVavgpWgLW3z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383458589"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383458589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722444344"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="722444344"
Received: from ppuente-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.47.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 05:12:44 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5AA6A109E26; Mon, 18 Sep 2023 15:12:41 +0300 (+03)
Date:   Mon, 18 Sep 2023 15:12:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org, Hongyu Ning <hongyu.ning@intel.com>
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI
 ranges
Message-ID: <20230918121241.5zbplrgao7ybvv5n@box.shutemov.name>
References: <20230816190557.3738-1-ardb@kernel.org>
 <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
 <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
 <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
 <20230907104914.a4nt23yuronohivo@box.shutemov.name>
 <20230917170629.d35gnwb6o54bdrhl@box.shutemov.name>
 <CAMj1kXF3BgEpZDpzfLm0=1cdSUy0ovb6Uog17em58=YLHaADug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF3BgEpZDpzfLm0=1cdSUy0ovb6Uog17em58=YLHaADug@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 18, 2023 at 09:01:27AM +0200, Ard Biesheuvel wrote:
> On Sun, 17 Sept 2023 at 19:06, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Thu, Sep 07, 2023 at 01:49:14PM +0300, Kirill A. Shutemov wrote:
> > > On Wed, Sep 06, 2023 at 11:17:12AM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > > > > > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > > > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > > > >
> > > > > > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > > > > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > > > > > not going to be present in the direct mapping.
> > > > > > >
> > > > > > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > > > > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > > > > > calculation.
> > > > > > >
> > > > > > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > > > > > tables and might be required by kernel to function properly.
> > > > > > >
> > > > > > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > > > > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > > > > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > > > > > can fit under the last E820_TYPE_ACPI range.
> > > > > > >
> > > > > > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > > > > > E820_TYPE_ACPI memory.
> > > > > > >
> > > > > > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > > > > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > > > > > it between the kernels on kexec.
> > > > > > >
> > > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > >
> > > > > > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > > > > > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > > > > > memory that can be used by the OS as ordinary RAM if it is not
> > > > > > interested in the contents (or has already consumed them). So this
> > > > > > could arguably be classified as E820_TYPE_RAM too.
> > > > >
> > > > > Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> > > > > IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> > > > > kexec, regardless if it is crash kernel or not. I'm not sure we would not
> > > > > break anything.
> > > > >
> > > >
> > > > Yeah, you're right. So this patch is necessary in any case.
> > > >
> > > > Do we also need the EFI side patch then?
> > >
> > > Yes, we need it to get it mapped into the crashkernel direct mapping.
> >
> > Ughh. The patch alone causes crash as EFI_ACPI_RELACLAIM_MEMORY is not
> > mapped into direct mapping during memory init.
> >
> 
> It would be good if this boot path could be covered by lkp@ as well -
> currently, you are the only person testing this manually. The same
> applies to SEV-SNP by the way - there is zero coverage except for the
> manual testing that Boris or Tom Lendacky might do.

It made me remember that I forgot attribute the finding:

Reported-by: "Hongyu Ning" <hongyu.ning@intel.com>

Hongyu tests linux-next periodically, but I agree we need to get LKP
working.

I will try to get LKP going for TDX guest.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
