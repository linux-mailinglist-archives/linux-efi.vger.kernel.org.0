Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C54FFD17
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiDMRu4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiDMRuz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483D36D4F3;
        Wed, 13 Apr 2022 10:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC07561F00;
        Wed, 13 Apr 2022 17:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A1C385AF;
        Wed, 13 Apr 2022 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649872110;
        bh=rXfDkPeJmPfsN9CvKqPiVkT9tTSzCYlnFO5RigKJiZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L7pZe7jouiphjoFQFjLLl3peapJ+CAYfkiP4o7LG/5MflRU9G0mMxj6Mor4ca3Vvv
         s6auGNi/jrXzlQWwspmdQGyu62sa343L92JRJRFQlzn64HZGDsRT/CB/hrETGaODzd
         4+hI948s4m26ifqVIb2W6Gv9vEVbsUdfoYI13MAvjS9/4nRAismntBCydzXqinxWc3
         FcGAm28E9pLxGjUGDKj5oToZoIGuyw7BsgU+etzeO8VnDd4KfgGC5z4bN++RZ19R7s
         I/HWTbN+vfkHoKlAlrcZUH4gJl8cXR+wsqRvnVkBdGFFDZPa5EUcsDqKXiswpvNpya
         V1Um2jmzwk4pg==
Received: by mail-oi1-f171.google.com with SMTP id b188so2817611oia.13;
        Wed, 13 Apr 2022 10:48:30 -0700 (PDT)
X-Gm-Message-State: AOAM531fpuMInRmwHXdyIisIwf9xUGmHqLILyKb0ji7M8EJ0MM9aqrxU
        Cwog9YCMYUyDJSZR8Y8Uol6BJoG6eeHUMw/d5Dc=
X-Google-Smtp-Source: ABdhPJzJENnQ6A7dfOs/l6Lv7AbqAFJCfnDuNoHaUGpNm7lPebf0Lu9rz01aM6S/bE10m++PwD0uRPA2sc4IeYWy3xg=
X-Received: by 2002:a05:6808:1513:b0:2fa:7a40:c720 with SMTP id
 u19-20020a056808151300b002fa7a40c720mr984410oiw.126.1649872109361; Wed, 13
 Apr 2022 10:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220329184712.vl7jzq23h5m5kvqh@redhat.com> <20220329184743.798513-1-pjones@redhat.com>
In-Reply-To: <20220329184743.798513-1-pjones@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:48:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFEGXnm_cz0AZUmQQd8dqAWUT=iNZk0eSqq34=BxiWwUA@mail.gmail.com>
Message-ID: <CAMj1kXFEGXnm_cz0AZUmQQd8dqAWUT=iNZk0eSqq34=BxiWwUA@mail.gmail.com>
Subject: Re: [PATCH] x86: Set the NX-compatibility flag in the PE header
To:     Peter Jones <pjones@redhat.com>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, 29 Mar 2022 at 20:47, Peter Jones <pjones@redhat.com> wrote:
>
> Following Baskov Evgeniy's "Handle UEFI NX-restricted page tables"
> patches, it's safe to set this compatibility flag to let loaders know
> they don't need to make special accommodations for kernel to load if
> pre-boot NX is enabled.
>
> Signed-off-by: Peter Jones <pjones@redhat.com>

Thanks, I've queued this up.

> ---
>  arch/x86/boot/header.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 6dbd7e9f74c..0352e4589ef 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -163,7 +163,11 @@ extra_header_fields:
>         .long   0x200                           # SizeOfHeaders
>         .long   0                               # CheckSum
>         .word   IMAGE_SUBSYSTEM_EFI_APPLICATION # Subsystem (EFI application)
> +#ifdef CONFIG_DXE_MEM_ATTRIBUTES
> +       .word   IMAGE_DLL_CHARACTERISTICS_NX_COMPAT     # DllCharacteristics
> +#else
>         .word   0                               # DllCharacteristics
> +#endif
>  #ifdef CONFIG_X86_32
>         .long   0                               # SizeOfStackReserve
>         .long   0                               # SizeOfStackCommit
> --
> 2.35.1
>
