Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93AD1DE938
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgEVOpa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 10:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgEVOpa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 10:45:30 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2200621534;
        Fri, 22 May 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158729;
        bh=JJFT+F3Ml0IsJnlUkyWUziZpN/+xTkSQfeqtW0Lv3ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lp8ESUFXUWue5ssidflAQSNbp4QO3jmmq4j/PF1vFWw9ND1ZXlOwpk8i+ej8YykFl
         ixZFC0MY0umf6tR+wHBwpzAjvnrPvsKm9GpIQiS0qcwmpC0vYPK/qsc7pyZipiC5Nd
         F+Kmc7e0dBlG73Pc5Neja6bc3n6O76iI8eqSyXLc=
Received: by mail-io1-f42.google.com with SMTP id d7so11608522ioq.5;
        Fri, 22 May 2020 07:45:29 -0700 (PDT)
X-Gm-Message-State: AOAM532dn+nPJCJlKeT3eMpE/otlRicunC91oM3Q7xoEhqCTko+ZdSzc
        ZQ+vmxxEdHgytHqt2nflmv2YOvG3nmjJslx2oww=
X-Google-Smtp-Source: ABdhPJyhlLvFQ0WQkr3hDN61INpdGsheflZGjozbDLpURWMljOyFHLzvNSXk8utBm7+M4D0JYgdLDCCOjonAHHDaNik=
X-Received: by 2002:a05:6602:2dcd:: with SMTP id l13mr3392593iow.203.1590158728428;
 Fri, 22 May 2020 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200517125754.8934-1-ardb@kernel.org> <CAMj1kXGUxPuQCv9KPezqpLf1qLTbJh_j9JeVnnYZ=HbnL65=AQ@mail.gmail.com>
 <20200522134004.GF28750@zn.tnic> <CAMj1kXHogO=3wAyZPi9WtHP9++N5KH6OjNgY_CQ_o8nZJ5jjVA@mail.gmail.com>
 <87mu60rrq2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu60rrq2.fsf@nanos.tec.linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 16:45:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFZhq09MWCMTuN07WqA=PEKtJf5i7feO5pTPRObK-NeQQ@mail.gmail.com>
Message-ID: <CAMj1kXFZhq09MWCMTuN07WqA=PEKtJf5i7feO5pTPRObK-NeQQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/7] EFI fixes for v5.7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 22 May 2020 at 16:04, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ard,
>
> Ard Biesheuvel <ardb@kernel.org> writes:
> > On Fri, 22 May 2020 at 15:40, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Fri, May 22, 2020 at 03:06:20PM +0200, Ard Biesheuvel wrote:
> >> > Ping?
> >>
> >> Did you want to make your tags unique from the next pull request onwards
> >> and I were supposed to pull this one as is?
> >
> > What usually happens is that Ingo applies the patches piecemeal,
> > ignoring the tag altogether, so without any coordination between you
> > as x86 maintainers or communication back to me, that is what i was
> > expecting to happen this time as well.
> >
> > Note that I have another PR pending since two weeks ago [0].
> >
> > So if you want to start dealing with the EFI trees in a different way
> > from now on, that is perfectly fine with me, but please align with
> > Ingo and Thomas first.
>
> /me dons managerial hat
>
> Yes, please. Your pull request really do not need any special handling.
>
> Please add a unique signed tag to each pull request and stick the
> description, e.g.
>
>  " EFI fixes for v5.7-rcX:
>    - fix EFI framebuffer earlycon for wide fonts
>    - avoid filling screen_info with garbage...."
>
> into the tag which gives us the merge commit message automagically.
>

Sure.

In that case, please pull these changes from

efi-fixes-for-v5.7-rc6

instead, and disregard the PR for v5.8. I will respin that, include
some patches that came in in the mean time, and tag it in the correct
way before resending the PR.
