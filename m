Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6721D2629F9
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIIIRo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 04:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgIIIRo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 04:17:44 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA10208FE;
        Wed,  9 Sep 2020 08:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599639463;
        bh=4+g46RsugZchnLXhayE48WIwyLhN70ak3YgT2AhHBMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r+wC/3pap46RbU4I1s15WbdBrJ7m6iWmMXIyo1a51QLfC3BAeQ+ncAE3VdMQMBOs2
         fGTcyDD8CFit7CeYkzEvd/NeQrCTZM7DHb2G1IHUMbWqhpOBdSFvE7bzsgP3ywyAvD
         19ltaLgVLzHvLgPuqiOt5Nrie4e+VjT66meIEe1Y=
Received: by mail-ot1-f45.google.com with SMTP id w25so352387otk.8;
        Wed, 09 Sep 2020 01:17:43 -0700 (PDT)
X-Gm-Message-State: AOAM530Z9nZAqZ80khNsW3ZudmxeGYULT3l9u+kevWnb/t6DkYhrRRRL
        /58KEyawG3R3+J9u1rZwaaYt+Xmhxx67+PqugfY=
X-Google-Smtp-Source: ABdhPJxpmdgjzkuFKt7YRvCtAkuI3ua4r8nOkJK7uk9piaCemiiGdVto1foUQBAc7BVVAgr45gWJDmSHCtq65hKIIjo=
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr2060217oto.90.1599639462827;
 Wed, 09 Sep 2020 01:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de>
In-Reply-To: <20200904155025.55718-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Sep 2020 11:17:32 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
Message-ID: <CAMj1kXGYpMMrQPgL-SNde75EbDX8RZBDrboEuMcjJ7-cyEJUXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
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

(+ Atish, Palmer)

On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> In the memory map the regions with the lowest addresses may be of type
> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> rest of the memory. So for calculating the maximum loading address for the
> device tree and the initial ramdisk image these reserved areas should not
> be taken into account.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index c2484bf75c5d..13058ac75765 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
>         map.map_end = map.map + map_size;
>
>         for_each_efi_memory_desc_in_map(&map, md) {
> -               if (md->attribute & EFI_MEMORY_WB) {
> +               if (md->attribute & EFI_MEMORY_WB &&
> +                   md->type != EFI_RESERVED_TYPE) {
>                         if (membase > md->phys_addr)
>                                 membase = md->phys_addr;
>                 }
> --
> 2.28.0
>

This is not the right fix - on RPi2, for instance, which has some
reserved memory at the base of DRAM, this change will result in the
first 16 MB of memory to be wasted.

What I would prefer to do is get rid of get_dram_base() entirely -
arm64 does not use its return value in the first place, and for ARM,
the only reason we need it is so that we can place the uncompressed
kernel image as low in memory as possible, and there are probably
better ways to do that. RISC-V just started using it too, but only
passes it from handle_kernel_image() to efi_relocate_kernel(), and
afaict, passing 0x0 there instead would not cause any problems.
