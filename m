Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E4603A41
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJSHBo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJSHBn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD375FF1;
        Wed, 19 Oct 2022 00:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BEE6178A;
        Wed, 19 Oct 2022 07:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC0EC43143;
        Wed, 19 Oct 2022 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666162899;
        bh=TPYrh4CPVfRLN+C3/bGZqWeNBfavnKMli+K2H62eo98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r6mSyjUGVoTdv9Yo6KSTDZ6Oz3pcJmMy0oOJj5rDiey6VaRYCh43jamIxcw0pBmFR
         VuRv3t57d/u5+68Ftr4A3sbfFuaC31GE7MqxdNy8Y3BmqpLf+wrk92myewdy7WKR2A
         xpDzvwBk1Vp2XyQ1FS0Yi5zs4VQ1aGrQovdL0ga4ffp0az5tPsGHzB/qRLAn4rNVNC
         ll8GisAM4s8NFnhlRQHsKegqWZY/dUJj8HccK3KxTO1IWxT5stVNnmQVm+Wz7M06DP
         R/iMJ8hA9E2pPBlUyFip11luDwcD3ONLZVEdXJke7f21vZYhvEBL/snUAr05exFl82
         rhntEjOmI96nA==
Received: by mail-lj1-f170.google.com with SMTP id b18so20923298ljr.13;
        Wed, 19 Oct 2022 00:01:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf10zmaCBsIcYH3GOVq3V+sCeSmqdZIyFkBvHXRI2bzV5x2xfoUT
        6/dwr8+Q+5XfYVVCvqb7V15WiBeMRoasXNWo8RI=
X-Google-Smtp-Source: AMsMyM506RGH9G3NdyMul3lvhmbWpeKvEwDgRV1WsboI8duToRQWQD7R0E3bo5pfnbDro1GvEkw5HysL/RLMJSCZ+5o=
X-Received: by 2002:a05:651c:4d0:b0:26f:cd9b:419f with SMTP id
 e16-20020a05651c04d000b0026fcd9b419fmr2225881lji.415.1666162897461; Wed, 19
 Oct 2022 00:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <27a078f43742063cc30e706b196fb5fff5d5c37e.1662459668.git.baskov@ispras.ru>
In-Reply-To: <27a078f43742063cc30e706b196fb5fff5d5c37e.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:01:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUvUwy__wD-DtHtpVMoCJsc=G2mvWLe2a7ib2ckqzpow@mail.gmail.com>
Message-ID: <CAMj1kXGUvUwy__wD-DtHtpVMoCJsc=G2mvWLe2a7ib2ckqzpow@mail.gmail.com>
Subject: Re: [PATCH 01/16] x86/boot: Align vmlinuz sections on page size
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> To protect sections on page table level each section
> needs to be aligned on page size (4KB).
>
> Set sections alignment in linker script.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 112b2375d021..6be90f1a1198 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -27,21 +27,27 @@ SECTIONS
>                 HEAD_TEXT
>                 _ehead = . ;
>         }
> +       . = ALIGN(PAGE_SIZE);
>         .rodata..compressed : {
> +               _compressed = .;

Why are you adding these?

>                 *(.rodata..compressed)
> +               _ecompressed = .;
>         }
> +       . = ALIGN(PAGE_SIZE);

On other EFI architectures, we only distinguish between R-X and RW-
regions, and alignment between .rodata and .text is unnecessary. Do we
really need to deviate from that here?


>         .text : {
>                 _text = .;      /* Text */
>                 *(.text)
>                 *(.text.*)
>                 _etext = . ;
>         }
> +       . = ALIGN(PAGE_SIZE);
>         .rodata : {
>                 _rodata = . ;
>                 *(.rodata)       /* read-only data */
>                 *(.rodata.*)
>                 _erodata = . ;
>         }
> +       . = ALIGN(PAGE_SIZE);
>         .data : {
>                 _data = . ;
>                 *(.data)
> --
> 2.35.1
>
