Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF211FC965
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQJCI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 05:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQJCH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Jun 2020 05:02:07 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B997D207DD;
        Wed, 17 Jun 2020 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592384526;
        bh=MPSZ6N2p6Aa3SX2HTxDBxuLOHNXxyEpcY3Iy+6QVNpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rAuIDXQlFGWl7gFPDU4znFh2dqMD47uIJuoVgXvi/Ciw4s+FpXtlOwBLQtTegCF3p
         FMQsr/jkK0VSSblZBGkNsb+4Nr+sgjSv5OkzLSmO8gKHwXNlTk+ew7XO6oCEZ/H1XB
         fr4qBuyDsDntIRVjBeJwNKZdIyywfzw2zBkVyEd0=
Received: by mail-oi1-f178.google.com with SMTP id t25so1125660oij.7;
        Wed, 17 Jun 2020 02:02:06 -0700 (PDT)
X-Gm-Message-State: AOAM533gmDBRy6FOHUN3pNLiRGMg56KFWaudQKcTfR0b/UDmzmdJVtFG
        AqXB89AtGsUCjgW4MM6d6FYGxmBxj6M1ROgA/CQ=
X-Google-Smtp-Source: ABdhPJxR1Ijvnfs7Ry+C5b6BcLJX5IK9RCHmTER5sipSJ1w2SVITb2URmm4SUNWUPPkSJOf/LX54yTF3sjDqFDs0z84=
X-Received: by 2002:aca:b241:: with SMTP id b62mr6301244oif.47.1592384526109;
 Wed, 17 Jun 2020 02:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200615202408.2242614-1-pjones@redhat.com> <CAMj1kXGLwyk9ibSDXBfeu06HV4x4VtbWbKv20KNzkXpbTxBSXg@mail.gmail.com>
In-Reply-To: <CAMj1kXGLwyk9ibSDXBfeu06HV4x4VtbWbKv20KNzkXpbTxBSXg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Jun 2020 11:01:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPCeYmnkksL=j2qWfY5q9QRcUhDf1qMK_OgCD9=XDK=A@mail.gmail.com>
Message-ID: <CAMj1kXFPCeYmnkksL=j2qWfY5q9QRcUhDf1qMK_OgCD9=XDK=A@mail.gmail.com>
Subject: Re: [PATCH] Make it possible to disable efivar_ssdt entirely
To:     Peter Jones <pjones@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 16 Jun 2020 at 00:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 15 Jun 2020 at 22:24, Peter Jones <pjones@redhat.com> wrote:
> >
> > In most cases, such as CONFIG_ACPI_CUSTOM_DSDT and
> > CONFIG_ACPI_TABLE_UPGRADE, boot-time modifications to firmware tables
> > are tied to specific Kconfig options.  Currently this is not the case
> > for modifying the ACPI SSDT via the efivar_ssdt kernel command line
> > option and associated EFI variable.
> >
> > This patch adds CONFIG_EFI_CUSTOM_SSDT_OVERLAYS, which defaults
> > disabled, in order to allow enabling or disabling that feature during
> > the build.
> >
> > Signed-off-by: Peter Jones <pjones@redhat.com>
>
> Thanks Peter.
>
> > ---
> >  drivers/firmware/efi/efi.c   |  2 +-
> >  drivers/firmware/efi/Kconfig | 11 +++++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 48d0188936c..4b12a598ccf 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -192,7 +192,7 @@ static void generic_ops_unregister(void)
> >         efivars_unregister(&generic_efivars);
> >  }
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> > +#if IS_ENABLED(CONFIG_EFI_CUSTOM_SSDT_OVERLAYS)
> >  #define EFIVAR_SSDT_NAME_MAX   16
> >  static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
> >  static int __init efivar_ssdt_setup(char *str)
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 6b38f9e5d20..fe433f76b03 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -278,3 +278,14 @@ config EFI_EARLYCON
> >         depends on SERIAL_EARLYCON && !ARM && !IA64
> >         select FONT_SUPPORT
> >         select ARCH_USE_MEMREMAP_PROT
> > +
> > +config EFI_CUSTOM_SSDT_OVERLAYS
> > +       bool "Load custom ACPI SSDT overlay from an EFI variable"
> > +       depends on EFI_VARS
>
> Shouldn't this depend on ACPI too?
>

I'll pick this up as a fix (with the ACPI dependency added)

> > +       default ACPI_TABLE_UPGRADE
> > +       help
> > +         Allow loading of an ACPI SSDT overlay from an EFI variable specified
> > +         by a kernel command line option.
> > +
> > +         See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
> > +         information.
> > --
> > 2.26.2
> >
