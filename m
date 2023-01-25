Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6405A67BA0F
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 20:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAYTAv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 14:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYTAv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 14:00:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF010D8
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 11:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1B01B81B95
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 19:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C00C433D2
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674673247;
        bh=5a/FLnR4EluMFlHUUsXsruRbqEqUEqoCQ5OXIBz7FpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WgrbIcBuVimYKJAnDDNVXxiF4FeR97d36QUkP/KvnxtcFYOjrasUb7QNtHsWOy7pm
         o3+MjRviXqGw9eKWcC9oPFjzrsam1btJ+Mkomj/WezyLta5CwMQYs/phPWuhAxIb/+
         o5lpe7Bxsy6TWpjYv7j+4xsVMuurgYCTv52R75NwBTzDjSkc4vS+TyxtsfizbMvLqt
         4oUTaIZRtuim3P9hUkOxOj4+KtAN4NIvgcFih6OoZOLsp4t5NMVCApvoySTcR29xUS
         bFNeGibjO9ZmOvuhlj+NQjgFDxGSIRgiWamJ6Cj88JqdnQBziTnkEKvUTiqEbazwyj
         HV8AjbvFWYVIg==
Received: by mail-lf1-f51.google.com with SMTP id h24so26287635lfv.6
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 11:00:47 -0800 (PST)
X-Gm-Message-State: AFqh2koEVwj3gdIadEzYMkKHateDkfv4qJsQrQ925bdx7cXtKHB/ZFKS
        NymOH1mpBaIrzM60HnuZ4CHrLbYMScMh8oHFczQ=
X-Google-Smtp-Source: AMrXdXsTjyxsOHITJiVXZfhfZ0fSbaTxkBq/Zs3OCEvzevVYTScyzTcB6nTaD16TtpeNX1PSeAmzjd1bpKe9jltCWrI=
X-Received: by 2002:a05:6512:118a:b0:4cc:9d69:4703 with SMTP id
 g10-20020a056512118a00b004cc9d694703mr3605366lfr.110.1674673245538; Wed, 25
 Jan 2023 11:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20230125185910.962733-1-ardb@kernel.org>
In-Reply-To: <20230125185910.962733-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Jan 2023 20:00:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAGcB+H=7+CVo2SccED5x0pjzE51r_DhN-_2xGtfLkqw@mail.gmail.com>
Message-ID: <CAMj1kXEAGcB+H=7+CVo2SccED5x0pjzE51r_DhN-_2xGtfLkqw@mail.gmail.com>
Subject: Re: [PATCH] arm64: head: Switch endianness before populating the ID map
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Jan 2023 at 19:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Ensure that the endianness used for populating the ID map matches the
> endianness that the running kernel will be using, as this is no longer
> guaranteed now that create_idmap() is invoked before init_kernel_el().
>
> Note that doing so is only safe if the MMU is off, as switching the
> endianness with the MMU on results in the active ID map to become
> invalid. So also clear the C and M bits when toggling the EE bit in

not the C bit - I ripped that out at the last minute

> SCTLR, and mark the MMU as disabled at boot.
>
> Note that the same issue has resulted in preserve_boot_args() recording
> the contents of registers X0 ... X3 in the wrong byte order, although
> this is arguably a very minor concern.
>
> Fixes: 32b135a7fafe ("arm64: head: avoid cache invalidation when entering with the MMU on")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  3 ++-
>  arch/arm64/kernel/head.S        | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 1312fb48f18b5a51..2facd7933948677a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -575,6 +575,7 @@
>  #define SCTLR_ELx_DSSBS        (BIT(44))
>  #define SCTLR_ELx_ATA  (BIT(43))
>
> +#define SCTLR_ELx_EE_SHIFT     25
>  #define SCTLR_ELx_ENIA_SHIFT   31
>
>  #define SCTLR_ELx_ITFSB         (BIT(37))
> @@ -583,7 +584,7 @@
>  #define SCTLR_ELx_LSMAOE (BIT(29))
>  #define SCTLR_ELx_nTLSMD (BIT(28))
>  #define SCTLR_ELx_ENDA  (BIT(27))
> -#define SCTLR_ELx_EE     (BIT(25))
> +#define SCTLR_ELx_EE     (BIT(SCTLR_ELx_EE_SHIFT))
>  #define SCTLR_ELx_EIS   (BIT(22))
>  #define SCTLR_ELx_IESB  (BIT(21))
>  #define SCTLR_ELx_TSCXT         (BIT(20))
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index dc56e1d8f36eb387..107a2b87577c9b0e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -129,10 +129,31 @@ SYM_CODE_START_LOCAL(record_mmu_state)
>         mrs     x19, sctlr_el1
>         b.ne    0f
>         mrs     x19, sctlr_el2
> -0:     tst     x19, #SCTLR_ELx_C               // Z := (C == 0)
> +0:
> +CPU_LE( tbnz   x19, #SCTLR_ELx_EE_SHIFT, 1f    )
> +CPU_BE( tbz    x19, #SCTLR_ELx_EE_SHIFT, 1f    )
> +       tst     x19, #SCTLR_ELx_C               // Z := (C == 0)
>         and     x19, x19, #SCTLR_ELx_M          // isolate M bit
>         csel    x19, xzr, x19, eq               // clear x19 if Z
>         ret
> +
> +       /*
> +        * Set the correct endianness early so all memory accesses issued
> +        * before init_kernel_el() occur in the correct byte order. Note that
> +        * this means the MMU must be disabled, or the active ID map will end
> +        * up getting interpreted with the wrong byte order.
> +        */
> +1:     eor     x19, x19, #SCTLR_ELx_EE
> +       bic     x19, x19, #SCTLR_ELx_M
> +       b.ne    2f
> +       pre_disable_mmu_workaround
> +       msr     sctlr_el2, x19
> +       b       3f
> +       pre_disable_mmu_workaround
> +2:     msr     sctlr_el1, x19
> +3:     isb
> +       mov     x19, xzr
> +       ret
>  SYM_CODE_END(record_mmu_state)
>
>  /*
> --
> 2.39.0
>
