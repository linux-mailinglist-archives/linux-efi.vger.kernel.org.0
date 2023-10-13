Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDE7C8325
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJMKdI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJMKdI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 06:33:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3700CAD;
        Fri, 13 Oct 2023 03:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E1C433C7;
        Fri, 13 Oct 2023 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193186;
        bh=BsRRCTgfv4s5mcrfc+WIgfWAClijm+lJdkXG/FXGv/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bnd971Q/aaYTrHovJzLffi+8pUc0hGYORkTU2UvVIyHJfn+N6QHUmkYF+zGkD+Pwa
         LRaJ6/fH0ablh8WSd2Gn76oebFaPRTUyvGEuLRicCp2d774vdxJcj7ldTKqgga9wt8
         /y00u1nJF/SpZ3VRvdD4ZqRMHE/KskkR6K4AkiwL+PiB/RO+rPamhg3EovostCfDBe
         nf0NzDOVEbT9exasxpGnz/YiNaVmg8aMShFZC8f5nc/uwn094glhrCAfoERnC7fyd9
         s+fEd2nd7Dl5KWEaiuhYJtZSw3lBWW5+PdSV/8bJw3NHe9KQmpZcoal4g7S5+CLZS8
         v5e67AnlFx/Fg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so24755651fa.1;
        Fri, 13 Oct 2023 03:33:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwvRPoh6MzrqHA6oaWIDjZfsi+gNh4vQW/dctM1z0GtSWKFQ9O/
        XqsXoGdJF8Ufb1WiiLwxmn+R4Qun8IoOIfBvzBE=
X-Google-Smtp-Source: AGHT+IEcmQ1koUnadDPbmNAb6Or28OqOh2gwk8K2meuy0IWSaCApBpczYyrv+j5YoMkoPYIYhSUVePCgKKoI6UNuvmE=
X-Received: by 2002:a2e:a98e:0:b0:2c5:1c4:9005 with SMTP id
 x14-20020a2ea98e000000b002c501c49005mr2236389ljq.32.1697193185025; Fri, 13
 Oct 2023 03:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230924142633.1090000-1-visitorckw@gmail.com>
In-Reply-To: <20230924142633.1090000-1-visitorckw@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Oct 2023 12:32:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2Xb-M8EQPY9bKy_3Dg9hXVypJb6C2DGeJsPydQ_yRmg@mail.gmail.com>
Message-ID: <CAMj1kXE2Xb-M8EQPY9bKy_3Dg9hXVypJb6C2DGeJsPydQ_yRmg@mail.gmail.com>
Subject: Re: [PATCH] efi: fix memory leak in krealloc failure handling
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 24 Sept 2023 at 16:26, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> In the previous code, there was a memory leak issue where the
> previously allocated memory was not freed upon a failed krealloc
> operation. This patch addresses the problem by releasing the old memory
> before setting the pointer to NULL in case of a krealloc failure. This
> ensures that memory is properly managed and avoids potential memory
> leaks.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/firmware/efi/efi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Queued as a fix

Thanks,

> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ce20a60676f0..1974f0ad32ba 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -273,9 +273,13 @@ static __init int efivar_ssdt_load(void)
>                 if (status == EFI_NOT_FOUND) {
>                         break;
>                 } else if (status == EFI_BUFFER_TOO_SMALL) {
> -                       name = krealloc(name, name_size, GFP_KERNEL);
> -                       if (!name)
> +                       efi_char16_t *name_tmp =
> +                               krealloc(name, name_size, GFP_KERNEL);
> +                       if (!name_tmp) {
> +                               kfree(name);
>                                 return -ENOMEM;
> +                       }
> +                       name = name_tmp;
>                         continue;
>                 }
>
> --
> 2.25.1
>
