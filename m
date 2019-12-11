Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7742D11BAF4
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfLKSDc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 13:03:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:5652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfLKSDc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 11 Dec 2019 13:03:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 10:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="210846928"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2019 10:03:30 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1if6Kg-0003jU-5G; Wed, 11 Dec 2019 20:03:30 +0200
Date:   Wed, 11 Dec 2019 20:03:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191211180330.GZ32742@smile.fi.intel.com>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
 <20191211173746.GA220404@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211173746.GA220404@rani.riverdale.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 12:37:46PM -0500, Arvind Sankar wrote:
> On Wed, Dec 11, 2019 at 01:04:35PM +0200, Andy Shevchenko wrote:
> > 
> > Make sense.
> > One comment below.
> > 
> > > > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > > > -       else
> > > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > > > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > > > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> > 
> > I would really like to keep the style with if-else.
> > 
> I edited this back to the if/else and then realized why I chose the
> ternary. It makes it easier for the reader to see that the only thing
> that depends on fb_wb is the MEMREMAP_ flag that gets used, while with
> the if/else the reader needs to compare both function invocations to see
> that that's the only difference.
> 
> It's not a big deal, so if you still prefer the if/else I'll revise the
> patch.

Perhaps comment near to if can explain this.

-- 
With Best Regards,
Andy Shevchenko


