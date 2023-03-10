Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1166B49A1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjCJPOd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjCJPOL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:14:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D5763D2;
        Fri, 10 Mar 2023 07:05:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50C86B822F3;
        Fri, 10 Mar 2023 14:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA022C433AA;
        Fri, 10 Mar 2023 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459770;
        bh=2usUCEXzMy3dWey/bDPkNZ2hDlmy3ilAfwwyoTRfCgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dAhabvXIwYHV1UuvRjV9l0nTTvse8EZU11qwlYefmz+AWq0n1WzYBLXmrhOEcFiH5
         OQI5VatyEtIKjfyecxF9VOg40VhkVUVBE41Oapn8pV9ZxohFQPtImAFtQHxCRZ1UPz
         JZ31drRQ/2PEmygtUTNB4D1BNkdvT2oA3C+Zug571P6lfQO+SqfnOhREbVaZp++j6/
         nlqXa9k75so08TRhKrmagk0m57SrhUsFB8Y7LNHmtEDl4DzqMbZ2Rxvq92n9v4dmPO
         MLgp7avR8FJDFXxFDSipthXO6rBaZHdyculwzjFTjo720zUDNTCG6YF++fhDXvpvUQ
         rkpbZ3/DR7d7Q==
Received: by mail-lj1-f171.google.com with SMTP id z5so5534073ljc.8;
        Fri, 10 Mar 2023 06:49:29 -0800 (PST)
X-Gm-Message-State: AO0yUKVNjY+xNN09v6wOmWaPNRQmgDx5LzIrewnurYfOn8OxwMoX0z29
        s6jzmtGEcznrGSIPiLpCATcAOWdsCn4rtJjKR1M=
X-Google-Smtp-Source: AK7set/l4eR+hmEvLnp41KxXlyIdYAyB7mETDP/AT8qJNWVv6ZmRgtv4KaA6m45VJZQtn1Rr9nCf+Hl6w8Q8aoG1iec=
X-Received: by 2002:a2e:a912:0:b0:293:4ba5:f626 with SMTP id
 j18-20020a2ea912000000b002934ba5f626mr961387ljq.2.1678459768031; Fri, 10 Mar
 2023 06:49:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <dd39dfd18bcae4e5116597d4e9c186249aa15850.1671098103.git.baskov@ispras.ru>
In-Reply-To: <dd39dfd18bcae4e5116597d4e9c186249aa15850.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 15:49:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHA_Zmd2T6fCyUZ=MYt5-dTmk7a2wH9Dp2QvjFYYpCiQQ@mail.gmail.com>
Message-ID: <CAMj1kXHA_Zmd2T6fCyUZ=MYt5-dTmk7a2wH9Dp2QvjFYYpCiQQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/26] x86/boot: Remove mapping from page fault handler
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
> After every implicit mapping is removed, this code is no longer needed.
>
> Remove memory mapping from page fault handler to ensure that there are
> no hidden invalid memory accesses.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++---------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index fec795a4ce23..ba5108c58a4e 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -386,27 +386,21 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>  {
>         unsigned long address = native_read_cr2();
>         unsigned long end;
> -       bool ghcb_fault;
> +       char *msg;
>
> -       ghcb_fault = sev_es_check_ghcb_fault(address);
> +       if (sev_es_check_ghcb_fault(address))
> +               msg = "Page-fault on GHCB page:";
> +       else
> +               msg = "Unexpected page-fault:";
>
>         address   &= PMD_MASK;
>         end        = address + PMD_SIZE;
>
>         /*
> -        * Check for unexpected error codes. Unexpected are:
> -        *      - Faults on present pages
> -        *      - User faults
> -        *      - Reserved bits set
> -        */
> -       if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
> -               do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
> -       else if (ghcb_fault)
> -               do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
> -
> -       /*
> -        * Error code is sane - now identity map the 2M region around
> -        * the faulting address.
> +        * Since all memory allocations are made explicit
> +        * now, every page fault at this stage is an
> +        * error and the error handler is there only
> +        * for debug purposes.
>          */
> -       kernel_add_identity_map(address, end, MAP_WRITE);
> +       do_pf_error(msg, error_code, address, regs->ip);
>  }
> --
> 2.37.4
>
