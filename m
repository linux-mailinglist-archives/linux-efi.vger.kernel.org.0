Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B69536BC6
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiE1JNZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiE1JNX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C426A;
        Sat, 28 May 2022 02:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D18260C61;
        Sat, 28 May 2022 09:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB29C34118;
        Sat, 28 May 2022 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653729199;
        bh=7bnoiHIViPgO9U0WBW7xtT2w4ftinyPcd5Qmfmeu5kY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eb2KkxmW/U6ZjycuVvCALb0qStoqFaa+17w+kMmOA792eQViI1RUTJW2omfWHCY+8
         /p/mdBGBFl4IsVSBb5qf8j4HRupWvffVZ34Jiwt+G8bn+INuzkqqfqb4sXBQf+Q4oV
         lgHRw8fC9K/pbxWBRnVloPMcCnkYXwrv9E1yRexYxWIEtTLZrOrwJJGKoekPhqE6yK
         as1W3uhSrYFXTsSharfEBtivlq8QYti8lGBk2YosQ6wehjlO080YglenVjeSdwdsJi
         81LPcxg2Fk2cymozZa7vTiT/OxpaJ2QDlVnMG9l/QQziU1owNdM58oGKiuDXyAvlkq
         lnIoFTld2jIiA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-edeb6c3642so8488062fac.3;
        Sat, 28 May 2022 02:13:19 -0700 (PDT)
X-Gm-Message-State: AOAM533vZjOs9thkXF/o5aj0PsKtcJxVbfuTBRv0Jl7Vxkp5LFkl3tyx
        duPnAwl23w76A/m59k+ENRphhVgy+gbWMC3P8Ac=
X-Google-Smtp-Source: ABdhPJxZtGgnd64LAweAANO6XIozQibeM29xEcVKUYcAJvUbDi+OAN2iDLx4o0nLK83aa5xyfeeYn2AwDK0IEfWRnrc=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr6130869oap.228.1653729198931; Sat, 28
 May 2022 02:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220528014132.91052-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20220528014132.91052-1-heinrich.schuchardt@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 May 2022 11:13:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
Message-ID: <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
Subject: Re: [PATCH] riscv: read-only pages should not be writable
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 28 May 2022 at 03:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If EFI pages are marked as read-only,
> we should remove the _PAGE_WRITE flag.
>
> The current code overwrites an unused value.
>
> Fixes: b91540d52a08b ("RISC-V: Add EFI runtime services")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/kernel/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
> index 024159298231..1aa540350abd 100644
> --- a/arch/riscv/kernel/efi.c
> +++ b/arch/riscv/kernel/efi.c
> @@ -65,7 +65,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
>
>         if (md->attribute & EFI_MEMORY_RO) {
>                 val = pte_val(pte) & ~_PAGE_WRITE;
> -               val = pte_val(pte) | _PAGE_READ;
> +               val |= _PAGE_READ;
>                 pte = __pte(val);
>         }
>         if (md->attribute & EFI_MEMORY_XP) {
> --
> 2.36.1
>

Thanks Heinrich

Queued in efi/urgent.
