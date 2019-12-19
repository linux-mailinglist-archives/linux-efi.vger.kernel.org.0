Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32B12635B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 14:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSNWd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Dec 2019 08:22:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNWd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Dec 2019 08:22:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so5999554wrq.0
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5rprDHxXUUsUQWf1+CspPL9Q9C2DC58E3evQfRRRlo=;
        b=MuFyu3VcAXMBp4vs+pFMbYEzfkDpaXL/rhPjdN0hVufEsdAAxQSXtwNrAXmNROKnQG
         hogZUMCUhqvWv5udx2OD/CeiruLTlpaAtGAM44fvIrxB00ysN/C99gSLM2ifyVhzUvJb
         NJuAbrD7fqb6qSpsxRIdH8LsSsYkT8JV2BTfGTArwn2soTZOcwg28ib8b/LJXA93pept
         xBl8jrFhbTSr/aioxflV0chJeAuPNVk2WImwmf5qqg7WqGzNHbnwPcEE2dVbVzrmEBNO
         tAdZjrRrzkQVYjYl5YPbRaoqaSsmgYoZ9dhFxAgCyKULhP0617mNAVNglk2tQoQOpl7G
         0FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5rprDHxXUUsUQWf1+CspPL9Q9C2DC58E3evQfRRRlo=;
        b=Aj7VXEOlipx86modHwfwQl4+zfYI/K1dzw8kxVs1oTygpeA1BynLFKvdsd5I2FsKSp
         reUKvwUL54auUj9mrGni5CJbSw7n/AIG/oXaMPs62C/7whq+POGJuDlEzMzL8OWbOzSo
         pA24NaT+KnEPEWyxI51qWo90D1eKbyZAGCdzCQLX5LC6Fzewgyzrm9Fy8rzjPpZkTaZo
         7BBHhlfrTIUEUESm+7SCaJ7hZzU15hbcmJrQa3CRbOmMJR/ENLWmorMNw03fQfyvkpik
         x6YraU+gUEN0R2XY5kxrai09WWziFXQeqe3B1EDhOb4G1MuaWzb7suzM7tIfOhNOIgny
         B0Cg==
X-Gm-Message-State: APjAAAVGP1STR6UY7XSSqOz0C6MgcUaVLxzqkSiHGzGW0FZLcXxsMiAG
        HeVu6Fcl11kTp5wcn7CqaKNbLorp/Qcq75/eR0rK1ZbWs9rJCg==
X-Google-Smtp-Source: APXvYqxlAcFYnr+EqpaLHUs/H6CRihTuZLCNLXF1/F8sL184vidReMOojAKfK8O3yhYjbLCjWtoLkM4NzIoOBFUuR/g=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr9790546wrw.246.1576761751305;
 Thu, 19 Dec 2019 05:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <34f13f7f-a79c-16be-638a-c9267b740bce@redhat.com>
In-Reply-To: <34f13f7f-a79c-16be-638a-c9267b740bce@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Dec 2019 13:22:26 +0000
Message-ID: <CAKv+Gu9MLkDtvagWZYj=VxCG7QUSJdzynNzMihKtwmE1r1Qh0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] efi/x86: confine type unsafe casting to mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 Dec 2019 at 13:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 18-12-2019 18:01, Ard Biesheuvel wrote:
> > Currently, we support mixed mode (64-bit Linux running on 32-bit firmware)
> > by explicitly reasoning about pointer sizes for every call into the
> > firmware: on x86, there are 32-bit and 64-bit versions of each protocol
> > interface, and each call gets routed via one of the two, depending on the
> > native size of the firmware.
> >
> > There is a lot of casting and pointer mangling involved in this, and as
> > a result, we end up with much less coverage in terms of type checking by
> > the compiler, due to the indirection via an anonymous, variadic thunking
> > routine.
> >
> > This peculiarity of x86 is also leaking into generic EFI code, which is
> > shared with ia64, arm64, ARM and likely RiscV in the future. So let's
> > try to clean this up a bit.
> >
> > The approach taken by this series is to replace the 32/64 bit distinction
> > with a distinction between native calls and mixed mode calls, where the
> > former can be either 32 or 64 bit [depending on the platform] and use
> > the ordinary native protocol definitions, while mixed mode calls retain
> > the existing casting/thunking approach based on the 32-bit protocol
> > definitions.
> >
> > Given that GCC now supports emitting function calls using the MS calling
> > convention, we can get rid of all the wrapping and casting, and emit the
> > indirect calls directly.
> >
> > Changes since v1:
> > - Substantially more cleanup work to simplify and hide the mixed mode handling
> >    in generic EFI code.
> > - Get rid of all the pointless passing around of sys_table_arg
> > - Incorporate an updated version of Matthew's PCI DMA disable patch using EFI
> >    events to defer poking the busmaster bits until after all the ordinary
> >    ExitBootServices() callbacks have executed.
> >
> > Code can be found here
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-x86-cleanup-v2
> >
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Matthew Garrett <matthewgarrett@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Arvind Sankar <nivedita@alum.mit.edu>
>
> I've merged ardb/efistub-x86-cleanup-v3 into my local tree for testing I will let
> you know if I see any unexpected side-effects. I've set CONFIG_EFI_DISABLE_PCI_DMA=n
> for now.
>

Thanks Hans.

The CONFIG should not make a difference on mixed-mode - all the code
is there anyway, and only the default value changes, but it is
overridden to 'false' on mixed mode systems. The reason is that my
version of this patch uses an event callback, which would mean 32-bit
firmware calling back into the 64-bit kernel in the mixed mode case,
which we don't support.



> I did notice one small cosmetic issue with the last patch:
>
>  > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>  > index bcc378c19ebe..da2f5fc862aa 100644
>  > --- a/drivers/firmware/efi/Kconfig
>  > +++ b/drivers/firmware/efi/Kconfig
>  > @@ -215,6 +215,28 @@ config EFI_RCI2_TABLE
>  >
>  >        Say Y here for Dell EMC PowerEdge systems.
>  >
>  > +config EFI_DISABLE_PCI_DMA
>  > +       bool "Clear Busmaster bit on PCI bridges during ExitBootServices()"
>  > +       help
>
> The bool and help here seem to be indented by 7 spaces rather then by a tab.
>
> Regards,
>
> Hans
>
>
