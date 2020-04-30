Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085DA1C0866
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgD3Um7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 16:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgD3Um7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 16:42:59 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0C1207DD;
        Thu, 30 Apr 2020 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588279379;
        bh=PYHU3yWnPxfijaI4fsRVSiZdzHPPF4Mcu6YYWIAfZjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SMiHBExSiQ3TqF7zKveNyETUAIf6ZRC1wdmHPIIKtJR5PfxTLo36r/1F2w7fiBGPb
         Emebm/9Rio1ms8AGOD6guV1Y6UhymzNvIwBHNzL1GJ9+0zZr3wKF5ajc1d+cLsm8of
         yqbRJ/4REGIKQOBlgIMGs6yV463R4QfBn1kouVUw=
Received: by mail-il1-f173.google.com with SMTP id t12so2687356ile.9;
        Thu, 30 Apr 2020 13:42:59 -0700 (PDT)
X-Gm-Message-State: AGi0PubMD7ydj9q2xkEoggeBIFdzXT8ZX79GAL5adA4jBInvFXtQKVDO
        y10GRgyZlNdieoR0tzQsa+eCdwO7SU0lWWTpSYo=
X-Google-Smtp-Source: APiQypKHsHMjf5Qph45W1Wjt/cO7EE0uKI9BzBAqHFIrFxUi4dLejzuPuvvdf2TwBZVaQt0JUL7x08e+IgnwNaQcZUQ=
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr217863ili.211.1588279378242;
 Thu, 30 Apr 2020 13:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182843.2510180-1-nivedita@alum.mit.edu>
 <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
 <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com> <20200430204041.GA2579913@rani.riverdale.lan>
In-Reply-To: <20200430204041.GA2579913@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 22:42:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF62pbmBXmW3BhGAKMG3TrR2KTNuCXcZJ2akuPJXfTrvw@mail.gmail.com>
Message-ID: <CAMj1kXF62pbmBXmW3BhGAKMG3TrR2KTNuCXcZJ2akuPJXfTrvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/libstub: efi_info/efi_err message neatening
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 30 Apr 2020 at 22:40, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Apr 30, 2020 at 09:29:46PM +0200, Ard Biesheuvel wrote:
> > On Thu, 30 Apr 2020 at 21:12, Joe Perches <joe@perches.com> wrote:
> > >
> > > Use a standard style for these output logging messages.
> > >
> > > Miscellanea:
> > >
> > > o Use more common macro #defines with fmt, ##__VA_ARGS__
> > > 0 Remove trailing messages periods and odd ' uses
> > > o Remove embedded function names and use %s, __func__
> > >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >
> > > Perhaps these trivialities on top of this series?
> > >
> >
> > The EFI printing routines don't actually support format strings.
> >
>
> The x86 real-mode bootup code actually has a printf.o that clocks in at
> under 2k. We could add it in, and it would also be nice to move it into
> lib or something, since at least alpha and powerpc implement something
> very similar for boot-time messages.

Not being able to use format strings is really quite annoying, and I
did look into reusing the ordinary one (which is hairy), not realizing
that there is already a cut down version available.

So yes, that does sound like a great idea!
