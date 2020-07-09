Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE82198CE
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgGIGpE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 02:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIGpD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Jul 2020 02:45:03 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CBCC206C3;
        Thu,  9 Jul 2020 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594277103;
        bh=yqyv6h2XInBV1EY6m64ceNwhddRMrP8QNwYqF1Bx1zM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S27nB3x7AqgVsIDI5HG/zYaxeNuKyksZnZr+RRkqGY7MIo9S/41mt5nHh9O9jq+Vh
         WPb/31fvxPOxVm42lKbgbpNAK2zK/XEvUv8NVrgN/JTAjVACfCwIShtBQ6i2g36f7G
         +R/TjJuoZaqSWa9RFyQNPXRPr1oNSc6QkvyR6L58=
Received: by mail-oo1-f48.google.com with SMTP id p26so157477oos.7;
        Wed, 08 Jul 2020 23:45:03 -0700 (PDT)
X-Gm-Message-State: AOAM532mePkfTX5CFgGA6T07np9+l8/JTQe3q8oJBDJp//JF903BcjlO
        rNAwkpbLKYmuUuetP9ZnpSu6UvM9AVB3c/ULfNk=
X-Google-Smtp-Source: ABdhPJxJg0zCtFdI6GkRc3m2LXwEKb/oojArjl7Y2J0R0eiIZ44Vv+yY/2C03uazutRVzLit4S54OK5Uwh8Pl/WqJ+0=
X-Received: by 2002:a4a:de8d:: with SMTP id v13mr31588321oou.45.1594277102535;
 Wed, 08 Jul 2020 23:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200623150935.32181-1-geert+renesas@glider.be> <CAMj1kXHY7b1nNoOU-LuXiriFPcTC4ZfMccivhJWJvAUGPhwMzQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHY7b1nNoOU-LuXiriFPcTC4ZfMccivhJWJvAUGPhwMzQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Jul 2020 09:44:51 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHHt7hBqnBrcvzVg9ShghpQqq-cR=pNcVMovon-uoP0xg@mail.gmail.com>
Message-ID: <CAMj1kXHHt7hBqnBrcvzVg9ShghpQqq-cR=pNcVMovon-uoP0xg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 should not default to yes
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 25 Jun 2020 at 19:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 23 Jun 2020 at 17:09, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is deprecated, so it should not
> > be enabled by default.
> >
> > In light of commit 4da0b2b7e67524cc ("efi/libstub: Re-enable command
> > line initrd loading for x86"), keep the default for X86.
> >
> > Fixes: cf6b83664895a5c7 ("efi/libstub: Make initrd file loader configurable")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Queued as a fix, thanks.
>

I am going to have to postpone this one - it appears kernelCI uses
QEMU firmware that does not implement the new initrd loading protocol
yet, so I will need to get that fixed first.


> > ---
> >  drivers/firmware/efi/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index e6fc022bc87e03ab..56055c61904e49f4 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -127,7 +127,7 @@ config EFI_ARMSTUB_DTB_LOADER
> >  config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> >         bool "Enable the command line initrd loader" if !X86
> >         depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
> > -       default y
> > +       default y if X86
> >         help
> >           Select this config option to add support for the initrd= command
> >           line parameter, allowing an initrd that resides on the same volume
> > --
> > 2.17.1
> >
