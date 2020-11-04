Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C994F2A6D28
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKDSuj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 13:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgKDSuj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Nov 2020 13:50:39 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8E42083B;
        Wed,  4 Nov 2020 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604515838;
        bh=AuEoTPFMY5sqprAdW6MBDTB1rmqvK1Uhmi+03WbhMsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JSl73+53b/B6rf3nKArXs/sbmLRGZbLOKSi2FEAnfQI0+Qnw8xhxWZhM9BUlkjxWo
         1cL+0aoMKFcdI5LdsCzBUXq74rPO8XeR20ApJuHBHLmEmKNmLwIIsc5l1c1OtIR/8E
         xhLH6gwefYfOMBBEfRrEg5kDAQFmOIsdcTuXq4fk=
Received: by mail-ot1-f41.google.com with SMTP id i18so15563086ots.0;
        Wed, 04 Nov 2020 10:50:38 -0800 (PST)
X-Gm-Message-State: AOAM533HRE+XhmPW18fFej1r5XcVme+S70W1iaj9lLT1091P2nTDohPD
        2/J1KfofLxL9OOBzobODTj0tync1iu9nmzhRBT8=
X-Google-Smtp-Source: ABdhPJy/Bh1BceAEABiIDx9ahN4iOoed+HvHOKEb+dpKm/AC0f5igzjAG6XlVnBa6u+9wvEr79Z7RUicIxQVi3gX0ZE=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr18776257ots.90.1604515837409;
 Wed, 04 Nov 2020 10:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20201102223800.12181-1-ardb@kernel.org> <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
In-Reply-To: <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Nov 2020 19:50:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
Message-ID: <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Nov 2020 at 19:20, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Ard, Chester,
>
> On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> > This is a follow-up to Chester's series [0] to enable IMA to the secure
> > boot state of arm64 platforms, which is EFI based.
> >
> > This v4 implements the changes I suggested to Chester, in particular:
> > - disregard MokSbState when factoring out secure boot mode discovery
> > - turn the x86 IMA arch code into shared code for all architectures.
> >
> > This reduces the final patch to a one liner enabling a Kconfig option
> > for arm64 when EFI is enabled.
> >
> > Build tested only.
>
> Thank you!  This patch set is now queued in the linux-integrity next-
> integrity-testing branch.
>

I don't mind per se, but this touches a number of different trees,
including x86 and arm64, and nobody has acked it yet.

As far as the EFI tree is concerned, it looks like I should be able to
avoid any conflicts with other stuff that is in flight, and if not, we
can always use your branch up until the last patch in this serires as
a shared tag (assuming you won't rebase it).
