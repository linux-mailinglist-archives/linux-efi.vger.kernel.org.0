Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB6597F04
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiHRHKj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbiHRHKi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 03:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F9895C6
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 00:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A747D616DF
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 07:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131ABC433D6
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660806637;
        bh=A3PFaAaOw8Ui4DsYBlWAZ3kAdZVg/i/O9q46izYu9lo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjdV3aeNj1M+LVt8RJwZkvJpVCEe+9B5x1A/D0twcuU3uKW0KJZTf/w9QHqiPQTKT
         zvY3LHpjDix0+z6ni738Ie3t8pnSa3W41slM6Cm5R4UdkMmSXPguHGtVeBpGYP9Sq3
         5tuqrRDFmPvnYsmZYorHwIQdLAzUgxNeb9TYrxJBZZ29wP6Oa+tdfEcKX/LoDQ9asI
         TKX6LHfYNavjYLmXGR8zFD3EYNNHQAkVcnIQjjdYklAVlnsEcHNo6MdAhlMeEKguHv
         X28GbtAM6teZSc2k0QIf6hkcMDdSAp3zTLrVE55UZ6G4ZHckIDeg0h6nphXuOu3hlX
         EaEs62uWsJwzg==
Received: by mail-wr1-f52.google.com with SMTP id e20so162411wri.13
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 00:10:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo2iJ7D8VdGXr978SRkXokB7o782X2ScCMcLQSsoya8fNk//Z/gs
        yitY2cz9H8xWirLCEdMgDORm3xm4rzBEZu3f9kc=
X-Google-Smtp-Source: AA6agR5Ascxvy4ROavsgX50BnQnlhAGsCTq6JXekHqKPYn7p6YT2jE5/K/62pAAlUUrcAy1UhsENdHNsqMFm/CbfDFE=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr787574wrs.380.1660806635200; Thu, 18 Aug
 2022 00:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
In-Reply-To: <20220818065635.243057-1-daniel.marth@inso.tuwien.ac.at>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 09:10:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
Message-ID: <CAMj1kXHEODYxkafLgTA83gYqJV+jFxOopWgJJNsURCVjbHR6Uw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable RNG structure randomization
To:     Daniel Marth <daniel.marth@inso.tuwien.ac.at>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org, clemens.hlauschek@inso.tuwien.ac.at
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

(cc Kees)

On Thu, 18 Aug 2022 at 08:58, Daniel Marth
<daniel.marth@inso.tuwien.ac.at> wrote:
>
> Randstruct by default randomizes structures that consist entirely of
> function pointers, even if they are not explicitly labeled for
> randomization. efi_rng_protocol contains an anonymous structure that is
> affected by this implicit selection process. Randomization of this
> structure causes a data layout inconsistency between the kernel and the
> EFI. In this scenario the Arm64 boot process fails with the following
> output:
>     EFI stub: Booting Linux Kernel...
>     EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000002)
>     EFI stub: Using DTB from configuration table
>     EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>     Synchronous Exception at 0x0000000081310C90
>     Synchronous Exception at 0x0000000081310C90
>
> efi_get_random_bytes() fails in handle_kernel_image (arm64-stub.c)
> because it uses an incorrect structure layout for efi_call_proto. Add
> the __no_randomize_layout annotation to the anonymous structure within
> efi_rng_protocol to prevent its randomization and resolve this issue.
>
> This patch was tested for the Arm64 architecture using QEMU. In
> addition to the current next branch of this subsystem, also minor
> versions 4.16 to 5.1, 5.5 and 5.6 were tested successfully with a
> (backported) version of this patch.
>
> Signed-off-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>

Thanks for the patch.

> ---
>  drivers/firmware/efi/libstub/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
> index 24aa37535372..54fa980cf1af 100644
> --- a/drivers/firmware/efi/libstub/random.c
> +++ b/drivers/firmware/efi/libstub/random.c
> @@ -18,7 +18,7 @@ union efi_rng_protocol {
>                 efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
>                                                  efi_guid_t *, unsigned long,
>                                                  u8 *out);
> -       };
> +       } __no_randomize_layout;
>         struct {
>                 u32 get_info;
>                 u32 get_rng;

This may work around the problem, but I'd like to fix this more
thoroughly if we can. EFI protocols are not randomizable by nature, as
they are a contract between the firmware and the OS, so struct
randomization should just be disabled for the entire EFI stub, i.e.,
everything below libstub/

Kees?
