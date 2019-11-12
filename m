Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3AF9014
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLM7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 07:59:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:60741 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfKLM7X (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 Nov 2019 07:59:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 04:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; 
   d="scan'208";a="287537630"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2019 04:59:21 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iUVlQ-0000Z8-Rm; Tue, 12 Nov 2019 14:59:20 +0200
Date:   Tue, 12 Nov 2019 14:59:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v1] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191112125920.GT32742@smile.fi.intel.com>
References: <20191111154413.1505-1-andriy.shevchenko@linux.intel.com>
 <CAKv+Gu_R1mprDnYUS0HWR2XOWysZnO6AnEt_XkfwzZZVcg64XQ@mail.gmail.com>
 <20191112125754.GS32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112125754.GS32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 12, 2019 at 02:57:54PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 11, 2019 at 05:59:42PM +0000, Ard Biesheuvel wrote:
> > On Mon, 11 Nov 2019 at 15:44, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > When the commit 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk
> > > into generic earlycon implementation") moved x86 specific EFI earlyprintk
> > > implementation to shared location it also tweaked the behaviour. In particular
> > > it dropped a trick with full framebuffer remapping after page initialization.
> > > This lead to two regressions:
> > > 1) very slow scrolling after page initialization;
> > > 2) kernel hang when keep_bootcon parameter is being provided.
> > >
> > > Returning the trick back fixes #2 and mitigates, i.e. reduces the window when
> > > slowness appears, #1 presumably due to eliminating heavy map()/unmap()
> > > operations per each pixel line on the screen.
> 
> > Thanks for fixing this. One question below.
> > 
> > > +static __init int early_efi_map_fb(void)
> > > +{
> > > +       u32 size;
> > > +
> > > +       size = screen_info.lfb_size;
> > > +       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > +               efi_fb = memremap(fb_base, size, MEMREMAP_WB);
> > > +       else
> > > +               efi_fb = memremap(fb_base, size, MEMREMAP_WC);
> > > +
> > > +       return efi_fb ? 0 : -ENOMEM;
> > > +}
> > > +early_initcall(early_efi_map_fb);
> > > +
> > > +static __exit void early_efi_unmap_fb(void)
> > 
> > Will there be a user for this routine? If not, can we just drop it?
> 
> The same question can be applied to the driver core part(s), e.g.
> deferred_probe_exit() in dd.c).

I noted that I missed __exitcall() here. But will wait for your answer.

> The above basically what Greg KH told people to do. While it is partially cargo
> cult here I can imagine that in some environments (virtual or kexec) somebody
> would like to get a picture of (post-mortem?) analysis where it would be
> helpful. Also code looks symmetrical in order to resource management. So, if
> you insist, I'll remove it, although I personally like my variant.
> 
> > > +{
> > > +       memunmap(efi_fb);
> > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


