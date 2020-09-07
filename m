Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67E25F7DC
	for <lists+linux-efi@lfdr.de>; Mon,  7 Sep 2020 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgIGKWI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Sep 2020 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgIGKVz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Sep 2020 06:21:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB110C061574
        for <linux-efi@vger.kernel.org>; Mon,  7 Sep 2020 03:21:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u9so437281plk.4
        for <linux-efi@vger.kernel.org>; Mon, 07 Sep 2020 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlZMhc8hmWDX2ZWHISagSA2inr2CmIbaM90rLlkkX2Y=;
        b=z4FKmT751iwYNJDVxUHuh97VQixOoKqshuVLVSk+A66nwKitSyLHJHdlsOrueqQ9xZ
         CrtM4r5aXM8/jnhXkOv5DZ2iB0654KyAgU+sLOb8JllNfE9PWGkHTqOi9TVswABW9NI0
         qijj1z8rRtSjFbvxtcF++oL4Ce/HqJ+jpVoS96UgtiXoPBwS0Q4cqetFSJcJnNu46W5q
         qT8ewTf0WSVfNPuuiavDKzpD5xNHE9PVgnJCUYeFXiyfM9dTr1BvL5FyhchNDVYKYdTu
         kvXxkOLGP92pkE5vpjy30sc3HXoyzYZdo8BwY6uTICTrrm8acD4PbwXbT5cHwrksoxE3
         ccqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlZMhc8hmWDX2ZWHISagSA2inr2CmIbaM90rLlkkX2Y=;
        b=m1+1g1qCW6WXiSJ5viXs/+ztZEosG6oB9p6/uqobcAZe2dG610PKK9X8U9+FkxotV/
         a5gFng/pJl5B1hLiRTqDUxDmLGcA/S2oLleQuuxj8OQNlOyKAaAYYIIWmbK3B0oB1Dwe
         6xmrOp7dh4K0y9rp2hy7o9HeoN36aK4sg+FuwKJw8S4uz0klKBra8N50Hb5zkC1xqJF2
         B8JZapYNszMedd7FnssnwJCXWL/57pSurgiKHdgasw/WBV8Y3/xNba9SaKHrEe9eQbwh
         VuPQHweGVEjkf9vHpLWzpMSiCwf7lHVZjv69LULULrk72QM+jdCYEpzEd29VGHjxh4e/
         kDRg==
X-Gm-Message-State: AOAM533/7c7OQQxPy2VD04jkOFuILY13gk3SwW8lINWKcNWZ+L6I/p8Z
        8jPxl68bcJNDd0TF/DomzINc0zNNxZRKmPa6SY6/6A==
X-Google-Smtp-Source: ABdhPJwwvPyxHgWhevcGPZDwDAqnJ75Hv8xCmd648Yuwz0t6G4giWyAT3J/aElkEVJfc4WxZqGTC9KDOPdn0l8DU0Xk=
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr7666482pju.146.1599474114280;
 Mon, 07 Sep 2020 03:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de> <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
 <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de>
In-Reply-To: <fec7e55e-154c-5348-5181-6d9efdc0245a@gmx.de>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 7 Sep 2020 13:21:43 +0300
Message-ID: <CAD8XO3YGKwqbt6cYZQgauioeywLFg56tm+PFM6_nGhuJwSk4Jg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 7 Sep 2020 at 11:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.09.20 09:00, Maxim Uvarov wrote:
> > On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> In the memory map the regions with the lowest addresses may be of type
> >> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> >> rest of the memory. So for calculating the maximum loading address for the
> >> device tree and the initial ramdisk image these reserved areas should not
> >> be taken into account.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> ---
> >>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> >> index c2484bf75c5d..13058ac75765 100644
> >> --- a/drivers/firmware/efi/libstub/efi-stub.c
> >> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> >> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
> >>         map.map_end = map.map + map_size;
> >>
> >>         for_each_efi_memory_desc_in_map(&map, md) {
> >> -               if (md->attribute & EFI_MEMORY_WB) {
> >> +               if (md->attribute & EFI_MEMORY_WB &&
> >> +                   md->type != EFI_RESERVED_TYPE) {
> >
> > shouldn't the type here be CONVENTIONAL?
>
> In 32bit ARM reserve_kernel_base() the following are considered:
>
> * EFI_LOADER_CODE
> * EFI_LOADER_DATA
> * EFI_BOOT_SERVICES_CODE
> * EFI_BOOT_SERVICES_DATA
> * EFI_CONVENTIONAL_MEMORY
>
> What I have not yet fully understood is why Linux on ARM 32bit tries to
> put the kernel into the first 128 MiB. Cf. handle_kernel_image() in
> drivers/firmware/efi/libstub/arm32-stub.c.
>

Are you looking to the latest kernel?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4#n211
efi_bs_call(allocate_pages,..) is only for EFI_CONVENTIONAL_MEMORY.

> According to the comments this is due to some implementation detail in
> the Linux zImage decompressor and not required by UEFI or the hardware:
>
>          Verify that the DRAM base address is compatible with the ARM
>          boot protocol, which determines the base of DRAM by masking
>          off the low 27 bits of the address at which the zImage is
>          loaded. These assumptions are made by the decompressor,
>          before any memory map is available.

I think that is also fixed with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/firmware/efi/libstub/arm32-stub.c?h=v5.9-rc4&id=d0f9ca9be11f25ef4151195eab7ea36d136084f6

Maxim.

>
> Best regards
>
> Heinrich
>
> >
> >>                         if (membase > md->phys_addr)
> >>                                 membase = md->phys_addr;
> >>                 }
> >> --
> >> 2.28.0
> >>
>
