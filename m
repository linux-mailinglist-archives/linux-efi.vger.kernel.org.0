Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3F5340A7
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiEYPtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiEYPtN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 11:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D934649;
        Wed, 25 May 2022 08:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4105A61520;
        Wed, 25 May 2022 15:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C77C34117;
        Wed, 25 May 2022 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653493750;
        bh=bIicfEgP7s139tN40AgWtxDRRKGzaemz0C3u+wU/Nvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zu8BQxKJOgVnmy8Qd3W+MW8TvMDQ4wUY7ngpChp1UIxpfL9uhVVt7AmSxzd4JIRVd
         Ji9Fvgy6dUznbLvDkTxuqwrkO5N7YL3xCam3jVmgNGnydVKb7hVhpqCCXJaY7c495S
         IK4G2F7g3ZgBjVctlZm9TIRCP9vZV1JsLkp2fRDU1hboXSIUN84t7Nb6eaTzxLV96M
         xCwTTFvnvBJK/rF95CRD2qVJIwbKIbdK51cwThSzPRV8W/CONMHH68ymqCYCZlTxhw
         V6V1EZWNU/vpu4HuhVdZQUAROSli/+9QCCmq4nQ6swrCPMkGtanlvLnh4Ln9j9oqoP
         N7khJpD9nlwlg==
Received: by mail-oi1-f181.google.com with SMTP id i66so25453118oia.11;
        Wed, 25 May 2022 08:49:10 -0700 (PDT)
X-Gm-Message-State: AOAM532bIn9/AHRJ4hZppAypfZYSOLtCJ0VoO0VvTCElxEGsCf0+ueb5
        8JqCqDqdEOlWfVJ2Nziv21K1d9g32SHfu2Ifii4=
X-Google-Smtp-Source: ABdhPJxnXJzrIyy8yO9mGD/gM/HbAak5d4lmmJ0bhfehuzIYYF0oUNCap51EuqhgtyNx3s2OqxWIqc1veKX9La0GSYk=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr5701111oil.126.1653493749757; Wed, 25
 May 2022 08:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com> <20220525151106.2176147-6-sunilvl@ventanamicro.com>
In-Reply-To: <20220525151106.2176147-6-sunilvl@ventanamicro.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 May 2022 17:48:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
Message-ID: <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>
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

On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> The boot-hartid can be a 64bit value on RV64 platforms. Currently,
> the "boot-hartid" in DT is assumed to be 32bit only. This patch
> detects the size of the "boot-hartid" and uses 32bit or 64bit
> FDT reads appropriately.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 9e85e58d1f27..d748533f1329 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
>  {
>         const void *fdt;
>         int chosen_node, len;
> -       const fdt32_t *prop;
> +       const void *prop;
>
>         fdt = get_efi_config_table(DEVICE_TREE_GUID);
>         if (!fdt)
> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
>                 return -EINVAL;
>
>         prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
> -       if (!prop || len != sizeof(u32))
> +       if (!prop)
> +               return -EINVAL;
> +
> +       if (len == sizeof(u32))
> +               hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
> +       else if (len == sizeof(u64))
> +               hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);

Does RISC-V care about alignment? A 64-bit quantity is not guaranteed
to appear 64-bit aligned in the DT, and the cast violates C alignment
rules, so this should probably used get_unaligned_be64() or something
like that.


> +       else
>                 return -EINVAL;
>
> -       hartid = fdt32_to_cpu(*prop);
>         return 0;
>  }
>
> --
> 2.25.1
>
