Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF76689169
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 08:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBCH7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 02:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBCH6n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 02:58:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5841086
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 23:58:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so3611112pjp.0
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 23:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i99J2pmlc+pek02YkZ8nESdE1CjXKdwjOkhiDfukAeg=;
        b=Sh7tY9cHfXBOFOW5S5uAlPN05R/xzTnAbB0mmbqndgniiu94FxnWuAaAm9qmIUSIkN
         qRCBTYVydLP5qCYUHgyPGxipO789g/iIFW6Owe6hqAS2uVMd5pTljfk7m0WZftpBpSFO
         Puk5N5xZ2lhclDBA8AHsmHwR0EgQL6/pS2x+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i99J2pmlc+pek02YkZ8nESdE1CjXKdwjOkhiDfukAeg=;
        b=CZOct5joZuOyygiLm5Qwd7nycj1b5CY9K8/f017JHmTYWRVgYmYPzpv/njBZTcudbH
         DNu+0+VBOAskgSJpx14QcWJP2Dv+X1y0MsoaeIrpKOdiM7uTf7/VErOQpCuNln5zhEzL
         7yUO8zxBf36uXCJ+GzxixHXfQMoEUy9mYB7lTuvkaM7iVKtrZrFcUoR/o1GdHPUM8E05
         Ffk4/IUK4lE9ik/DJ4y7GbkrfPZtoscyKVZ1Rct7h7Io/Q2gw+EcKx8Jl40XCLDmhON0
         9TBEU4/fNmJeEMqFoqDRYokqrMVkXApyFuyi3W0EpG96cIySWq9NiM4CvE85HQtD8kE/
         l1Og==
X-Gm-Message-State: AO0yUKXjaGmMFqapvhLR+NFSx8SIFrOwxIeBkFrgFTGEAdEsI9EuoKIq
        clVei6zniQ2jZWq/pekeVsRHlb80mwjMD5fKcCs+
X-Google-Smtp-Source: AK7set/LUCUS12AMHBelCxeNEkLPsGXsG7KXWdCQZPA6uBHaqE1ujJKSECijijC6oDwX24pxa4KylELSv345afb5ZkU=
X-Received: by 2002:a17:902:ecc1:b0:193:794:ba9 with SMTP id
 a1-20020a170902ecc100b0019307940ba9mr2238861plh.22.1675411121784; Thu, 02 Feb
 2023 23:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20230203075232.274282-1-alexghiti@rivosinc.com> <20230203075232.274282-5-alexghiti@rivosinc.com>
In-Reply-To: <20230203075232.274282-5-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 2 Feb 2023 23:58:30 -0800
Message-ID: <CAOnJCUK==Ma=p0mLLRJBB=3qTyMOTbiDNVYSmXpJr0HCsZ8Kxw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] riscv: Fix EFI stub usage of KASAN instrumented
 strcmp function
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 2, 2023 at 11:56 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> The EFI stub must not use any KASAN instrumented code as the kernel
> proper did not initialize the thread pointer and the mapping for the
> KASAN shadow region.
>
> Avoid using the generic strcmp function, instead use the one in
> drivers/firmware/efi/libstub/string.c.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/kernel/image-vars.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index 7e2962ef73f9..15616155008c 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -23,8 +23,6 @@
>   * linked at. The routines below are all implemented in assembler in a
>   * position independent manner
>   */
> -__efistub_strcmp               = strcmp;
> -
>  __efistub__start               = _start;
>  __efistub__start_kernel                = _start_kernel;
>  __efistub__end                 = _end;
> --
> 2.37.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
