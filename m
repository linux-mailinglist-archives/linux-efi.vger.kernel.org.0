Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36D1F6FC9
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 00:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgFKWS5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Jun 2020 18:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgFKWS4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 11 Jun 2020 18:18:56 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F218220842
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591913936;
        bh=imyi61X0ra1DJYkPhcb95DNLqe+3YOzR5B5jEd+A14Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ILAXCAH8ByjFrgwxHmf7A5T1Dk/6ll22nmOWPbu7/O10zoU3xPqJuExMfjQTEojG3
         kBJBOap0aPC7TO1TTsNyoNrj635D95vidS2WwvT66W6LVMdWkKLxHeAI2B9EY0raEH
         JmqEVK/I1XKVz7MHQmFNAv8cH1bsnYhKzJr0+o1M=
Received: by mail-oi1-f181.google.com with SMTP id a137so6937330oii.3
        for <linux-efi@vger.kernel.org>; Thu, 11 Jun 2020 15:18:55 -0700 (PDT)
X-Gm-Message-State: AOAM531GeSXXbuU8YLZFSDHlyEFo5Q02EnPkHN+qm23fknXiIci1/JBC
        h7L7obvb3ZxTNGlIuCGpKtK5Az1IXTWHvCWSh/k=
X-Google-Smtp-Source: ABdhPJwrDgwDHsUaFQb+w39G3rWIBANhwcpBILA0tSL2g1bjnKgBiBTM5X1nPV1nywiH2Q5nDslPNwror7sRI/FVjXI=
X-Received: by 2002:aca:b241:: with SMTP id b62mr125033oif.47.1591913935327;
 Thu, 11 Jun 2020 15:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200607135834.898294-1-ardb@kernel.org> <20200607135834.898294-2-ardb@kernel.org>
 <96a36110-68e1-89e3-2d59-b16f01abae21@gmx.de> <CAMj1kXG9XTtsyLQ=njM8LPCYCE2tOrrYQtctU_acNAxLfe=5oQ@mail.gmail.com>
 <f8a485d2-1e00-1d02-58a4-2e1684bfbfb4@gmx.de> <CAMj1kXGLoKDLJAihThkkcYwNpr12inneEB3dMOqvcZFm9oR5_w@mail.gmail.com>
In-Reply-To: <CAMj1kXGLoKDLJAihThkkcYwNpr12inneEB3dMOqvcZFm9oR5_w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 Jun 2020 00:18:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com>
Message-ID: <CAMj1kXFjuMy6+amsMmmepkNATCec4vsxeiVVFq9CFZ64wbmGaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi/arm: decompressor: deal with HYP mode boot gracefully
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 9 Jun 2020 at 09:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 8 Jun 2020 at 12:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 6/8/20 1:08 AM, Ard Biesheuvel wrote:
> > > On Sun, 7 Jun 2020 at 19:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 6/7/20 3:58 PM, Ard Biesheuvel wrote:
> > >>> EFI on ARM only supports short descriptors, and given that it mandates
> > >>> that the MMU and caches are on, it is implied that booting in HYP mode
> > >>> is not supported.
> > >>>
> > >>> However, implementations of EFI exist (i.e., U-Boot) that ignore this
> > >>> requirement, which is not entirely unreasonable, given that it makes
> > >>> HYP mode inaccessible to the operating system.
> > >>>
> > >>> So let's make sure that we can deal with this condition gracefully.
> > >>> We already tolerate booting the EFI stub with the caches off (even
> > >>> though this violates the EFI spec as well), and so we should deal
> > >>> with HYP mode boot with MMU and caches either on or off.
> > >>>
> > >>> - When the MMU and caches are on, we can ignore the HYP stub altogether,
> > >>>   since we can carry on executing at HYP. We do need to ensure that we
> > >>>   disable the MMU at HYP before entering the kernel proper.
> > >>>
> > >>> - When the MMU and caches are off, we have to drop to SVC mode so that
> > >>>   we can set up the page tables using short descriptors. In this case,
> > >>>   we need to install the HYP stub as usual, so that we can return to HYP
> > >>>   mode before handing over to the kernel proper.
> ...
> >
> > Hello Ard,
> >
> > thanks for supplying a branch for testing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-arm-hyp-mode
> >
> > The OrangePi PC boots fine with this branch. PSCI is enabled. Rebooting
> > the system works fine. See log below.
> >
> > With the patch 2/2 you add an output line for the exceptions level and
> > the MMU status. Above you state "We already tolerate booting the EFI
> > stub with the caches off." This relates to a workaround in U-Boot
> > accomodating old GRUB versions (CONFIG_EFI_GRUB_ARM32_WORKAROUND=y).
> >
> > Would a further diagnostic line showing if D-cache and I-cache is
> > enabled make sense?
> >
> > Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
> > Loading Linux 5.7.0-armmp-lpae+ ...
> > Loading initial ramdisk ...
> > EFI stub: Running in HYP mode with MMU enabled
>
> BTW is this with or without the GRUB hack?
>

I've given this a spin myself on a RPi4 running 32-bit U-boot, and
everything works as expected, both with and without the GRUB hack
enabled.

Russell, given that this only affects code inside #ifdef
CONFIG_EFI_STUB, do you have any objections to me taking this as a fix
via the EFI tree? I have a set of fixes I need to queue up and send
out anyway, and I intend to do so early next week.
