Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFABB1BEA21
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2Vp3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2Vp3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 17:45:29 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E0A20B1F;
        Wed, 29 Apr 2020 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588196729;
        bh=tpeSM1vsDeSpaKu9bzhZIWUim1mJQ30ld7nfSES7kCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FNMpG+AxknGdENQag5cUYKLL0LMpjMpgnn3/0Wk9fd3i+O+r1oo7zT4KPatiCw+0u
         VrAKYdzSdtOX0zEqSssqei5qOPelpSDkuhD4M3LxTmdEI/Q1hrvmv3h4oO6EZMAvjc
         7UMIqg7O64eFzS2RAqPvs0c4HZKZRL1iNpCjTGoA=
Received: by mail-il1-f170.google.com with SMTP id e8so3969314ilm.7;
        Wed, 29 Apr 2020 14:45:29 -0700 (PDT)
X-Gm-Message-State: AGi0PuZH/Fp65Id+ljO9VFrC/Jil1PjCn0wMcOE4XpT8wLMMUscdJz/h
        ew8ipGmupKF/uCEj0Tnhc2ZLHJHpeSoERkr1QmU=
X-Google-Smtp-Source: APiQypL1JaMHgz4OgmKvN5ChzpZw1ME6KC1/f01aao5bV2TihDfwlHKORMqrCsyljOihr9jKB85BJiEOFl7aEWp3ZuA=
X-Received: by 2002:a92:405:: with SMTP id 5mr388881ile.279.1588196728525;
 Wed, 29 Apr 2020 14:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com> <20200429214332.GC1621173@rani.riverdale.lan>
In-Reply-To: <20200429214332.GC1621173@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 23:45:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwvtQoWj2GjMzLY+wnaMu9cUP8jRpwuQBC0fpEy31r_w@mail.gmail.com>
Message-ID: <CAMj1kXEwvtQoWj2GjMzLY+wnaMu9cUP8jRpwuQBC0fpEy31r_w@mail.gmail.com>
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

On Wed, 29 Apr 2020 at 23:43, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > >
> > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > >
> > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > to it's clearer it's a typical efi_ logging function.
> > >
> > > $ git grep -w --name-only pr_efi_err | \
> > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > >
> >
> > Yeah, pr_efi_err() is probably not the best name
>
> Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?

If you don't mind spinning another couple of patches, yes, that would
be helpful.

Let's use efi_pr_info and efi_pr_err to stay aligned with the ordinary
counterparts
