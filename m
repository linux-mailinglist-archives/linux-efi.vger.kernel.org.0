Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16433CF9B8
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGTL5Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 07:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhGTL5V (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 07:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F228D60E0C
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784680;
        bh=8uItyTeZGwoskfvIymnWXgS6EH9/qVSnEA4rAvmRhaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J8ikoevl3KTnHUWumZzVhsSK/IGTYSHUsklBUDBNCcGTVKe0R+4eRSGPuAvOPIbMK
         ZN2K4z5qUYjig+xpnbPWF30E4GmIQ4DgRr1q1AaLwNFi/1TSnTzbDYl5DfG9PCkGhz
         pzN6pDEeB0lN18V4tTZcvvfzsbcKJA5lqpFjZAvjBN8uJE2jCxGdJmOXwyV+bTSkeC
         BmDGw4Y/bJdPK46q80yUm+Zw3M1pp+iMmyp5+JIXVaQF1JYEZilgVMgFVHgSTofBJn
         gxk03Hm3T/Ki46p+Mr7bt/BLipDwRTvd3Lv6xxWUEGP421kcQLWtFz5I0mSbMxf0sy
         mjVznjeBIzAIg==
Received: by mail-oi1-f178.google.com with SMTP id p67so24357548oig.2
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 05:37:59 -0700 (PDT)
X-Gm-Message-State: AOAM5332m0/NJ/gW5SAnesHYsUA+TZmoPenAyniHccgCvKcNBax3/3W7
        7TcCrM7ya15Hcnhh9H65DiMpG2EuBef/RvsOV4s=
X-Google-Smtp-Source: ABdhPJxQl14grkN6rj4YnaIdi098DXlbYIwmHhYmBOX6qRloPFSX+OoCJ8qBE3dJWFb4rNmF5LGqHJUsDM+D8dW+3ic=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr20605155oib.33.1626784679390;
 Tue, 20 Jul 2021 05:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <c71fce9256e9caa7bd3400d525f22380b686d29e.camel@kernel.crashing.org>
In-Reply-To: <c71fce9256e9caa7bd3400d525f22380b686d29e.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Jul 2021 14:37:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGWOXjFt1hH7V3Ah=9tbcng34CxAGM+h3VNpUXPuBqMCA@mail.gmail.com>
Message-ID: <CAMj1kXGWOXjFt1hH7V3Ah=9tbcng34CxAGM+h3VNpUXPuBqMCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: efi: kaslr: Fix occasional random alloc (and
 boot) failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org Will Deacon" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Jul 2021 at 13:14, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> The EFI stub random allocator used for kaslr on arm64 has a subtle
> bug. In function get_entry_num_slots() which counts the number of
> possible allocation "slots" for the image in a given chunk of free
> EFI memory, "last_slot" can become negative if the chunk is smaller
> than the requested allocation size.
>
> The test "if (first_slot > last_slot)" doesn't catch it because
> both first_slot and last_slot are unsigned.
>
> I chose not to make them signed to avoid problems if this is ever
> used on architectures where there are meaningful addresses with the
> top bit set. Instead, fix it with an additional test against the
> allocation size.
>
> This can cause a boot failure in addition to a loss of randomisation
> due to another bug in the arm64 stub fixed separately.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 2ddbfc81eac8 (efi: stub: add implementation of efi_random_alloc())

Thanks for fixing this.

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>
>  drivers/firmware/efi/libstub/randomalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
> index a408df474d83..724155b9e10d 100644
> --- a/drivers/firmware/efi/libstub/randomalloc.c
> +++ b/drivers/firmware/efi/libstub/randomalloc.c
> @@ -30,6 +30,8 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
>
>         region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
>                          (u64)ULONG_MAX);
> +       if (region_end < size)
> +               return 0;
>
>         first_slot = round_up(md->phys_addr, align);
>         last_slot = round_down(region_end - size + 1, align);
>
>
