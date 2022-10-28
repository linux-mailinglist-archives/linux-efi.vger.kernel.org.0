Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD726115C1
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1PX7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJ1PX6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 11:23:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC51E045B;
        Fri, 28 Oct 2022 08:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6605BB82A02;
        Fri, 28 Oct 2022 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062DC433D7;
        Fri, 28 Oct 2022 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666970635;
        bh=04X5oSr/e+P4vQWL40g+kGvfi5UyRTsR70jTUsAvpYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BK5SZmgYmUt2+5rM0ijWkhjYEUY/E36+Cn3G2jT171M7STTQHuowCWP+075GQfqPl
         mlV0oAur0YlqhxeYbFvfOFv2e4XEeauIDEEMPEN4J3KtQwvxamDWlVMXLKaC/FEadI
         15QRgtooX2Ii1n8l8RuCpa31KBWJVUioKV0HkEcLjmij9hWTuAY52pyTCpy75TJuXc
         G5AYMOr/nPRKFAI4oR6JpUtJyd2OwaTdoZPapMYyuuHT7FveNxzgrj43LMRPBrya86
         QG+nr74THhL+PTAVFStDmYF2H2L4s8Wb+l+22ymA+L3+sAAOlbqyGGbGJs7dkBzTCS
         SFm2m/ZutDzOA==
Received: by mail-lf1-f53.google.com with SMTP id j4so8915298lfk.0;
        Fri, 28 Oct 2022 08:23:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf3LN904mgU2qwKof3Y0mZJghuLnzQRn5btectTarr5VrNXHnCgc
        H/YYUR/1pVC24SfA70Ikr0V4c3l76N6cOjoZU4c=
X-Google-Smtp-Source: AMsMyM5tSkQPhwd0B+zEmIlmCzhEQWN3masodL94g4z+yCmxWymoQo0hhjyEGkLQjY3PSTaAVSvk1VvB8KXDvlTelk0=
X-Received: by 2002:a19:6512:0:b0:4a9:32dd:39a4 with SMTP id
 z18-20020a196512000000b004a932dd39a4mr13274442lfb.539.1666970633008; Fri, 28
 Oct 2022 08:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221028115619.2814-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221028115619.2814-1-lukas.bulwahn@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Oct 2022 17:23:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4JE=MiRwFZE8pr2fUV7MgbtwVOUtg=y7pzX06==N7sg@mail.gmail.com>
Message-ID: <CAMj1kXF4JE=MiRwFZE8pr2fUV7MgbtwVOUtg=y7pzX06==N7sg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entry after arm64 efi-entry.S file movement
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-efi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 13:57, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 6ed27461c9c8 ("arm64: efi: Move efi-entry.S into the libstub source
> directory") moves arch/arm64/kernel/efi-entry.S to
> drivers/firmware/efi/libstub/arm64-entry.S, but misses to adjust the
> MAINTAINERS file.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
>
> Adjust the file entry in EXTENSIBLE FIRMWARE INTERFACE (EFI) to this file
> movement.
>
> As the file drivers/firmware/efi/libstub/arm64-entry.S is already covered
> by the entry drivers/firmware/efi/, simply remove the arm64 file entry.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, I'll queue this up along with the patch that moves the file.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4f908c28d7e..194ae5dd952e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7806,7 +7806,6 @@ F:        Documentation/admin-guide/efi-stub.rst
>  F:     arch/*/include/asm/efi.h
>  F:     arch/*/kernel/efi.c
>  F:     arch/arm/boot/compressed/efi-header.S
> -F:     arch/arm64/kernel/efi-entry.S
>  F:     arch/x86/platform/efi/
>  F:     drivers/firmware/efi/
>  F:     include/linux/efi*.h
> --
> 2.17.1
>
