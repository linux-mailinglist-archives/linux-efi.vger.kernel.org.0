Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5126378C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIUhF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 16:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIUhE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 16:37:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87CC061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 13:37:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so3560762wmj.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxpDQzrsNIx5XK9835G9janE/xMpHUZ2uvG496EzU4c=;
        b=uS92XPYqpRhOsmDhb/M+bZTwgExe+1thV6iqBUozWBfXEodWAvbPKaUV5OpnDhj4sV
         d7TuGytPDfhScP3DSI91yHgQO9DxEPrMvU5abRcxLH8qsOQDmhxfL5bh+rlxACEs28g6
         0nQhSHTHwstThwSDMpF5uqpI054HHm5VIWYpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxpDQzrsNIx5XK9835G9janE/xMpHUZ2uvG496EzU4c=;
        b=Ph3+cjf6V52EqgBOzPrW2amy/rOrk2M2rh+D/YNvi8fvSzh0DoAgSNixFNi+QpbYfd
         Mcmnnv/J8nNLhgfvM+48eXk5X6YleiKvXwMYQXgIRiif+5Nss0j9AnQQweSHuJHLZIhP
         gJR1wBP1S4aFrHvsw4HTiqjb+qtacL6T3U86w2LUzJGJjqoalIjukPeMh7Mpe5pCVCb6
         nec5M+/3tu7B/wskgmFGHatqO1mlFPnFMc4vEJhq6MisNaUXu4/BcaFMqtUPMMb4CT2b
         +pz8hadFZzW2B1Du0qAxOPxBRNs6n+pWSSbD3QrIpcUtrCChVoV0V9YQCJ1ZfB8D9iPO
         5hYw==
X-Gm-Message-State: AOAM530wYEO62zTxzcAQKDxzVzQaE9lVjF8BrnmbasfUqBWhdtpv1G0t
        XYNtMG6iT6W2Ia43sp/5yw7sm4tgJF0iRnS6xL4FABq+U+yl
X-Google-Smtp-Source: ABdhPJw3GyYdapemtMoD/isRBkb5ObOYz1AcU+f6/9csJEhiDM94T1DsJyix98xT46tRec5a5gXYrpNP18spkqk0yKc=
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr5235421wmf.55.1599683821370;
 Wed, 09 Sep 2020 13:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
In-Reply-To: <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 9 Sep 2020 13:36:50 -0700
Message-ID: <CAOnJCU+DrXt=Fvq08dMJX=Nn0bEJr_V_1nPJvh6sRA-GqgV3OQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 9, 2020 at 1:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (+ Atish, Palmer)
>
> On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > In the memory map the regions with the lowest addresses may be of type
> > EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> > rest of the memory. So for calculating the maximum loading address for the
> > device tree and the initial ramdisk image these reserved areas should not
> > be taken into account.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> > index c2484bf75c5d..13058ac75765 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> >         map.map_end = map.map + map_size;
> >
> >         for_each_efi_memory_desc_in_map(&map, md) {
> > -               if (md->attribute & EFI_MEMORY_WB) {
> > +               if (md->attribute & EFI_MEMORY_WB &&
> > +                   md->type != EFI_RESERVED_TYPE) {
> >                         if (membase > md->phys_addr)
> >                                 membase = md->phys_addr;
> >                 }
> > --
> > 2.28.0
> >
>
> This is not the right fix - on RPi2, for instance, which has some
> reserved memory at the base of DRAM, this change will result in the
> first 16 MB of memory to be wasted.
>
> What I would prefer to do is get rid of get_dram_base() entirely -
> arm64 does not use its return value in the first place, and for ARM,
> the only reason we need it is so that we can place the uncompressed
> kernel image as low in memory as possible, and there are probably
> better ways to do that. RISC-V just started using it too, but only
> passes it from handle_kernel_image() to efi_relocate_kernel(), and
> afaict, passing 0x0 there instead would not cause any problems.

Yes. Passing 0x0 to efi_relocate_kernel will result in a failure in
efi_bs_call and it will fallback to
efi_low_alloc_above which will try to assign the lowest possible
available memory with 2MB alignment restriction.
The only disadvantage is an extra unnecessary call to UEFI firmware
which should be okay as it is not in the hotpath.

-- 
Regards,
Atish
