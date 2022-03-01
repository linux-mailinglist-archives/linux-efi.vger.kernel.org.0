Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C314C84DA
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiCAHXP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 02:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCAHXO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 02:23:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40588AE4A
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 23:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C306661265
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 07:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCEC340F1
        for <linux-efi@vger.kernel.org>; Tue,  1 Mar 2022 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646119352;
        bh=fHfDEZglU+D9ySzmYpuwb5Qm8giKLtfpZqQ44ZuAyoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cfVIpn4pKJlv6Epg1ZrC3VZpU6Z2NlOUasC0K1NaI1B0vDk2deqGnogGUGJ1A0ETc
         Uky7rqC9h0jIGVUjLanHftDh/Z82e7Vc54eFY978yT8OMlyTzJ3Qu1LD5HmRzw8X3n
         dp+9ocOUnKFiR7VXGuB2KILVfKhqPwC/luUL5cYwArOf2dv2v3p6IRN43mGYzilw42
         U74pK9BbzUxci0P9inhGey4Li+8M1hWgyRpae5R7n/GqrFpAQWNb01XmxrRoT1o6C1
         +/LlX7+eWorAWn+ZL4jcb9xb+OePiouZiWeNxE3pSFDI1txDh60Vy4KM/J5Zd0jmk4
         lR36yoxmHRL2A==
Received: by mail-yb1-f174.google.com with SMTP id u61so30723ybi.11
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 23:22:32 -0800 (PST)
X-Gm-Message-State: AOAM5328PWo4qLSBl//wXNt8M7Q0CU0M29OLi2I0P/RdgKNa+wZ4p0ZS
        cW4IFaSnrF1vwsXgr+0ZYdPG4vD4r37NpmM/eOM=
X-Google-Smtp-Source: ABdhPJznZyvXhtggJluA+s182gImJLJ0/Q4zpF2RolEFeiLL3aMehuTgGCPGDVPFjp6NPEHaKEoZSLhh2HQJuBIHCj4=
X-Received: by 2002:a25:e014:0:b0:619:a368:c3b5 with SMTP id
 x20-20020a25e014000000b00619a368c3b5mr22069332ybg.383.1646119351167; Mon, 28
 Feb 2022 23:22:31 -0800 (PST)
MIME-Version: 1.0
References: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
In-Reply-To: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Mar 2022 08:22:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com>
Message-ID: <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com>
Subject: Re: [Question] Should retain 2M alignment if kernel image is bad
 aligned at entry or BSS overlaps?
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Mar 2022 at 07:50, Kefeng Wang <wangkefeng.wang@huawei.com> wrote=
:
>
> Hi Ard=EF=BC=8CWill and all maintainer=EF=BC=8C
>
> As commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again
> for relocatable kernels") saids, a relocatable image does not need to
> be copied to a 2M aligned offset if it was loaded on a 64k boundary
> (for a 4 KB granule kernel) by EFI. But if there is some FIRMWARE BUG,
>
> 1) kernel image not aligned on 64k boundary
> or
> 2) Image BSS overlaps adjacent EFI memory region
>
> When kaslr is disabled(eg, EFI_RNG_PROTOCOL unavailable), it will leads
> KPTI forced ON after kernel image relocated, message shown below,
>
>    CPU features: kernel page table isolation forced ON by KASLR
>    ...
>    KASLR disabled due to lack of seed
>
> The KASLR don't enabled actually, and KPTI is forced enabled which could
> affect performance.
>

This message is misleading. If the alignment modulo 2M !=3D 0, we still
have 5 bits of 'randomization', although these bits are probably
highly predictable on a given system.

> I found commit 7c116db24d94 ("efi/libstub/arm64: Retain 2MB kernel Image
> alignment if !KASLR") in v5.8, should we retain 2M alignment if kernel im=
age
> is bad aligned at entry or BSS overlaps?
>

Personally, I think we're doing enough already to deal with Redhat's
broken out-of-tree GRUB/SHIM concoction, which is the primary reason
for these workarounds  IIRC.

You can already pass nokalsr on the kernel command line if you want to
avoid the downsides entirely, so as I understand it, this is mostly
about an unquantified performance gain on systems that use a broken
bootloader and lack the entropy source for a KASLR seed, but are not
able to put nokaslr on the command line?


>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c
> b/drivers/firmware/efi/libstub/arm64-stub.c
> index 9cc556013d08..47ecd9b80db3 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -87,6 +87,7 @@ efi_status_t handle_kernel_image(unsigned long
> *image_addr,
>   {
>          efi_status_t status;
>          unsigned long kernel_size, kernel_memsize =3D 0;
> +       bool need_2m_aligned =3D false;
>          u32 phys_seed =3D 0;
>
>          /*
> @@ -119,9 +120,11 @@ efi_status_t handle_kernel_image(unsigned long
> *image_addr,
>          if (image->image_base !=3D _text)
>                  efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base
> has bogus value\n");
>
> -       if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
> +       if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN)) {
> +               need_2m_aligned =3D true;
>                  efi_err("FIRMWARE BUG: kernel image not aligned on %dk
> boundary\n",
>                          SEGMENT_ALIGN >> 10);
> +       }
>
>          kernel_size =3D _edata - _text;
>          kernel_memsize =3D kernel_size + (_end - _edata);
> @@ -142,6 +145,7 @@ efi_status_t handle_kernel_image(unsigned long
> *image_addr,
>
>          if (status !=3D EFI_SUCCESS) {
>                  if (!check_image_region((u64)_text, kernel_memsize)) {
> +                       need_2m_aligned =3D true;
>                          efi_err("FIRMWARE BUG: Image BSS overlaps
> adjacent EFI memory region\n");
>                  } else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
>                          /*
> @@ -152,7 +156,8 @@ efi_status_t handle_kernel_image(unsigned long
> *image_addr,
>                          *reserve_size =3D 0;
>                          return EFI_SUCCESS;
>                  }
> -
> +               if (efi_nokaslr & need_2m_aligned)
> +                       min_kimg_align =3D MIN_KIMG_ALIGN;
>                  status =3D efi_allocate_pages_aligned(*reserve_size,
> reserve_addr,
>                                                      ULONG_MAX,
> min_kimg_align);
