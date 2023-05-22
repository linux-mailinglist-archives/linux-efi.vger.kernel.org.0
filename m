Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7587C70BFE8
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjEVNjU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjEVNjT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 09:39:19 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD258C2
        for <linux-efi@vger.kernel.org>; Mon, 22 May 2023 06:39:18 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-55239f43426so2936668eaf.1
        for <linux-efi@vger.kernel.org>; Mon, 22 May 2023 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684762758; x=1687354758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkmFikp/jxKF4FTgE3FbY5WGIJ+hJj3jly5LGHNgHvA=;
        b=T9nSgU0qo2a0mSFsY7YK6fmsTGsgfbAgeKKF4km7MWo7MJFxmD98kJTNCgMdoy9S8J
         UGJRVL4cUn4q4R7jtapdLLLx7wesH7Vdp3H6XN6rp8LZJjttK/9VMErI12/IN1BfGVjQ
         zVNBUzfvBhDKrY3abL3Ugyg8mIkc7XXsO5jgY9sSJXqNf7XNkOlzizej6C+kJga0JmLJ
         pUsV1jpcjxTXHuY+dQRA8HtprHBeG4FTgMDyFfiG0A8G7drkLeTYNJ3ppF45zhLDicc/
         G9ZOfwt/0K2Xg42jO+bDP1Nyb5+Y92HJeWTmLdgHnQrPglxkLQ1JNQfAm91mr7jji6w6
         hLEg==
X-Gm-Message-State: AC+VfDxebuTNI5HSGfBkt2xc2jm7YqdoHvA5IzkJV6I3R74coVStpDn4
        BFHXkhzQ2brHzlErldQ3YD2COBrPXkzX6Vywv+A=
X-Google-Smtp-Source: ACHHUZ4AsJreRsuBFry5TpO3wPTmjaSygrY5O49cPsCyu/u7Mu3zjJ3ATArKB4o+JYLKlXGyuqJAt+xB+RCrxr65q6E=
X-Received: by 2002:a4a:3912:0:b0:555:411b:f890 with SMTP id
 m18-20020a4a3912000000b00555411bf890mr1808051ooa.5.1684762758078; Mon, 22 May
 2023 06:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230522063319.501481-1-ardb@kernel.org>
In-Reply-To: <20230522063319.501481-1-ardb@kernel.org>
From:   Alan Bartlett <ajb@elrepo.org>
Date:   Mon, 22 May 2023 14:39:01 +0100
Message-ID: <CA+_WhHzeL8Ww_UHfQGuyYeXmC2kVWjvgL_mcrq9DDyGX+g9xHA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: zboot: Avoid eager evaluation of objcopy flags
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, bagasdotme@gmail.com,
        Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 May 2023 at 07:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The Make variable containing the objcopy flags may be constructed from
> the output of build tools operating on build artifacts, and these may
> not exist when doing a make clean.
>
> So avoid evaluating them eagerly, to prevent spurious build warnings.
>
> Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile.zboot | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 89ef820f3b34483a..2c489627a8078945 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -32,7 +32,8 @@ zboot-size-len-$(CONFIG_KERNEL_GZIP)   := 0
>  $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
>         $(call if_changed,$(zboot-method-y))
>
> -OBJCOPYFLAGS_vmlinuz.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
> +# avoid eager evaluation to prevent references to non-existent build artifacts
> +OBJCOPYFLAGS_vmlinuz.o = -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
>                           --rename-section .data=.gzdata,load,alloc,readonly,contents
>  $(obj)/vmlinuz.o: $(obj)/vmlinuz FORCE
>         $(call if_changed,objcopy)
> --
> 2.39.2
>
Yes, that fixes the warning. So --

Tested-by: Alan Bartlett <ajb@elrepo.org>

Than you.

Alan.
