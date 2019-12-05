Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC31147D7
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 20:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfLETtd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 14:49:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:9362 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfLETtc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Dec 2019 14:49:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 11:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="411759581"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2019 11:49:30 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1icx7z-0005Sj-19; Thu, 05 Dec 2019 21:49:31 +0200
Date:   Thu, 5 Dec 2019 21:49:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191205194931.GB32742@smile.fi.intel.com>
References: <20191205164248.14511-1-ardb@kernel.org>
 <20191205185632.GA32742@smile.fi.intel.com>
 <CAKv+Gu8iRfNVAywXvXxEOvV=OTwbCZ62rBDWDV2JdDZpXSRkrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8iRfNVAywXvXxEOvV=OTwbCZ62rBDWDV2JdDZpXSRkrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 05, 2019 at 07:02:56PM +0000, Ard Biesheuvel wrote:
> On Thu, 5 Dec 2019 at 18:56, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Dec 05, 2019 at 04:42:48PM +0000, Ard Biesheuvel wrote:

> > > +static int __init efi_earlycon_unmap_fb(void)
> > > +{
> > > +     /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
> >
> > > +     if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
> >
> > Isn't efi_fb test superfluous here?
> >
> 
> Well, it could be NULL so it is not superfluous. The initcall() is
> always executed, even if you are not using earlycon=efifb at all.

My point is that memunmap() is no-op for NULL pointer, isn't it?

> > > +             memunmap(efi_fb);
> >
> > > +     return 0;
> > > +}
> > > +late_initcall(efi_earlycon_unmap_fb);

> > I still think we need __exitcall() to clean up the stuff in any case.
> >
> 
> Why? As far as I can tell, exitcalls go straight into a /DISCARD/
> section, and I really don't see the point of carrying dead code in
> this file.

Okay.

-- 
With Best Regards,
Andy Shevchenko


