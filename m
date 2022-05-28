Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077EF536BE3
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiE1JZJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiE1JZI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:25:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E56B04;
        Sat, 28 May 2022 02:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BBF7B8009F;
        Sat, 28 May 2022 09:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60C2C34100;
        Sat, 28 May 2022 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653729903;
        bh=8frCxiKNd8eyxrEJcIesYdoOkj5o3mUQaDZcp8v+trM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9QrKOapiM1jkadFYPEwRzyE6o904p8q3NKhkQff6eFFsvRVbO4/z64BFnL5wftWq
         3ETgkqpmkrdzFd/aPafqAaPV/ykxIGTKbXY7v8EqhcdF88hHC9zBXuQc/qaHAbVTqV
         89e6XoDDdzsvSlulHpfNRdmKnPRNWjthouFKN1neDdNwFodsZgX1LEhAJL+avgLx1j
         E8KapNp9V1K//i6CeNKzQKL6xWOU7Y9BSR9Oo5bsouQXwpWuKqfdUMuCdIqE9EIv3P
         qd9NO2oGzPWOXTCbBQ6eYLhT2XXvuiC5wlhUG/COFRbV6r5dlZOeL9KhhfUKPLuekG
         BT4mfSouDLH5w==
Received: by mail-oi1-f169.google.com with SMTP id k187so4241600oif.1;
        Sat, 28 May 2022 02:25:03 -0700 (PDT)
X-Gm-Message-State: AOAM533Ts1CDQBXsxxPca2XnKOY4YLbrBGnWkXGAIpQhyx13C/Y05Sfe
        dEE8X9H3Ru3bzRo4T6MY1NrRlECW/LtY3+fknJ8=
X-Google-Smtp-Source: ABdhPJw/KSVIgB6CIM6hlCN2YWx6BBc/TVNQmZShe5tWZpx+UOt0hu9WYhl/UWHhHjKlIAuMBpGKGXrxUDU5+oJjr20=
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id
 k13-20020a0568080e8d00b00322bac02943mr6061590oil.126.1653729902924; Sat, 28
 May 2022 02:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <ea51a17e00a10f3ab25d94b9a5885eb9142aa12b.1653377840.git.geert@linux-m68k.org>
In-Reply-To: <ea51a17e00a10f3ab25d94b9a5885eb9142aa12b.1653377840.git.geert@linux-m68k.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 May 2022 11:24:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUiuSLLcuQ-H7A4djyJF_rdr9bD4JrCP_p98Qg3K=Fow@mail.gmail.com>
Message-ID: <CAMj1kXEUiuSLLcuQ-H7A4djyJF_rdr9bD4JrCP_p98Qg3K=Fow@mail.gmail.com>
Subject: Re: [PATCH v2] efi: EFI_DISABLE_RUNTIME should depend on EFI
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 May 2022 at 09:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The EFI_DISABLE_RUNTIME config option controls the use of Extensible
> Firmware Interface (EFI) runtime services, which matters only if EFI
> support is enabled.
>
> Hence add a dependency on EFI, to prevent asking the user about this
> control knob when configuring a kernel without EFI support.
>
> Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v2:
>   - Add Acked-by,
>   - Fix typo s/with/without/.
> ---
>  drivers/firmware/efi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Can we just move this option into the menu/endmenu scope that already
depends on EFI?

> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 4720ba98cec312e7..ff6e7bfa8355cfc2 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -299,6 +299,7 @@ config EFI_CUSTOM_SSDT_OVERLAYS
>
>  config EFI_DISABLE_RUNTIME
>         bool "Disable EFI runtime services support by default"
> +       depends on EFI
>         default y if PREEMPT_RT
>         help
>           Allow to disable the EFI runtime services support by default. This can
> --
> 2.25.1
>
