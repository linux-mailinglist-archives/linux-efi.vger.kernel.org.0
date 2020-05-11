Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E711CE733
	for <lists+linux-efi@lfdr.de>; Mon, 11 May 2020 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgEKVNN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 May 2020 17:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgEKVNM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 11 May 2020 17:13:12 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9A720836;
        Mon, 11 May 2020 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589231592;
        bh=ZI2lj3is6y0WchsCEaGFt9C+Mv/t+oJAuodr5NVvGVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JZ+sXeEWBY15F0GSAKXGtEhq0BXaj71w4iU7jNJD1n37bsF6ra7cpm4y7GOPAj9cy
         l4CvkAe8ZOJEACWZKVMQdoZI1D1i2xXwZgw2jJCcI4xEcwapzrPXcnch4mpBPEGjhb
         c7GXSMqdJFWO/pZe7/a5aZe1gc6Ew7kFPtDpK/ls=
Received: by mail-io1-f42.google.com with SMTP id k6so11546488iob.3;
        Mon, 11 May 2020 14:13:12 -0700 (PDT)
X-Gm-Message-State: AGi0PuahFCQO3w4s9O1tj3hM31g+7eg1UqNEI5KJ228bY5dW7wxxXrSf
        1VySNbDGdVwJ4eACgGUb8RzEz69JG1jchS0Wicc=
X-Google-Smtp-Source: APiQypKsrTNjd0F5cALpEZ3tpFgaLX7knF8kFxCzKte5s6IA12Qh/fG+QsbySsySG3q9jj83ikbre5+eS2DXGx42Qi8=
X-Received: by 2002:a02:3341:: with SMTP id k1mr17753312jak.74.1589231591525;
 Mon, 11 May 2020 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200303221205.4048668-5-nivedita@alum.mit.edu>
 <20200511170149.1363260-1-mike@fireburn.co.uk> <20200511183645.GA596850@rani.riverdale.lan>
In-Reply-To: <20200511183645.GA596850@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 May 2020 23:13:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmJRpVyWDVkBn9eL0y0J4iVrUkYZd_pk_oKOeQPH661g@mail.gmail.com>
Message-ID: <CAMj1kXEmJRpVyWDVkBn9eL0y0J4iVrUkYZd_pk_oKOeQPH661g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] efi/x86: Remove extra headroom for setup block
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Mike Lothian <mike@fireburn.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 May 2020 at 20:36, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, May 11, 2020 at 06:01:49PM +0100, Mike Lothian wrote:
> > Hi
> >
> > This patch has been causing issues for me since switching to GCC 10.1:
> >
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CHK     include/generated/compile.h
> >   HOSTCC  arch/x86/boot/tools/build
> > /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: error: linker defined: multiple definition of '_end'
> > /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: /tmp/ccEkW0jM.o: previous definition here
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
> > make: *** [arch/x86/Makefile:303: bzImage] Error 2
> >
> > Cheers
> >
> > Mike
>
> I'm not getting an error even with gcc 10 for some reason, but I can see
> that it is busted. It's using the linker-defined _end symbol which is
> just pass the end of the .bss.
>
> Does adding "static" to the declaration of _end fix your error?

This is in a host tool, so it depends on the builtin linker script the
toolchain decides to use. This is risky, though, as it may be using
PROVIDE() for _end, which means that in cases where it doesn't break,
other references to _end that may exist will be linked to the wrong
symbol. I don't think 'build' should be expected to do anything
interesting with its own representation in memory, but better fix it
nonetheless.

Arvind: mind sending a fix for this, please?
