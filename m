Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6EA6778F8
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjAWKTb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 05:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjAWKTa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 05:19:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93112E390;
        Mon, 23 Jan 2023 02:19:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A2860DFD;
        Mon, 23 Jan 2023 10:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F937C433A8;
        Mon, 23 Jan 2023 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674469168;
        bh=1MvSRUAOzKE+a90tCBvVLkylK82rha/QCQWLgVfCltk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qyAVZIfrSxljckr6paKaAvkrfUHIHj7wUv64VH5np6cFl5xqxvlm74q4EtrYtLq5X
         tcPCCWE4G+tWCLKTPJr/swWLBnyg7XSw3wiTsFkC1aAYcGVzos1mWRcGIpql9bmxj6
         VzxlEEWEhfTwVuYiV0QhRmHGNSrWKU3aljOEnv6uTiyVEqqfw0601zI01gOmiG1foe
         WPeVzTju4o47eweoEo4m5lIsmStAAIdWEu8YVyxUkReGKnN8rlmhdJDd3fvAtdzSM6
         P0V1jbhOOwJs55X7/rXm0KUnhiz7B5XHNryhT4+pE4SrA7GtehC1liznfu6Gvnylh6
         M0lMkEJwG4NFQ==
Received: by mail-lj1-f179.google.com with SMTP id y9so8867485lji.2;
        Mon, 23 Jan 2023 02:19:28 -0800 (PST)
X-Gm-Message-State: AFqh2kpTIF/vayA+9HpMAljA4vYyFZJDJcW+8CVAa3H3WDMU5yTW4R6N
        P/E+HinFHXTbPvHIMGezQclBSJEi45LoAsBrMrM=
X-Google-Smtp-Source: AMrXdXuV+YvUcgUKs//ofpl9C6bOG97YA1tziN0Q7mYtszCfszfBMOgqRuExMzsmqv+/3z7ce4+CPdP6WyOI6u0UXVg=
X-Received: by 2002:a2e:964e:0:b0:27f:b833:cf6d with SMTP id
 z14-20020a2e964e000000b0027fb833cf6dmr1969790ljh.291.1674469166406; Mon, 23
 Jan 2023 02:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20230123100951.810807-1-alexghiti@rivosinc.com> <20230123100951.810807-5-alexghiti@rivosinc.com>
In-Reply-To: <20230123100951.810807-5-alexghiti@rivosinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 23 Jan 2023 11:19:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEk0Vpf6-_iVwyg36MWtQa5HXGdExDzaFU5-12179shmw@mail.gmail.com>
Message-ID: <CAMj1kXEk0Vpf6-_iVwyg36MWtQa5HXGdExDzaFU5-12179shmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] riscv: Fix EFI stub usage of KASAN instrumented
 strcmp function
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        Alexandre Ghiti <alexghiti@alexghiti.eu.rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Jan 2023 at 11:14, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> From: Alexandre Ghiti <alexghiti@alexghiti.eu.rivosinc.com>
>
> The EFI stub must not use any KASAN instrumented code as the kernel
> proper did not initialize the thread pointer and the mapping for the
> KASAN shadow region.
>
> Avoid using the generic strcmp function, instead use the one in
> drivers/firmware/efi/libstub/string.c.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/riscv/kernel/image-vars.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index 7e2962ef73f9..15616155008c 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -23,8 +23,6 @@
>   * linked at. The routines below are all implemented in assembler in a
>   * position independent manner
>   */
> -__efistub_strcmp               = strcmp;
> -
>  __efistub__start               = _start;
>  __efistub__start_kernel                = _start_kernel;
>  __efistub__end                 = _end;
> --
> 2.37.2
>
