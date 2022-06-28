Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB5755E440
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbiF1NQ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiF1NQk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 09:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7EA31DFB
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 06:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5363D6170C
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 13:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAAC341CB
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422198;
        bh=GJ828zsFPFqGeyEpo9qIkVuo2LrqQaGvsKKzzeLeOiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=spblb/1qLrYha28+TpxOhc7+TyMcGEGGDIcEdM6FQsV45AzR+r0kGcBxas7U5Dd64
         n/9GDxl5xs+OTHp3I9R3axVAVd9gIVnKB3MvkCDKZQiLQNvA/u7DhdblRDW0LRnBd4
         sFNlYicwLPBUEfzWihW59Pi84PaiQaJUxfEt8MSEYLZJOdVM7ofnWzI6Zl6nkjG0Dq
         4rU9cm1O5QzwzQkaj4p4P3ZUdyUF2wP+DSqORJMez/NmcoUKDCzlovQ2R2vANNYZWz
         BHOouz2wfpxUrof8S0ohSeJAEMYEHYd3APiB8hwzC/LRAAO56SfXT5D/oq/o2MQR3z
         xuDlbxNuST79g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-101e1a33fe3so16960053fac.11
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 06:16:38 -0700 (PDT)
X-Gm-Message-State: AJIora946WaMm7BQ+7mu++BOXlPfgYmK1tKLToI3x8u4C54BFBLjhZ6q
        jF+BexijlW0C9GQyfu5P0iyR1HTC7HvndlsVZeM=
X-Google-Smtp-Source: AGRyM1t+Za5V+xV2GWmlyFbVBlgnK8LNdIURPziwlhEftJUiD9UM6NjykAag06BF54tAOM13UuHD6fe+Zbg6MuFGvb4=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr10526464oab.126.1656422197919; Tue, 28
 Jun 2022 06:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220628125938.694256-1-sudeep.holla@arm.com>
In-Reply-To: <20220628125938.694256-1-sudeep.holla@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 15:16:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
Message-ID: <CAMj1kXENKbduN65vs-qAeuiApA8e=_ee5jxVPzRf5kxn8bAzcQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: efi: Simplify arch_efi_call_virt() macro by using typeof()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
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

On Tue, 28 Jun 2022 at 14:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, the arch_efi_call_virt() assumes all users of it will have
> defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> actually expects void pointer.
>
> Simplify the arch_efi_call_virt() macro by using typeof(p->f) which must
> be a pointer as required by __efi_rt_asm_wrapper() and eliminate the
> explicit need for efi_##f##_t type for every user of this macro.
>
> This change is done to align with implementations on other similar
> architectures.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/include/asm/efi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Hi,
>
> Reference for this change [1] and in particular[2]
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/r/20220628125346.693304-1-sudeep.holla@arm.com
> [2] https://lore.kernel.org/r/20220628125346.693304-3-sudeep.holla@arm.com/
>
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 27218eabbf9a..d4a405c9b4b6 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -26,8 +26,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>
>  #define arch_efi_call_virt(p, f, args...)                              \
>  ({                                                                     \
> -       efi_##f##_t *__f;                                               \
> -       __f = p->f;                                                     \
> +       typeof(p->f) __f = p->f;                                        \
>         __f(args);                                                      \
>  })
>

I think this could simply be

#define arch_efi_call_virt(p, f, args...) ((p)->f(args))

no?
