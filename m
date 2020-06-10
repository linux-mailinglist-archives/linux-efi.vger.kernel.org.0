Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EFD1F4FD8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jun 2020 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFJIAc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Jun 2020 04:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIAc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Jun 2020 04:00:32 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4E720734;
        Wed, 10 Jun 2020 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591776031;
        bh=FAdHFQnLWqU7V/CLKqgnX3eMb4dwLD/XeGpKGuwa0Ps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mzt43DLjx5j4+eQ0b2AuM54n3o6R+cV89y0VsTHH5oFYD0v2ytzXfsanp5EvOffVE
         N8EJhnlmfUFAb0QiZecr5m/KO6unAsS2eFxEHX6pHkFoMDip6ZNIy3MqvrmBPweL2x
         w8vt6zT4dZ6QN5Nv0wRPmVe2fe1V8Ab6DiLV2344=
Received: by mail-ot1-f54.google.com with SMTP id k15so1005721otp.8;
        Wed, 10 Jun 2020 01:00:31 -0700 (PDT)
X-Gm-Message-State: AOAM533O6rXJiZ9TZulRcQz+yiAeNvEqrm7QFA1mHzz+qXA1kzRvKJdE
        IgMX5a7veueaAt+OiatPHVzvAPx3DLZmwxEqILo=
X-Google-Smtp-Source: ABdhPJxuQWr84gMacb/a6f9SzUwi1kqC15NFZ4y1j2X2hWUD8YkhBaBpuZ66t8CNgxHKeOSwAFP/ChjObyX+SAwt+2c=
X-Received: by 2002:a9d:2de4:: with SMTP id g91mr1622120otb.90.1591776030720;
 Wed, 10 Jun 2020 01:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200604022031.164207-1-masahiroy@kernel.org> <20200610075837.GD15939@willie-the-truck>
In-Reply-To: <20200610075837.GD15939@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Jun 2020 10:00:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXES7MoxWDQeO=D-88fit4H_Qh9SEQmikcJA39d8czPCBQ@mail.gmail.com>
Message-ID: <CAMj1kXES7MoxWDQeO=D-88fit4H_Qh9SEQmikcJA39d8czPCBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/libstub/arm64: link stub lib.a conditionally
To:     Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 10 Jun 2020 at 09:58, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jun 04, 2020 at 11:20:30AM +0900, Masahiro Yamada wrote:
> > Since commit 799c43415442 ("kbuild: thin archives make default for
> > all archs"), core-y is passed to the linker with --whole-archive.
> > Hence, the whole of stub library is linked to vmlinux.
> >
> > Use libs-y so that lib.a is passed after --no-whole-archive for
> > conditional linking.
> >
> > The unused drivers/firmware/efi/libstub/relocate.o will be dropped
> > for ARCH=arm64.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > This patch touches under arch/arm64/, but
> > this is more related to efi.
> > I am sending this to Ard.
>
> Ok, I'll ignore this then. Ard -- please yell if you want me to do anything
> else with it.
>

I am going to send a batch of EFI fixes early next week, so I can take
this as well, or alternatively, you can apply it directly.

>
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 650e1185c190..48a6afa774fc 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -145,7 +145,7 @@ export    TEXT_OFFSET
> >
> >  core-y               += arch/arm64/
> >  libs-y               := arch/arm64/lib/ $(libs-y)
> > -core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > +libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >
> >  # Default target when executing plain make
> >  boot         := arch/arm64/boot
> > --
> > 2.25.1
> >
