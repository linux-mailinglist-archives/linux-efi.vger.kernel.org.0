Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5376B4690
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjCJOoI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 09:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjCJOnt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 09:43:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C564613DDA;
        Fri, 10 Mar 2023 06:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6408B6187C;
        Fri, 10 Mar 2023 14:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA258C433A1;
        Fri, 10 Mar 2023 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459427;
        bh=GqsR91YC3bbWtfipvQlRA7NKcZfVFD9t3q56gQEEmRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KMgvEEV7NIJ1P2+CpgUqR23wQmc/mPYCQTX+9ga25/VCW5WXHPJF6bKZHKkYPCHU3
         XBIlmmOzL3tCLGtjZjwGKSGd1tlKxvxmXCyfoe5lvGk8siwexgVayIvw1x1Mi1ghoM
         q3VqofA5RgTaLBpe++rwQgRnzYiSWTiyRYtcd5LBZKZnLc5ndF1AJqlNoLizqscdNV
         HKkW10jmwTPsY2VpxaC1ICzDi5tyC9OAlr3Tjjkv4s7FoAmzv0gBAwuZLT0OlBKRGo
         tfJZHivJKXaaNwTZ/AU6oczSShxIXKPwDPLT5JjFgGMl5aQpM5ZJsG3c+21j1zbB+l
         m01LpAYHK5WMA==
Received: by mail-lf1-f44.google.com with SMTP id t11so6907482lfr.1;
        Fri, 10 Mar 2023 06:43:47 -0800 (PST)
X-Gm-Message-State: AO0yUKUev3q3PKV4N75BY9afp/ktR5apTuFvfOdixIbp443h/NDv8/DJ
        JuPBW8WIUrxeWwkroV2tqZoZFj6Fee8Xcuqw+PU=
X-Google-Smtp-Source: AK7set+uUPqC+Nc+rUEfRT1ENZI+Cs4fQgKeR+wBglg54jCNNl7i7G36g0VIidxkJdPc0QiGQ3LHh9jjVi35CwG7h1k=
X-Received: by 2002:ac2:54b9:0:b0:4d8:62e5:4f66 with SMTP id
 w25-20020ac254b9000000b004d862e54f66mr8064335lfk.7.1678459425800; Fri, 10 Mar
 2023 06:43:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <8211c633eb5dceeabee2996a4db91cd971cf7c77.1671098103.git.baskov@ispras.ru>
In-Reply-To: <8211c633eb5dceeabee2996a4db91cd971cf7c77.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:43:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFPtA4f3kW1U2-LAQFEuOvLsis=Ursj40xRrg-cvtK=gA@mail.gmail.com>
Message-ID: <CAMj1kXFPtA4f3kW1U2-LAQFEuOvLsis=Ursj40xRrg-cvtK=gA@mail.gmail.com>
Subject: Re: [PATCH v4 01/26] x86/boot: Align vmlinuz sections on page size
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> To protect sections on page table level each section
> needs to be aligned on page size (4KB).
>
> Set sections alignment in linker script.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
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
>                 *(.rodata..compressed)

Can you just move this bit into the rodata section below?

> +               _ecompressed = .;
>         }
> +       . = ALIGN(PAGE_SIZE);
>         .text : {

Please use

.text : ALIGN(PAGE_SIZE) {

which marks the section as being page aligned, rather than just being
placed on a 4k boundary.

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
> 2.37.4
>
