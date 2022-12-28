Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F5D657772
	for <lists+linux-efi@lfdr.de>; Wed, 28 Dec 2022 15:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiL1OEM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Dec 2022 09:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1OEL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Dec 2022 09:04:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E11099;
        Wed, 28 Dec 2022 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672236249; x=1703772249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lg126dF0ZRB51ZzT/H9t/6uTcxQgkla19QDrEd0Bge0=;
  b=c2iP/ZA0uWkDdxNpHAOp0YCPyjxlv8h7aQGjKTZMRR6SF9YaM3bfiYBo
   znnuls8vYhO1gaLI8oWuZ0LS1uu7CDIFWchzA0Bm52jf8k1gXX5ukVRGS
   yQjFCK/Uyg1WSsPnfwkU1I6ZkA2N0fP+v7wT7LJci5FMbxPvNgbNBQ3Sb
   trJLLyHX6b08mMxFr3/IEyVreRUFb8JhUOZscI71WMkXsnHO3DCKYLE6h
   MhiDvWFxat86ZuPres05zdP8WimKmqBfpkojgFFT29JBeuJ4L8HEUyf0f
   RzMhpsKGuVkrBKvQjXmNvZlxeTh770iy7IgB4+Iowwg9wednRPRO6uk59
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="308631762"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="308631762"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 06:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="655320885"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="655320885"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2022 06:03:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAX1S-000cPm-1R;
        Wed, 28 Dec 2022 16:03:10 +0200
Date:   Wed, 28 Dec 2022 16:03:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jami Kettunen <jami.kettunen@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] Add generic framebuffer support to EFI earlycon
 driver
Message-ID: <Y6xMnuMqpThmFn1q@smile.fi.intel.com>
References: <20221221105402.6598-1-markuss.broks@gmail.com>
 <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGUC7dsSwVEUsAMeAoqDYtbqrM7SDOJTXbPfi-LrcSk9g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 23, 2022 at 03:42:33PM +0100, Ard Biesheuvel wrote:
> (cc Andy)

I believe there are two reasons I'm Cc'ed now:
- the Cc was forgotten. because I remember reviewing some parts
  of this contribution
- this conflicts (to some extent) with my patch that speeds up
  the scrolling

For the first it's obvious what to do, I think Markuss can include me
in his v4.

For the second I don't see the functional clash. The scrolling in this
series is not anyhow optimized. I think my patch should go first as
- it is less intrusive
- it has been tested, or can be tested easily

Tell me if I'm missing something here.

> On Wed, 21 Dec 2022 at 11:54, Markuss Broks <markuss.broks@gmail.com> wrote:
> >
> > Make the EFI earlycon driver be suitable for any linear framebuffers.
> > This should be helpful for early porting of boards with no other means of
> > output, like smartphones/tablets. There seems to be an issue with early_ioremap
> > function on ARM32, but I am unable to find the exact cause. It appears the mappings
> > returned by it are somehow incorrect, thus the driver is disabled on ARM.
> 
> The reason that this driver is disabled on ARM is because the struct
> screen_info is not populated early enough, as it is retrieved from a
> UEFI configuration table.
> 
> early_ioremap() works fine on ARM as long as they mapping is torn down
> before paging_init()
> 
> > EFI early
> > console was disabled on IA64 previously because of missing early_memremap_prot,
> > and this is inherited to this driver.
> >
> > This patch also changes
> 
> "This patch also changes ..." is usually a strong hint to self that
> the patches need to be split up.
> 
> > behavior on EFI systems, by selecting the mapping type
> > based on if the framebuffer region intersects with system RAM. If it does, it's
> > common sense that it should be in RAM as a whole, and so the system RAM mapping is
> > used. It was tested to be working on my PC (Intel Z490 platform), as well as several
> > ARM64 boards (Samsung Galaxy S9 (Exynos), iPad Air 2, Xiaomi Mi Pad 4, ...).

-- 
With Best Regards,
Andy Shevchenko


