Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03355E9D3
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiF1Qeb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiF1Qdf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 12:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE01D5
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 09:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96083617C4
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 16:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E569FC3411D
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433804;
        bh=Bm8to/gbBbLm0xjcRvdNBQLPTsgqLmoLnPI1yFnAC9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YauDzaEI3gssmZua2E1HGFzRDhT9fUbkoZvHqG4xHlVC4Ccqy/azyN5RZhXhU9oq1
         YrRuuia9LlLw++axuNoUVhB7p4wLags7Zr8bCslVvNGsmOeTGIH/texhBiQ+5ADs/b
         7G8DPHOcN/6A2XZSJCvgdVlwFm0i9JHynUIv5pZGIL+2jK5gyGd69PEyk8/q+JYE9Z
         RMd1+eidLsH0YKwsmGZTjFKWywtbkKESuTzcomqpzKQv/IXl9BsXuGEbjW8JjZSBpB
         LqbLevq8EqxNF5yv7GP2oU23Aj+bf9Dg+8jrJnNraGb9Pw+vdCo1ied6SNctcCmd77
         I80IjG41wrcHA==
Received: by mail-oo1-f52.google.com with SMTP id g8-20020a4ac4c8000000b00425a0f2b493so1369564ooq.0
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 09:30:04 -0700 (PDT)
X-Gm-Message-State: AJIora80TwUEp+XCviHWz1sssJPkcZeG7UFPNEFepk7Et6VqAu+ifApn
        bK1+Vg0TKsC4WZm8AgDqo9DnkvOB2hE8MjJ2Ekc=
X-Google-Smtp-Source: AGRyM1vEAwyZnIq7h8exEImSWBvCXGL163+x0Y9M0oLxLeylmIT1NPPjf1DFJ0Ih+7ecsWEUo9Y3xOJt5CKmmWVoypk=
X-Received: by 2002:a4a:bd92:0:b0:425:9e50:6280 with SMTP id
 k18-20020a4abd92000000b004259e506280mr6260485oop.98.1656433804064; Tue, 28
 Jun 2022 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220628141821.849643-1-sudeep.holla@arm.com>
In-Reply-To: <20220628141821.849643-1-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 18:29:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHyMNn5bZceb4QnnQfBJ3bWpM5PLdZXR4ECGhmT7hzVbA@mail.gmail.com>
Message-ID: <CAMj1kXHyMNn5bZceb4QnnQfBJ3bWpM5PLdZXR4ECGhmT7hzVbA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: efi: Simplify arch_efi_call_virt() macro
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 16:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, the arch_efi_call_virt() assumes all users of it will have
> defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> actually expects void pointer.
>
> Simplify the arch_efi_call_virt() macro by eliminating the explicit
> need for efi_##f##_t type for every user of this macro.
>
> This change is done to align with implementations on other similar
> architectures.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I'll queue this one up right away in the EFI tree, unless Russell has
something else in mind?



> ---
>  arch/arm/include/asm/efi.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> v1[1]->v2:
>         - Dropped the usage of even typeof() and simply call p->f(args)
>           as suggested by Ard
>
> [1] https://lore.kernel.org/r/20220628125938.694256-1-sudeep.holla@arm.com/
>
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 27218eabbf9a..bb4d15101de4 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -24,12 +24,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>  #define arch_efi_call_virt_setup()     efi_virtmap_load()
>  #define arch_efi_call_virt_teardown()  efi_virtmap_unload()
>
> -#define arch_efi_call_virt(p, f, args...)                              \
> -({                                                                     \
> -       efi_##f##_t *__f;                                               \
> -       __f = p->f;                                                     \
> -       __f(args);                                                      \
> -})
> +#define arch_efi_call_virt(p, f, args...)      ((p)->f(args))
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK \
>         (PSR_J_BIT | PSR_E_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | \
> --
> 2.37.0
>
