Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F21BFFD7
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD3POW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 11:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgD3POV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 11:14:21 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1B320661;
        Thu, 30 Apr 2020 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588259661;
        bh=KMGeU6nz29vrM1uYO0a3kTVAV4cJFx0s+w9L3Ywf0pI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TT7oatkHmj3/y+HBS5xZ+Qb8BlnZyRCmMd01I/Fi4IGDRianFaX2gJjieNuIOmDC8
         zkgA6dPqNohx+byuPdjelqKTvqVCfOXa7jel5IBYvHPG9OHCSGRKmC3Z0YFhpcFUVs
         KdRlWEddm8YUeJZT4UxoO6CCDl1cPPxmnhdsM1zg=
Received: by mail-io1-f53.google.com with SMTP id b12so1826687ion.8;
        Thu, 30 Apr 2020 08:14:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuaUlK6QwYD4xVFCEM7LS23VU52o2JbWtsh1DjuX/mTvzT82lCG5
        l00xQmlcL9QO6eL+QYpuVBsVAQv6DC0Fxq3bf8Q=
X-Google-Smtp-Source: APiQypISgwQ0ge6OQUtXTqQAtwh9HUtZQ4CGAaRQizRfjz+lvojsquMeqkYNr8DKAedRWB3z3tEWNdRBHjK1qZCKbiM=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr2356911iom.171.1588259660396;
 Thu, 30 Apr 2020 08:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
 <20200429214332.GC1621173@rani.riverdale.lan> <31b23951ee2b8e2391f3208b60a7132df18be74e.camel@perches.com>
 <CAMj1kXFJfK=tspytknqdABRfYMhA23FWOs8QoasX1jZ6z=F3Gg@mail.gmail.com> <20200429222057.GA1645040@rani.riverdale.lan>
In-Reply-To: <20200429222057.GA1645040@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 17:14:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCetKOZ86JmTbPUL9koq7=n8fRcWtctf7Xzi5mWaP2Bg@mail.gmail.com>
Message-ID: <CAMj1kXGCetKOZ86JmTbPUL9koq7=n8fRcWtctf7Xzi5mWaP2Bg@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joe Perches <joe@perches.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 00:21, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Apr 29, 2020 at 11:55:04PM +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 23:53, Joe Perches <joe@perches.com> wrote:
> > >
> > > On Wed, 2020-04-29 at 17:43 -0400, Arvind Sankar wrote:
> > > > On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > > > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > > > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > > > > >
> > > > > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > > > > so it's clearer it's a typical efi_ logging function.
> > > > > >
> > > > > > $ git grep -w --name-only pr_efi_err | \
> > > > > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > > > > >
> > > > >
> > > > > Yeah, pr_efi_err() is probably not the best name
> > > >
> > > > Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?
> > >
> > > Perhaps not use pr_ in the name at all.
> > >
> > > I suggest:
> > >
> > > pr_efi          -> efi_info (or efi_debug or efi_dbg)
> > >                    (it is guarded by an efi_quiet flag, default: on)
> > > pr_efi_err      -> efi_err
> > >
> >
> > Agreed. Shorter is better if there is no risk of confusion..
>
> Ok, I'll use efi_info/efi_err. We could add debugging output as
> efi_debug later, enabled if efi=debug is specified.
>
> While we're here: most of the existing cases of pr_efi look like notice
> or info level, except maybe these two, which probably should be at least
> warnings?
>
> drivers/firmware/efi/libstub/arm64-stub.c
> 62: pr_efi("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
>

This should not be a warning. KASLR is enabled by default by the
distros, and many systems don't implement this protocol at all.

> drivers/firmware/efi/libstub/efi-stub.c
> 254: pr_efi("Ignoring DTB from command line.\n");

That could be upgraded to an error.
