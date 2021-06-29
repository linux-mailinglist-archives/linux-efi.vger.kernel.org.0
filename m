Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551523B7A8B
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhF2W6z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhF2W6y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 18:58:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B666C061766
        for <linux-efi@vger.kernel.org>; Tue, 29 Jun 2021 15:56:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c8so1688998ybq.1
        for <linux-efi@vger.kernel.org>; Tue, 29 Jun 2021 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCtwoOT/gDcMzaHNoMO9WyHOwg6yfJH1zJcW1hYKrHY=;
        b=I1saaJtdLgSOlHpzEgzntpt8NBggCFBbOpKnGTQ2TP41LkoltDKckTr8Kzz7VLNYKi
         llXELWkSWMjC1DBe0jj8zIxjwk8bE9r5M+6oc7WPlqnW/UI8Ww0TSqKJEWcKQz09oipR
         zKRNJjNNFp0Zl7dbjT5hw7pril0Y1uasrZeaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCtwoOT/gDcMzaHNoMO9WyHOwg6yfJH1zJcW1hYKrHY=;
        b=EREII7N3PHEhZvz607YAcmBiLD0woif1/XhYIcrdY8RF3BNVaUQqHfYm2T8J7oBe5a
         55D1gQ/SLTLrBDoHnFyqCgQOePgvqA91QmUcWlkfkI6MNm9PvJPB3B+A/XhOjYsDejF7
         QS0WC7atCtxu2lN//U4AlXnYBlHxjYjdgg0KluPhb78KF3yuHQoBy8I7u8Lu216MzyIp
         aTFsKnn0lpeD7ZK7wrk90qVL42tREVHSLRe8foR2A3wewhNlLxvHrpot/j2tM4pbHWbj
         HPM9gAN6ADJhBZsgRqP5xaABECXxUMuwPnTAY8hiQ57tNq7/LZg16CS39tpraBgcaoqP
         e57Q==
X-Gm-Message-State: AOAM530SBFf2MhIFSUWbMZfsh6TAcUrnlJM6GbjGBdrbZmG/433YQldu
        j95ACpqSMFpKNhD3MGamENN/GqS1lLuNmke1BM//
X-Google-Smtp-Source: ABdhPJxvpbX85dvBFDwzDQylCz6CI54+dCjhGMQg01ThMLjX1IQs9fM49Hgtyr4s0oCv6IU15TnnrZ6bJAY+UWbI9zs=
X-Received: by 2002:a25:d015:: with SMTP id h21mr6968289ybg.202.1625007385657;
 Tue, 29 Jun 2021 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134018.62859-1-xypron.glpk@gmx.de>
In-Reply-To: <20210629134018.62859-1-xypron.glpk@gmx.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 29 Jun 2021 15:56:14 -0700
Message-ID: <CAOnJCUKuHGUZi-13PpnZGHKkXxhj3asVJgaNMTv3=830eVwi=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 29, 2021 at 6:40 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> to boot SUSE Linux with GRUB on QEMU, cf.
> https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
>
> Remove the constraint.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/riscv/include/asm/efi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index 7542282f1141..649ab513dc99 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
>
> -/* Load initrd at enough distance from DRAM start */
> +/* Load initrd anywhere in system RAM */
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> -       return image_addr + SZ_256M;
> +       return ULONG_MAX;
>  }
>
>  #define alloc_screen_info(x...)                (&screen_info)
> --
> 2.30.2
>

LGTM

Reviewed-by: Atish Patra <atish.patra@wdc.com>

--
Regards,
Atish
