Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6015F1004A0
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2019 12:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRLpl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 06:45:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:41985 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfKRLpk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Nov 2019 06:45:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 03:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="258386847"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2019 03:45:38 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iWfTO-0000zc-1E; Mon, 18 Nov 2019 13:45:38 +0200
Date:   Mon, 18 Nov 2019 13:45:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v3] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191118114538.GV32742@smile.fi.intel.com>
References: <20191115153102.51921-1-andriy.shevchenko@linux.intel.com>
 <CAKv+Gu9wKQ_yXjfkB6-6f8Tfu+cfpSNnxn04ZqExYxuPSQS-ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9wKQ_yXjfkB6-6f8Tfu+cfpSNnxn04ZqExYxuPSQS-ww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 15, 2019 at 04:28:10PM +0000, Ard Biesheuvel wrote:
> On Fri, 15 Nov 2019 at 15:31, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> > into generic earlycon implementation") moved x86 specific EFI earlyprintk
> > implementation to shared location it also tweaked the behaviour. In particular
> > it dropped a trick with full framebuffer remapping after page initialization.
> > This lead to two regressions:
> > 1) very slow scrolling after page initialization;
> > 2) kernel hang when keep_bootcon parameter is being provided.
> >
> > Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> > slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> > operations per each pixel line on the screen.

> > +/*
> > + * efi earlycon needs to use early_memremap() to map the framebuffer.
> > + * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
> > + * memremap() should be used instead. memremap() will be available after
> > + * paging_init() which is earlier than initcall callbacks. Thus adding this
> > + * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
> > + */
> > +static int __init early_efi_map_fb(void)
> > +{
> > +       if (!fb_base || !fb_size)
> > +               return NULL;
> > +
> 
> 'return 0' please.

Ah, sorry. Though I think we rather return -ENOVEV here.

> I'll test this on actual arm64 hardware somewhere next week, and queue
> it if it doesn't break anything (no need to resend for the above)

Thanks!

> > +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WB);
> > +       else
> > +               efi_fb = memremap(fb_base, fb_size, MEMREMAP_WC);
> > +
> > +       return efi_fb ? 0 : -ENOMEM;
> > +}
> > +early_initcall(early_efi_map_fb);

-- 
With Best Regards,
Andy Shevchenko


