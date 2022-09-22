Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2455E5C82
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 09:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIVHe0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIVHeW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 03:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE2A0614;
        Thu, 22 Sep 2022 00:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 349EFB834B9;
        Thu, 22 Sep 2022 07:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04135C43470;
        Thu, 22 Sep 2022 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663832058;
        bh=UWNZukf959vr7tV71IoN5iXMlrYZ0jCCkoXyUvbqGDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tAPudcycVT75c9OdQbx/TXABgMYTqm1yO9MX1HbbKq8pe9I+lRCrq04kp4tornltH
         Q/P0Q/uvAUf/GMjGfg5U5EjVeO05oAhMgaWKb+dYWxexeF3oK0h3jIMkk8I1biG+1U
         SPk1rZLPsy68STuDSVhH5yW23huPIpGKMHb+GwJkjTDEO4JhudjUMoU7navs9G5WOY
         JHWhqh30JQEpd8xC1iJUZEIQfLIBVVp3u3CwJRrqZT8/BN4p0ph1Em45apct975uOq
         pA2+qXgPqVonDct1B/+9UvYRzh65/YfRO+ZFRVhJLQY3dcpaHTdIMGzVgYiX99eEf6
         irewgSOjTRClw==
Received: by mail-lf1-f47.google.com with SMTP id w8so13199826lft.12;
        Thu, 22 Sep 2022 00:34:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf0aBRF9+swgU8e046oL5KkFUXP9Gh3169gXlUwELNz/8SBr6ySe
        s1vRarGsuH6OkTv7TWrY883mrKIgHzVg0B9HNxc=
X-Google-Smtp-Source: AMsMyM7Ob46JJiYPZyBbHV3AQ/n88iL6T8+iJh07RAQ95rvs6j4Th6jDsnwnC+malWy9LRmG3Vk3fv1xa7hCIvSRzLM=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr691871lfb.583.1663832055899; Thu, 22
 Sep 2022 00:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220904165321.1140894-1-Jason@zx2c4.com>
In-Reply-To: <20220904165321.1140894-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 09:34:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGL4OV_Dpgtk+kQtDN0AHQBnwHwOQ-v76NkLFOVHirnRQ@mail.gmail.com>
Message-ID: <CAMj1kXGL4OV_Dpgtk+kQtDN0AHQBnwHwOQ-v76NkLFOVHirnRQ@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Wipe setup_data on pure EFI boot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Now that we've fixed this on the QEMU end without the need for a boot
protocol version bump [0], I am going to merge just the x86-stub.c
change as a fix for EFI.

Thanks,
Ard.

[0] https://lore.kernel.org/all/166383158063.107920.1563965268305325639.b4-ty@redhat.com/




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
> --
> 2.37.3
>
