Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF517018E
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgBZOuU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 09:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgBZOuU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 09:50:20 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E71324685
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582728619;
        bh=gq1Mm1RYPBjDxN/0IhfPFWShhaidnAl/LIloGKcu7l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1CJ7CjavlI+rhp0TARUE+0LlSsFswifiWpEQCuV8K6mY5t7a6cI4lxAUGe5VXSIAR
         nRcKcZxrwVViCcXBrilB8wZCpjSq07xz3snMkBdhUSS1dbjO0vZHyBcgsO5Sx8j8A1
         48zPiQYUpMfU8KhRgvD6tm/YC4rhSzI+geCV7nfA=
Received: by mail-wm1-f44.google.com with SMTP id q9so3379436wmj.5
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 06:50:19 -0800 (PST)
X-Gm-Message-State: APjAAAVTmlWS6m3M1H6fD95d2kzWdbRkASUJyion1iqqrul6LM1yT6ZH
        A6kd+gxbypYc/tqMTc93MyJMaoOakP8m/1VwKyGeGg==
X-Google-Smtp-Source: APXvYqyhZmdeHmVsK20o2/b1vO9bIxFOOv3EJjBmSfExbTytVn5FCW1J3TgcDORoYH2uM+W4bGDm4RDU5KdFx0MPqyM=
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr5822649wmf.40.1582728617842;
 Wed, 26 Feb 2020 06:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20200224133856.12832-1-ardb@kernel.org> <20200226142713.GB3100@gmail.com>
In-Reply-To: <20200226142713.GB3100@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 15:50:07 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8eeRB7PiKNK_f7G5mpwsiVP0XWmi=KiyDjju9fk=QuZw@mail.gmail.com>
Message-ID: <CAKv+Gu8eeRB7PiKNK_f7G5mpwsiVP0XWmi=KiyDjju9fk=QuZw@mail.gmail.com>
Subject: Re: [GIT PULL v2] EFI updates for v5.7
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Feb 2020 at 15:27, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Hello Ingo, Thomas,
> >
> > I am sending this as an ordinary PR again, given the size. Please let me
> > know if instead, you prefer me to send it out piecemeal as usual. Either
> > works for me, I was just reluctant to spam people unsolicited.
> >
> > Note that EFI for RISC-V may still arrive this cycle as well.
> >
> > Please take special note of the GDT changes by Arvind. They were posted to
> > the list without any feedback, and they look fine to me, but I know very
> > little about these x86 CPU low level details.
> >
> > This was all build and boot tested on various different kinds of hardware,
> > and all minor issues that were reported by the robots were fixed along the way.
> >
> > Please pull,
> > Ard.
> >
> >
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> >
> >   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> >
> > for you to fetch changes up to dc235d62fc60a6549238eda7ff29769457fe5663:
> >
> >   efi: Bump the Linux EFI stub major version number to #1 (2020-02-23 21:59:42 +0100)
>
> >  66 files changed, 2718 insertions(+), 2638 deletions(-)
>
> Pulled this as a Git tree, thanks Ard!
>
> The boot-time GDT handling cleanups from Arvind look good to me too.
> There's a couple of arguably scary commits in there, so these might be
> 'famous last words'. :-)
>

Thanks!
