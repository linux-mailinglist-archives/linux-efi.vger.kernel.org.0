Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2A5ACF40
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiIEJz1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiIEJzM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 05:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F815819;
        Mon,  5 Sep 2022 02:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB37611CF;
        Mon,  5 Sep 2022 09:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905A5C43149;
        Mon,  5 Sep 2022 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662371705;
        bh=p/hZZQfXVB53FJBWF7j3FpAyiHw5KDaNLiNMcE3mfIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rq7gzcBgJ34JoEbTvJCVMmU2DjYBpUdsXZ9L4C3XmUsbdq8Kx66f7F8iWjjQJUgIl
         xlX9iGBDdf47a+Pq1rzIqtSUUWDxZVxCKPfAsVzC9OGhm0eVPR/lsE3EouchsKpoxJ
         dyR/+C0ktn39DtDb58JBHT7DiL7TqQhbdfro1la+pEP0uVBu0IlCE9W4B1Ku5PUHrR
         s+JHmFobzPyXfVbOwCoP+Z/q6D8RFfAbf0jzYAWTbL14O51SGyzroonpjkw8Rx6Dhn
         0NmVIMC+umwd7gCMAIFaT9smMYnR7Fm/ptaw4ups5CN5RlV2TwPmtA76gQw/zmHOcN
         +qoxxzgUYIkRQ==
Received: by mail-lj1-f177.google.com with SMTP id r27so8255109ljn.0;
        Mon, 05 Sep 2022 02:55:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo0HV13CriJzVkbC/s8Um/ZWIt2CMIQstTGMqD3VQ6WApeRINIx6
        SX29rk5Okmd8ki65iKCiDH/AM1oNvrtSb1Bvazg=
X-Google-Smtp-Source: AA6agR74qr/IhvSulb7MCEB2/G+zfUAzBmaVxPkTM6dWs5M5LaMwIOL6SxIu3GjCOD3z2kuoQMygclwTwrjb4YPV4KA=
X-Received: by 2002:a2e:3006:0:b0:266:6677:5125 with SMTP id
 w6-20020a2e3006000000b0026666775125mr10170474ljw.352.1662371703513; Mon, 05
 Sep 2022 02:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220904165321.1140894-1-Jason@zx2c4.com>
In-Reply-To: <20220904165321.1140894-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 11:54:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHC9Wfr74761gPcG=N8OC2P76FqSb8FVGWM7x1p-4hQKg@mail.gmail.com>
Message-ID: <CAMj1kXHC9Wfr74761gPcG=N8OC2P76FqSb8FVGWM7x1p-4hQKg@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Wipe setup_data on pure EFI boot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de
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

On Sun, 4 Sept 2022 at 18:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> When booting the x86 kernel via EFI using the LoadImage/StartImage boot
> services [as opposed to the deprecated EFI handover protocol], the setup
> header is taken from the image directly, and given that EFI's LoadImage
> has no Linux/x86 specific knowledge regarding struct bootparams or
> struct setup_header, any absolute addresses in the setup header must
> originate from the file and not from a prior loading stage.
>
> Since we cannot generally predict where LoadImage() decides to load an
> image (*), such absolute addresses must be treated as suspect: even if a
> prior boot stage intended to make them point somewhere inside the
> [signed] image, there is no way to validate that, and if they point at
> an arbitrary location in memory, the setup_data nodes will not be
> covered by any signatures or TPM measurements either, and could be made
> to contain an arbitrary sequence of SETUP_xxx nodes, which could
> interfere quite badly with the early x86 boot sequence.
>
> (*) Note that, while LoadImage() does take a buffer/size tuple in
> addition to a device path, which can be used to provide the image
> contents directly, it will re-allocate such images, as the memory
> footprint of an image is generally larger than the PE/COFF file
> representation.
>
> Next, in order to allow hypervisors to still use setup_data in scenarios
> where it may be useful, bump the x86 boot protocol version, so that
> hypervisors, e.g. QEMU in the linked patch, can do the right thing
> automatically depending on whether it is safe.
>
> Link: https://lore.kernel.org/qemu-devel/20220904165058.1140503-1-Jason@zx2c4.com/
> Coauthored-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/boot/header.S                  | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index f912d7770130..e4e2d6e33924 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -307,7 +307,7 @@ _start:
>         # Part 2 of the header, from the old setup.S
>
>                 .ascii  "HdrS"          # header signature
> -               .word   0x020f          # header version number (>= 0x0105)
> +               .word   0x0210          # header version number (>= 0x0105)
>                                         # or else old loadlin-1.5 will fail)
>                 .globl realmode_swtch
>  realmode_swtch:        .word   0, 0            # default_switch, SETUPSEG
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 05ae8bcc9d67..9780f32a9f24 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -517,6 +517,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>         hdr->ramdisk_image = 0;
>         hdr->ramdisk_size = 0;
>
> +       /*
> +        * Disregard any setup data that was provided by the bootloader:
> +        * setup_data could be pointing anywhere, and we have no way of
> +        * authenticating or validating the payload.
> +        */
> +       hdr->setup_data = 0;
> +
>         efi_stub_entry(handle, sys_table_arg, boot_params);
>         /* not reached */
>

if the x86 folks are ok with this, I would like to send this to
cc:stable, but I imagine retroactively changing the header version
number might be something they would prefer to avoid. In that case,
better to split these up.

Also, care to update Documentation/x86/boot.rst to document the new behavior?
