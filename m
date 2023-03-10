Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173DD6B48E8
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjCJPIB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjCJPHj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:07:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423212C431;
        Fri, 10 Mar 2023 07:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C79B61AB3;
        Fri, 10 Mar 2023 14:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802E9C433AC;
        Fri, 10 Mar 2023 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460389;
        bh=1jHWm1hHektupMVfGYAU7Ec/h6Xz3poeeAB0EdUGEqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uF2BrzmViQWwW1LEQLJXKxB0daFUAomEdstRS+b5em0SwNeqvzUCC33Io6LqCxVCR
         i1QYaSFF0beb+R0KGs9x2ve6HqvVm5JrdiIsR54eceHdfbDuC+GKoAicbstlOTLock
         Bs5uanFJ+vh4FLNRiUQXc/AF9e0+nF29h0yNAsSgC0UnJuO1nfvNXSzAwo70Rpoh76
         U63zqbe0iNTyFW99cL3xWIjuY8fezUvZNREd9HPOYjgY9nGJHSot64soNRk/A908zK
         5rSuPt9psIt7R28CcHPV0MF3q1jWwBZy5cXzTzDTFQ1FVN8BlAYYAQAfHTNxKofkzg
         vzVxWokhVu/oQ==
Received: by mail-lf1-f52.google.com with SMTP id k14so6944333lfj.7;
        Fri, 10 Mar 2023 06:59:49 -0800 (PST)
X-Gm-Message-State: AO0yUKXUxrOmnmOxGW4ImTt8/7HV/H80JGF/ANXhX8NTJpkD6e7f8UC7
        F5evpw3i05WQI4NBqJ09M+F1WPi+iXonJMJ6TS0=
X-Google-Smtp-Source: AK7set8UE9g4mnJY20spZnNYYYIZuw9ViDA1dtxYc+myhHvwFACvLnYstWrXuWWWcK6KO60dHRDelfdmwz0fTxtS5I8=
X-Received: by 2002:a19:7517:0:b0:4dd:805b:5b75 with SMTP id
 y23-20020a197517000000b004dd805b5b75mr8092903lfe.7.1678460387521; Fri, 10 Mar
 2023 06:59:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <cb62472011a0c4151276b6a05b83b60b1bf6f352.1671098103.git.baskov@ispras.ru>
In-Reply-To: <cb62472011a0c4151276b6a05b83b60b1bf6f352.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:59:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com>
Message-ID: <CAMj1kXHnQZ2EDg1F_whTPHajYvqox7Ss35aqUyJuC8RLyiuCxg@mail.gmail.com>
Subject: Re: [PATCH v4 17/26] x86/boot: Reduce size of the DOS stub
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

On Thu, 15 Dec 2022 at 13:40, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> This is required to fit more sections in PE section tables,
> since its size is restricted by zero page located at specific offset
> after the PE header.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

I'd prefer to rip this out altogether.

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9510f6f04f579b9a3f54ad762c75ab2d905e37d8

(and refer to the other thread in linux-efi@)

> ---
>  arch/x86/boot/header.S | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 9338c68e7413..9fec80bc504b 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -59,17 +59,16 @@ start2:
>         cld
>
>         movw    $bugger_off_msg, %si
> +       movw    $bugger_off_msg_size, %cx
>
>  msg_loop:
>         lodsb
> -       andb    %al, %al
> -       jz      bs_die
>         movb    $0xe, %ah
>         movw    $7, %bx
>         int     $0x10
> -       jmp     msg_loop
> +       decw    %cx
> +       jnz     msg_loop
>
> -bs_die:
>         # Allow the user to press a key, then reboot
>         xorw    %ax, %ax
>         int     $0x16
> @@ -90,10 +89,9 @@ bs_die:
>
>         .section ".bsdata", "a"
>  bugger_off_msg:
> -       .ascii  "Use a boot loader.\r\n"
> -       .ascii  "\n"
> -       .ascii  "Remove disk and press any key to reboot...\r\n"
> -       .byte   0
> +       .ascii  "Use a boot loader. "
> +       .ascii  "Press a key to reboot"
> +       .set    bugger_off_msg_size, . - bugger_off_msg
>
>  #ifdef CONFIG_EFI_STUB
>  pe_header:
> --
> 2.37.4
>
