Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB1532172
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 05:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiEXDG1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 May 2022 23:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiEXDG0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 May 2022 23:06:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE326C57F;
        Mon, 23 May 2022 20:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 899AFB810BF;
        Tue, 24 May 2022 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E3AC385AA;
        Tue, 24 May 2022 03:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653361583;
        bh=GGALU1orpB9Ze7CcmithKrs2KKURm55Ba+b50l3Rk4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QRDrguPmh8T2cyV8CGha0jK30XmFVpKLFUFRIoRCx+47i1rE3g6meHXWovzkXA12I
         z+dB1d2f0zDUXf0tSQ7omrCW9DHfPtXCvtdHFOWpQwVIOA1XzQWYP34cE3M+v6FoIq
         wsSJASY0urk6w2EhApwoIeaDh0awh8vcsRW9fE4teqZBMCmQIa6ll16rCNfd/NjU8S
         9USx3bpWtECrlas3cRKOs68Qw0JKgbKFDvxAX+uhERQ3CT80UXR6p2lCOVaufhCi0v
         Ai6UBxTRBJaETDLbKsIXeifBmV3MxPAe/HLlUvwZq1tqTSXunGKlvylxxwSL1a8xxp
         +RmcO+d5co16w==
Received: by mail-vs1-f46.google.com with SMTP id i186so16913949vsc.9;
        Mon, 23 May 2022 20:06:23 -0700 (PDT)
X-Gm-Message-State: AOAM531BvERJSkRJ3fulJxlhDs6OE0kUhk3a7nLRNXIR3LKQx5Oc+LBK
        Uv1p7kN2KBU4X4084snNTtswqB4ONDSn9KsTrZM=
X-Google-Smtp-Source: ABdhPJz2xIWsjk6hM2//jQCGYWAlWKwbeCDaPOmPkgowdyODwqr5x3hf34N9Do29eOThkGwk/nvO/ifZ+/XQZEp9qmg=
X-Received: by 2002:a67:f58f:0:b0:335:d1e6:d5d3 with SMTP id
 i15-20020a67f58f000000b00335d1e6d5d3mr9605080vso.16.1653361582191; Mon, 23
 May 2022 20:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <1653360644-28872-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1653360644-28872-1-git-send-email-baihaowen@meizu.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 11:06:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com>
Message-ID: <CAAhV-H7Xw-LPdHg1mVF1aZ67RQACBP0kans+moZ3GaRb5PF6VA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: take size of pointed value, not pointer
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Haowen,

On Tue, May 24, 2022 at 10:52 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> Sizeof a pointer-typed expression returns the size of the pointer, not
> that of the pointed data.
Your patch is correct, but the original patch hasn't been upstream, I don't
know how to handle it.

>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  arch/loongarch/kernel/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index f9fdeb1ae358..f0e5d0feffc2 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -180,7 +180,7 @@ void __init efi_init(void)
>         if (!efi_system_table)
>                 return;
>
> -       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(efi_systab));
> +       efi_systab = (efi_system_table_t *)early_memremap_ro(efi_system_table, sizeof(*efi_systab));
>         if (!efi_systab) {
>                 pr_err("Can't find EFI system table.\n");
>                 return;
> --
> 2.7.4
>
