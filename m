Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A83CBAF0
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPRN2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 13:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPRN2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 13:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65634613F3;
        Fri, 16 Jul 2021 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626455429;
        bh=8tHBLJthmsy9VAY9wET51UFI2vK1cDPaeKFdnxf+KQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TKqja2jhf2NveJ1m8iL1vGtkzUbLFo4447UQpEycH71r8XFBJO92bmthODR4bUxbh
         MPEOV2wR/xBIT/XayKT1MOej3JBKZE3N8qx5ypKLoejI/fTAE8N+9hO1tDSavBu4xf
         zl6oGefdOci1zl/pTOYIA7iBbCXJ27w+wUJrTCA2cgCcKhltnwU/7foKlZHLDHLJz6
         Wa2NgwkO1oI9ZTeaEkVfw2Bw1fslhHTbA3LHPg7Bv1/6Ml+UfBckfEVb4bu6ic5hsV
         qHHc1QMoxW/WHCPI9pvwCh3xCzD1q+o09lFeMxyn8e77wMJRX+1eD/jRhoQGWlhBRu
         MUqm27NoTDZTA==
Received: by mail-ot1-f43.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10581329otl.3;
        Fri, 16 Jul 2021 10:10:29 -0700 (PDT)
X-Gm-Message-State: AOAM532hFM3x14wtRkB4Bj+haKdoa9+ogxdpfcecs+DRmVXRMtsBJeq/
        MCkAh+SBLH+JRUVZPwZuQBQevJC/KR3Njy3SvCQ=
X-Google-Smtp-Source: ABdhPJzK8g33FWS/D8tDBDN8b/qXCd761VTHU3ScZMFxb5JZNRoOk/YawpY4018uRjfdhsjILOh3xWImfXKVrfnG2as=
X-Received: by 2002:a05:6830:3494:: with SMTP id c20mr2516657otu.108.1626455428797;
 Fri, 16 Jul 2021 10:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <YNwu7LmZaImyoOer@zn.tnic>
In-Reply-To: <YNwu7LmZaImyoOer@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 16 Jul 2021 19:10:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE--H53wu_X=GpgeJmWs7vjpnkUnG_fc+59GaNDF+sYEw@mail.gmail.com>
Message-ID: <CAMj1kXE--H53wu_X=GpgeJmWs7vjpnkUnG_fc+59GaNDF+sYEw@mail.gmail.com>
Subject: Re: [RFC PATCH] efi/mokvar: Reserve the table only if it is in boot
 services data
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>, Gary Lin <glin@suse.com>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 30 Jun 2021 at 10:44, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi guys,
>
> so below is what we've been staring at recently, please doublecheck me
> whether I'm even making sense here.
>
> Thx!
>
> ---
> From: Borislav Petkov <bp@suse.de>
>
> One of the SUSE QA tests triggered:
>
>   localhost kernel: efi: Failed to lookup EFI memory descriptor for 0x000000003dcf8000
>
> which comes from x86's version of efi_arch_mem_reserve() trying to
> reserve a memory region. Usually, that function expects
> EFI_BOOT_SERVICES_DATA memory descriptors but the above case is for the
> MOKvar table which is allocated in the EFI shim as runtime services.
>
> That lead to a fix changing the allocation of that table to boot services.
>
> However, that fix broke booting SEV guests with that shim leading to
> this kernel fix
>
>   8d651ee9c71b ("x86/ioremap: Map EFI-reserved memory as encrypted for SEV")
>
> which extended the ioremap hint to map reserved EFI boot services as
> decrypted too.
>
> However, all that wasn't needed, IMO, because that error message in
> efi_arch_mem_reserve() was innocuous in this case - if the MOKvar table
> is not in boot services, then it doesn't need to be reserved in the
> first place because it is, well, in runtime services which *should* be
> reserved anyway.
>
> So do that reservation for the MOKvar table only if it is allocated
> in boot services data. I couldn't find any requirement about where
> that table should be allocated in, unlike the ESRT which allocation is
> mandated to be done in boot services data by the UEFI spec.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Would you like me to queue this as a fix?

> ---
>  drivers/firmware/efi/mokvar-table.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
> index d8bc01340686..38722d2009e2 100644
> --- a/drivers/firmware/efi/mokvar-table.c
> +++ b/drivers/firmware/efi/mokvar-table.c
> @@ -180,7 +180,10 @@ void __init efi_mokvar_table_init(void)
>                 pr_err("EFI MOKvar config table is not valid\n");
>                 return;
>         }
> -       efi_mem_reserve(efi.mokvar_table, map_size_needed);
> +
> +       if (md.type == EFI_BOOT_SERVICES_DATA)
> +               efi_mem_reserve(efi.mokvar_table, map_size_needed);
> +
>         efi_mokvar_table_size = map_size_needed;
>  }
>
> --
> 2.29.2
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
