Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16411A99C
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLKLEi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 06:04:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:61416 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfLKLEi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Dec 2019 06:04:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 03:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="387897640"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2019 03:04:35 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieznH-0005F3-M2; Wed, 11 Dec 2019 13:04:35 +0200
Date:   Wed, 11 Dec 2019 13:04:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191211110435.GP32742@smile.fi.intel.com>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 08:22:56AM +0000, Ard Biesheuvel wrote:
> (+ Andy)
> 
> On Wed, 11 Dec 2019 at 00:24, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On x86, until PAT is initialized, WC translates into UC-. Since we
> > calculate and store pgprot_writecombine(PAGE_KERNEL) when earlycon is
> > initialized, this means we actually use UC- mappings instead of WC
> > mappings, which makes scrolling very slow.
> >
> > Instead store a boolean flag to indicate whether we want to use
> > writeback or write-combine mappings, and recalculate the actual pgprot_t
> > we need on every mapping. Once PAT is initialized, we will start using
> > write-combine mappings, which speeds up the scrolling considerably.
> >
> > Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Make sense.
One comment below.

> > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > -       else
> > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);

I would really like to keep the style with if-else.

-- 
With Best Regards,
Andy Shevchenko


