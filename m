Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5B780EE8
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357204AbjHRPQy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378095AbjHRPQf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 11:16:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C63A9C
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692371793; x=1723907793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zdNpbh5ASGJ1eeGtp9D+iPY0KTvXBC4CzeSOZ0e1hxY=;
  b=jex+166AV2LvJvIjk0dFqFuhHP+1zgiMV1TLaCwMrdgRfEC4G3/zjlQ+
   Wm1siY0s7bN79xkd9mTjPd5Aq44aQZjtiLQgH+eNrLyBG3SAe15iGvWX+
   ZX0Ryv/vx4RrvQac5r31TTKHpryIC74MUo7eiifJM9YbBLJrtJ5YnJnuF
   g28MsDwG7AL5RkHk1xVb1kcz3yVpg6/Q6f7GnFsSk5iTm3FyJjybUNNiE
   EE9M/jgUefJz0iu4g4k6iz8QfqjCmAN+2gQV2JA14yi/MLblVTJ0qkXej
   pSp2eg0tWh8+zXG9P4tc1XBpAlHDLK9OQbxgZqFkWNP7cdmk9N1gd/MJK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372023529"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372023529"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="825145828"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="825145828"
Received: from hleonha-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:16:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B548D109E16; Fri, 18 Aug 2023 18:16:28 +0300 (+03)
Date:   Fri, 18 Aug 2023 18:16:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI
 ranges
Message-ID: <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
References: <20230816190557.3738-1-ardb@kernel.org>
 <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > things, guides where direct mapping ends. Any memory above max_pfn is
> > not going to be present in the direct mapping.
> >
> > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > calculation.
> >
> > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > tables and might be required by kernel to function properly.
> >
> > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > can fit under the last E820_TYPE_ACPI range.
> >
> > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > E820_TYPE_ACPI memory.
> >
> > The problem was discovered during debugging kexec for TDX guest. TDX
> > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > it between the kernels on kexec.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> No objections to this, but we might also simply drop E820_TYPE_ACPI
> altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> memory that can be used by the OS as ordinary RAM if it is not
> interested in the contents (or has already consumed them). So this
> could arguably be classified as E820_TYPE_RAM too.

Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
kexec, regardless if it is crash kernel or not. I'm not sure we would not
break anything.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
