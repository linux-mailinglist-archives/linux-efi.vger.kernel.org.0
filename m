Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97E365F4
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2019 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFEUso (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jun 2019 16:48:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42348 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUso (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jun 2019 16:48:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so11796947pgd.9
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gf36/FJbmvcIKQB71SoUxqFxDnsf/YtRh42eY1Za4A8=;
        b=WVI7T+qZtVEnyq5ZQtNNc6p8ErkwczAYREEK8DBsct2+ctCli/t1y+PGIeTMbkm3fo
         SstGkCzPWEb+Cx6li46d+n9sAQMufEh3WYdaLmWqU9b6lyPJ8lYKCCjcUzoMeJxfosx2
         drDkUF7J+5+mqVVkquXPaNaVMItINGIoMemq93eMTsMaVY0U6ACrdh9NtYefm357B5PH
         3w/wOk/4Y9PkD62xH7O573/32c2sugfS5y/ofkpiwKOgU2wPekGDUGQ64Sg8etaLiSGV
         IAXvSYStLoGg1BznpPh3rJcDmObUGqtNviYlYyljrGyrN2EyPxXuS6RaFg7JmQf0gZh5
         aqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf36/FJbmvcIKQB71SoUxqFxDnsf/YtRh42eY1Za4A8=;
        b=fJ9QbrU5D4Re2zsPCmkQYrBZoxDmgWzMkwSBa34qYdFaOID5pslgl3bPGhnA1OnxpT
         3YR8sTw9IYoafS6mVaqNJYHNfpUxdepgSQHfqLffDjbewVemAdg6uFpqvrHYFEZbc4zi
         lrXGMG/+CYo14ddMLbUkuGxsUsvmRK8l4O0oJr6V+U32zRsXqOKakB+vK9hMgoikwdOM
         NZz1nfBh/6XBwy+Uy3hTqck2Lff0DNa1YifaigV234ZsEThO3LxAQBE7fIjbvdJqyh1L
         Ed1Gx5N5YjNVEMg5mSMDCBrt/FGHrUYnwiX1RgkPnOI/6CuWJiF6GPreJSSAokyX+bwi
         CDfQ==
X-Gm-Message-State: APjAAAWY2FdzrGaK+7+wUclNaKeDjEJxa3b9ELSx9mds1S+Y61iuNatJ
        HPE6Wk/1WNWpYuQnZWBRwfSzMfDPr3f8alpb+fF0bg==
X-Google-Smtp-Source: APXvYqw04eb//flZxwX52rlKUE9uC5FQrN/EPO3Y+b+R/m9mxJBjNW8wJAFNaE/R9u6bPF2yyHx+uo26PEQ6Qbdgmds=
X-Received: by 2002:a63:52:: with SMTP id 79mr829652pga.381.1559767722964;
 Wed, 05 Jun 2019 13:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <CAKv+Gu9QkKwNVpfpQP7uDd2-66jU=qkeA7=0RAoO4TNaSbG+tg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9QkKwNVpfpQP7uDd2-66jU=qkeA7=0RAoO4TNaSbG+tg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 13:48:31 -0700
Message-ID: <CAKwvOdnPcjESFrQRR_=cCVag3ZSnC0nBqF7+LFHrcDArT_segA@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rolf Eike Beer <eb@emlix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 5, 2019 at 11:42 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> For the record, this is an example of why I think backporting those
> clang enablement patches is a bad idea.

There's always a risk involved with backports of any kind; more CI
coverage can help us mitigate some of these risks in an automated
fashion before we get user reports like this.  I meet with the
KernelCI folks weekly, so I'll double check on the coverage of the
stable tree's branches.  The 0day folks are also very responsive and
I've spoken with them a few times, so I'll try to get to the bottom of
why this wasn't reported by either of those.

Also, these patches help keep Android, CrOS, and Google internal
production kernels closer to their upstream sources.

> We can't actually build those
> kernels with clang, can we? So what is the point? </grumpy>

Here's last night's build:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/114388434

Also, Android and CrOS have shipped X million devices w/ 4.9 kernels
built with Clang.  I think this number will grow at least one order of
magnitude imminently.

> Alternatively, we can just revert this patch from 4.9

That would break at least the above devices next time Android and CrOS
pulled from stable.

> It would be helpful to get a relocation dump (objdump -r) of
> arm64-stub.o to figure out which symbol needs a 'hidden' annotation to
> prevent GCC from emitting it as a PIC reference requiring a GOT.

Sounds like the best way forward, as well as having more info on which
config/toolchain reliably reproduces the issue.
-- 
Thanks,
~Nick Desaulniers
