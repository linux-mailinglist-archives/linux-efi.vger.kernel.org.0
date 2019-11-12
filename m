Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C401CF9545
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLQNX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 11:13:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:59626 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLQNX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 Nov 2019 11:13:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 08:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="229440427"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2019 08:13:21 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iUYnA-0003wY-DX; Tue, 12 Nov 2019 18:13:20 +0200
Date:   Tue, 12 Nov 2019 18:13:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexander Graf <agraf@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v1] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191112161320.GW32742@smile.fi.intel.com>
References: <20191111154413.1505-1-andriy.shevchenko@linux.intel.com>
 <CAKv+Gu_R1mprDnYUS0HWR2XOWysZnO6AnEt_XkfwzZZVcg64XQ@mail.gmail.com>
 <20191112125754.GS32742@smile.fi.intel.com>
 <20191112125920.GT32742@smile.fi.intel.com>
 <CAKv+Gu9opwMvtnOjw3kU0=xsBidrx4pp2B-JF-c_ij==LFnSEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9opwMvtnOjw3kU0=xsBidrx4pp2B-JF-c_ij==LFnSEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 12, 2019 at 01:31:11PM +0000, Ard Biesheuvel wrote:
> On Tue, 12 Nov 2019 at 12:59, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Nov 12, 2019 at 02:57:54PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 11, 2019 at 05:59:42PM +0000, Ard Biesheuvel wrote:
> > > > On Mon, 11 Nov 2019 at 15:44, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

> > > > Will there be a user for this routine? If not, can we just drop it?
> > >
> > > The same question can be applied to the driver core part(s), e.g.
> > > deferred_probe_exit() in dd.c).
> >
> > I noted that I missed __exitcall() here. But will wait for your answer.
> >
> 
> Ah ok, then it makes sense. Mind respinning with that added?

Done!

> > > The above basically what Greg KH told people to do. While it is partially cargo
> > > cult here I can imagine that in some environments (virtual or kexec) somebody
> > > would like to get a picture of (post-mortem?) analysis where it would be
> > > helpful. Also code looks symmetrical in order to resource management. So, if
> > > you insist, I'll remove it, although I personally like my variant.

-- 
With Best Regards,
Andy Shevchenko


