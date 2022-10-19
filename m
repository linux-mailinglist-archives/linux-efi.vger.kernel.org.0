Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCE603A45
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJSHE5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJSHEy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3555A27147;
        Wed, 19 Oct 2022 00:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E11661794;
        Wed, 19 Oct 2022 07:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02E9C43143;
        Wed, 19 Oct 2022 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163090;
        bh=0U2Czy9vqKtxoW5paHTP5l5F49nCScDC5BExyiYKGVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OU/VJRNbB3cce5xH+/AKFdwFR5bV29T45n9ZMuSIQW17vk7kHzzgT/EVPYfWtqWuQ
         o82/0OAXqRr++t29HO8JwTBdeFo6kODhOvMnuYALkNN1rJTtEokmCvr7QZiGyhtxtj
         HmiSdl0WbD8Na3bya+DKwkx9tHgPvfwOPT0QAMDMMLT0alQZsOndYcAWyPIivXtxCt
         CAzIYOMyRMLUGSQKYEZCtu0Kb2L9PHXoF44wxWeL0sIVBZW4jRHJLPtZcCiWmr7LI8
         xHJLC3DxG+zSVuygonSoDXieASwZYSzV40Hs3Rp56OI7dy6TdSlqQMv8cKcFtxF++D
         CbyjJoPut3Vdw==
Received: by mail-lf1-f44.google.com with SMTP id d6so26554327lfs.10;
        Wed, 19 Oct 2022 00:04:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf3WaZ8h6wYHbxk0t3dmb4Y5QgvQOnio40mvq/0LW+M9TVIISE+D
        Qa7jgcWNezwX7SbW4fi9NHv2KTRH24C23crkA6M=
X-Google-Smtp-Source: AMsMyM7b+GH/AJf9YNAtWFU1qzZHNN3D9YTLCcQebHpkyRJp9obtrhBfyz282IOkymEPYXoexJcHDaulMbQcq7Wjzos=
X-Received: by 2002:a05:6512:c8:b0:4a4:5ef8:953b with SMTP id
 c8-20020a05651200c800b004a45ef8953bmr2376361lfp.539.1666163088610; Wed, 19
 Oct 2022 00:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <aac3ce7c5aa706269d468fbe16129ee383deac2e.1662459668.git.baskov@ispras.ru>
In-Reply-To: <aac3ce7c5aa706269d468fbe16129ee383deac2e.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:04:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFyZJD5FnjWDEZbpzZM=T-676Z4q7nzEQAxp=zBAFGktw@mail.gmail.com>
Message-ID: <CAMj1kXFyZJD5FnjWDEZbpzZM=T-676Z4q7nzEQAxp=zBAFGktw@mail.gmail.com>
Subject: Re: [PATCH 02/16] x86/build: Remove RWX sections and align on 4KB
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
> Avoid creating sections with maximal privileges to prepare for W^X

privileges

> implementation. Align sections on page size (4KB) to allow protecting
> them in page table.
>

in the page tables.

> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 15f29053cec4..6587e0201b50 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -102,12 +102,11 @@ jiffies = jiffies_64;
>  PHDRS {
>         text PT_LOAD FLAGS(5);          /* R_E */
>         data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>         percpu PT_LOAD FLAGS(6);        /* RW_ */
>  #endif
> -       init PT_LOAD FLAGS(7);          /* RWE */
> -#endif
> +       inittext PT_LOAD FLAGS(5);      /* R_E */
> +       init PT_LOAD FLAGS(6);          /* RW_ */

Please explain in the commit log how this change affects X86_32

>         note PT_NOTE FLAGS(0);          /* ___ */
>  }
>
> @@ -226,9 +225,10 @@ SECTIONS
>  #endif
>
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -       :init
> -#endif
> +       :inittext
> +
> +       . = ALIGN(PAGE_SIZE);
> +
>
>         /*
>          * Section for code used exclusively before alternatives are run. All
> @@ -240,6 +240,7 @@ SECTIONS
>         .altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
>                 *(.altinstr_aux)
>         }
> +       :init
>
>         INIT_DATA_SECTION(16)
>
> --
> 2.35.1
>
