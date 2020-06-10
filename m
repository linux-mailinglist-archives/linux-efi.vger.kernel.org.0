Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77BF1F5168
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jun 2020 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgFJJpH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Jun 2020 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgFJJpG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Jun 2020 05:45:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B3C03E96B;
        Wed, 10 Jun 2020 02:45:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so1063077lfd.7;
        Wed, 10 Jun 2020 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knFTNygHBlvK7O+pDlbdvkQzVtQ3TgCejJaIUpEQ4jE=;
        b=FPoPyctxOdVDSsWBW0DlRNRiIuR67mqyGK8YC9Ys9GBn2jdZt6nSY+imLjKGWfZEmy
         TKFIRPmh0pIedVCCcigIb62Ci1dFBR8JP/pisoToHWPgSFb8TW9t0nwj40a38Ci/vY+n
         cz552AjSVLs6oN/qPoU3US6Aaixm2HEv4HnPCGLPMiSZUVdt70G0rk8wNwq82Ssmr3k3
         8MuTnvRqc1BzZmJPJzxO2uuYvNsVmeVdXs9mVUSI+rQpArHUPCMp+JV+uzskDaAoY6vX
         O/QCJNNB4L1xcgJ7QBk5uolvmPxfPbuI24RABliKkdeXVhkZFEjnaArMbKHgTJoUEYNv
         oXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knFTNygHBlvK7O+pDlbdvkQzVtQ3TgCejJaIUpEQ4jE=;
        b=pk0/sCO2vmCjgOO81KwuKty7r49SKbQb//XOnZSCbiQ93TfNl64R/QcsBIrVuFyYxL
         vmMZ+ycpQi4kMP1doP0WBRmkjgZgGmPoS4FO78LYV5Bb5X8QSMI7QLWC8UuVwz55DQPp
         W0vb2cLrEwLcjBR0Urn4kDKcIcO1eZcIfIORsrS6OGm4p9CtUAUtDu2hzb8IBdEFARI4
         M1fWogOFV+YPVBwKeSoH09C1JR+IrN/6YsYoDLUQcIELgQ54eIYcwT7/ONt3lc2qmUxb
         xJnQV3OUynLRd698yBwKyU3GXiWmTEzO1sb2e5w5vIAtQmQrCy85d/xyiY6OuTdJiWtn
         CQCQ==
X-Gm-Message-State: AOAM5306xdndgNGsUhaxct0gb4fEM/ePWGkn1M027bKYgLvR+jot7Ocx
        7go3M+oEBsWj6xukwRhX44fSGoioyuNxu/be2fw=
X-Google-Smtp-Source: ABdhPJyQMlT6HI3cYl8ktA2fFE/ZTZurP+ljqqgBYUhJ8esgJ8ZgEAVUyHEYJ3Tg55Pvko91cuPxWdnhKnbyjJSPIZE=
X-Received: by 2002:a19:5d44:: with SMTP id p4mr1244127lfj.56.1591782304769;
 Wed, 10 Jun 2020 02:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200610071446.3737-1-zhenzhong.duan@gmail.com>
 <20200610085932.GA461993@ubuntu-n2-xlarge-x86> <CAMj1kXHun8-SS4L03ccp=pt1oyPSfpuPezju294NnJoKLtcvcA@mail.gmail.com>
In-Reply-To: <CAMj1kXHun8-SS4L03ccp=pt1oyPSfpuPezju294NnJoKLtcvcA@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 10 Jun 2020 17:44:53 +0800
Message-ID: <CAFH1YnN9wDPycD59EPV406j9jkvsibi9Ewjt1ROswENv8OVupQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Fix build error with libstub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 10, 2020 at 5:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 10 Jun 2020 at 10:59, Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Jun 10, 2020 at 03:14:46PM +0800, Zhenzhong Duan wrote:
> > > Got below error during build:
...
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index cce4a74..25e5d02 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -6,7 +6,7 @@
> > >  # enabled, even if doing so doesn't break the build.
> > >  #
> > >  cflags-$(CONFIG_X86_32)              := -march=i386
> > > -cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > > +cflags-$(CONFIG_X86_64)              := -mcmodel=small -maccumulate-outgoing-args
> >
> > This will need a cc-option call if this patch is necessary because clang
> > does not support this flag.
> >
> > clang-11: error: unknown argument: '-maccumulate-outgoing-args'
> >
>
> A fix was already sent for this
>
> https://lore.kernel.org/bpf/20200605150638.1011637-1-nivedita@alum.mit.edu/
>
> which does the right thing here.
Ah, so I'm late again. Not clear if there is easy way to check queued
patches for upstream..

Regards
Zhenzhong
