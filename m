Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F41BEA95
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2VzR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2VzQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 17:55:16 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5121020B1F;
        Wed, 29 Apr 2020 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588197316;
        bh=vewqOcHFnU47ZJ5WNNQy7fqQ0TcKyqwkwZMTG3+vyhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KAx2y1B42AP9M4XQw3RqJaR9BwgRY3SneHaE2rbaSTXnJr5GM23JOgOGMOqObwHPa
         6TqyRM/D6WzYbASRcZjuC5r3tKYMc1CP/9qijqELGStK3CAA4PfwrN5Agd04J6Spo8
         HbsOnlt8FV0umJICUw1wAm6eT+ZAEYqURhOh4/ao=
Received: by mail-io1-f51.google.com with SMTP id w4so3954396ioc.6;
        Wed, 29 Apr 2020 14:55:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuYmEq7zUY0scsP74DOvM7xnvllXykgf9TYi31RUUyg4dorLpLfY
        txrLewQPlay22/AnLt6WLtVFZTGWaCo/tlla53c=
X-Google-Smtp-Source: APiQypItj/kGtyqj70QsmARttGhJeM/nKI8NF6Q8BeFnmaxVwj64QgMRsuRBkqyngrJSAaO/IzhFsrJpRKlozWSRvko=
X-Received: by 2002:a02:969a:: with SMTP id w26mr142960jai.71.1588197315770;
 Wed, 29 Apr 2020 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
 <20200429214332.GC1621173@rani.riverdale.lan> <31b23951ee2b8e2391f3208b60a7132df18be74e.camel@perches.com>
In-Reply-To: <31b23951ee2b8e2391f3208b60a7132df18be74e.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 23:55:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJfK=tspytknqdABRfYMhA23FWOs8QoasX1jZ6z=F3Gg@mail.gmail.com>
Message-ID: <CAMj1kXFJfK=tspytknqdABRfYMhA23FWOs8QoasX1jZ6z=F3Gg@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 23:53, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-04-29 at 17:43 -0400, Arvind Sankar wrote:
> > On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > > >
> > > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > > so it's clearer it's a typical efi_ logging function.
> > > >
> > > > $ git grep -w --name-only pr_efi_err | \
> > > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > > >
> > >
> > > Yeah, pr_efi_err() is probably not the best name
> >
> > Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?
>
> Perhaps not use pr_ in the name at all.
>
> I suggest:
>
> pr_efi          -> efi_info (or efi_debug or efi_dbg)
>                    (it is guarded by an efi_quiet flag, default: on)
> pr_efi_err      -> efi_err
>

Agreed. Shorter is better if there is no risk of confusion..
