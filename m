Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E44713BDB
	for <lists+linux-efi@lfdr.de>; Sun, 28 May 2023 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE1Ssn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 May 2023 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjE1Ssl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 May 2023 14:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38AC7;
        Sun, 28 May 2023 11:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2676C612C9;
        Sun, 28 May 2023 18:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5C0C4339B;
        Sun, 28 May 2023 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685299719;
        bh=wIKGlFp7LMtsiWUpZXvYhc0kZl7BO4BqFuhiCBEZ0jY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ah95ftF4Lkni6XKkcdDOIDB52QLC3fsGztdLvwUSPfZgtpkca7GfXehxxJKQTkSVa
         QZPwiAaGxiORl7kfQlkYtfITthd+yNki0E1PylJY+H82uaNBTuHIhx+omdcv8do+Gi
         PUUMo416BZsFU3NFs8o8tyDj6XJmKeNBtoHhQH1au88Olf3N/5664B/cwYBiY3Zw82
         ZoFDz0Zpprm9hqQH78X7iJKyK3cq5f98ZCZYIJlHSqgN3IxgwJ/fXiuirG9+cdI3b9
         VqzxKc3cbU7fDMllW4Htf50SsYEA3Zl9Yb8BTdGYLVAl84ega85/9JOB/Qhj5BmSd3
         ELcp+nosMe3yQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2af20198f20so26228841fa.0;
        Sun, 28 May 2023 11:48:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDzinyUcjl+9a249jFM5JZKEsHeTW871p6iGtjj/JJ2RF0pqY9b1
        m/8oWrwJo3+5671ct1ExLSDj0LyD19OzqH5fS1k=
X-Google-Smtp-Source: ACHHUZ6ueMWlbTHYVXUTWq9+acUOXLz1n9CCwK2QxNPUx6ElHrbLqafIM0mg9tekmNBIfEiL04AmioSpGCHo+jc52G4=
X-Received: by 2002:a2e:8654:0:b0:2a8:bf74:61cc with SMTP id
 i20-20020a2e8654000000b002a8bf7461ccmr3358489ljj.26.1685299717575; Sun, 28
 May 2023 11:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
In-Reply-To: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 28 May 2023 20:48:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
Message-ID: <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
Subject: Re: [PATCH] efi: bump efistub version from 1.1 to 3.0 for
 VZLinuxBootLoader compatibility
To:     Akihiro Suda <suda.kyoto@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, Linux x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 28 May 2023 at 09:59, Akihiro Suda <suda.kyoto@gmail.com> wrote:
>
> - LINUX_EFISTUB_MAJOR_VERSION is bumped from 1 (0b1) to 3 (0b11).
>   The value is now a bitfield.
>

OK

> The next version will be 7 (0b111).

How so? If this is going to be a monotonically increasing sequence
after all, it is still not a bit mask, and this change defeats the
purpose.

> - LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
>   VZLinuxBootLoader [1] cannot boot a kernel with other minor version value [2],
>   even though it does not use UEFI. Tested with macOS 13.4 (x86_64).
>
> [1] https://developer.apple.com/documentation/virtualization/vzlinuxbootloader
> [2] https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4YgJ=hN1xX7AD940YKf3A@mail.gmail.com/
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217485
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

I'll queue this as a fix, but I'm going to tweak the comment (and the
commit log) a bit, if you don't mind

I'd appreciate it if you still report this as a bug with Apple, though.

Thanks,
Ard.

> ---
>  include/linux/pe.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 5e1e11540870..ee5ade19b7eb 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -27,9 +27,25 @@
>   * On x86, LoadImage() and StartImage() can be omitted if the EFI handover
>   * protocol is implemented, which can be inferred from the version,
>   * handover_offset and xloadflags fields in the bootparams structure.
> + *
> + * Linux EFI stub v1.1 unconditionally enabled initrd command line loader,
> + * which was previously gated by CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER.
> + *
> + * Linux EFI stub v3.0 changed the major version to be a bitfield (0b11).
> + * The rightmost bit means that it is compatible with v1.0 at least.
> + * The second rightmost bit means that initrd command line loader is enabled.
> + * So, there is no v2.0 (0b10), and the next version will be v7.0 (0b111).
> + */
> +#define LINUX_EFISTUB_MAJOR_VERSION            0x3
> +
> +/*
> + * LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
> + * VZLinuxBootLoader cannot boot a kernel with other minor version value, even
> + * though it does not use UEFI. Tested with macOS 13.4 (x86_64).
> + *
> + * https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4YgJ=hN1xX7AD940YKf3A@mail.gmail.com/
>   */
> -#define LINUX_EFISTUB_MAJOR_VERSION            0x1
> -#define LINUX_EFISTUB_MINOR_VERSION            0x1
> +#define LINUX_EFISTUB_MINOR_VERSION            0x0
>
>  /*
>   * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of EFI bootable
> --
> 2.39.2
