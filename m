Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0F5ACFDD
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiIEKW0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiIEKWH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 06:22:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2D3AA;
        Mon,  5 Sep 2022 03:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 347C4CE1147;
        Mon,  5 Sep 2022 10:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E67C433B5;
        Mon,  5 Sep 2022 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662373257;
        bh=+Uu3msM01ofI2IJRAMQEh67WhvZzh7RU7quyhGS0LJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ppBVcG5cJBheaJnJNoz+tYr5cQrrthLWyaz7nkQsOS3LnW0LY40D5LbREYOs2ftfB
         xtQ4X3Fn3ubXqVHFkSnrQIFF0hv29OX5J4ITkC7cRrFnWqplhmP7unyKRKHMaxoXtz
         i8229u1YL307ibY5xgF2SBtvefVjXs91K9cZxmG+/AIZo4nJBV07ra1QQYXMw1rwXW
         niEP6F55aYCq5d4gEV0MNPqbLUl7kUb8BeVF59CYQk9oZOkGKoLp/CpZCPKwEPHbuU
         ap2YUMi7AbUzQ5ouhzq/TgqHY/CGs/oni4aGDxrbwPe9ZVsiog57Gnfai1DlmFdPqt
         3v2HMnmBhidbQ==
Received: by mail-lf1-f51.google.com with SMTP id bq23so12454636lfb.7;
        Mon, 05 Sep 2022 03:20:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo3xYKU11EwicL6gFKpQul/zLVqqUgbBhhk388AVf+GwQ+b724iZ
        L0/WR+Ughwbl5uVORa3dfVCWLzKeLOp8S5XXGFU=
X-Google-Smtp-Source: AA6agR52yaBRDvZyl8rw+pow2WweHwwr9Oj7YwBeDmjylV5SZjabbmhmIum9Vg93EXtICu+arpzQFAYO13n4Xp/2064=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr15489289lfb.583.1662373255072; Mon, 05
 Sep 2022 03:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220831011248.28632-1-michel@lespinasse.org> <20220831011248.28632-4-michel@lespinasse.org>
In-Reply-To: <20220831011248.28632-4-michel@lespinasse.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 12:20:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVz6t3WOPjJZD_g45kKGXJmEkXHC1Bp=6NFrCUGEXf4g@mail.gmail.com>
Message-ID: <CAMj1kXFVz6t3WOPjJZD_g45kKGXJmEkXHC1Bp=6NFrCUGEXf4g@mail.gmail.com>
Subject: Re: [PATCH 3/4] Remove unused variable ret in efi_get_conf_table()
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 31 Aug 2022 at 03:13, Michel Lespinasse <michel@lespinasse.org> wrote:
>
> This avoids a build warning with CONFIG_EFI enabled.
>
> Fixes: 61c14ceda840 (x86/compressed/acpi: Move EFI config table lookup to helper)
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>

Can you combine this one with 2/4? (and add " inside the () on the fixes line)

> ---
>  arch/x86/boot/compressed/efi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index c42ee7874eb9..6ffd22710ed2 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -130,7 +130,6 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
>  {
>         unsigned long sys_tbl_pa;
>         enum efi_type et;
> -       int ret;
>
>         if (!cfg_tbl_pa || !cfg_tbl_len)
>                 return -EINVAL;
> --
> 2.20.1
>
