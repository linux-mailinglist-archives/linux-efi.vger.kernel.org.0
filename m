Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD24603A58
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJSHIf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJSHIc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:08:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9E75CD2;
        Wed, 19 Oct 2022 00:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5745AB82267;
        Wed, 19 Oct 2022 07:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05496C433B5;
        Wed, 19 Oct 2022 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666163309;
        bh=qnqYtRTEaT7BfLqpb871BWOJ4dTkR7Ct7nJSNxl+0wI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JDrygyiLVkGQ4sHp6T8YjofcTl/4KscKDiQznkabIqFSRQ0zaKCuLla9rmTes9HYh
         +3fktzFSujjLp3B+E+/QDyn9N9fwaf5P34olGCjUNji8cEoo4ccVHsATJ1RfJHt33C
         ZFKG+ug4RfVbOLJElz3ecrjUg2lsZqLx/cha5ZakUnZ9sQnCygYTShlQC79Ju2XwEm
         oTP9sxBDpSEB6nk35V3sv8QNgUIKoryyRXfWAhqAR96oyCIiDK7gKlI6Sbyvb8ZbZJ
         Lrw432wYWcq0g8lYnJRtFtQ79EUbL/sMOssuUowaa4e+deh+RNLQiQrPfQJFrZlY6P
         TjZ/af+H54o4w==
Received: by mail-lf1-f52.google.com with SMTP id g7so21502526lfv.5;
        Wed, 19 Oct 2022 00:08:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf0tuSpu3z7XNU8M3FgAorLAUljUCrc9dByGPO1FqhLNBVEXxcAv
        en1QHLLAn3ygAi//qC5kFJDPkZ4NLP3Ne314Vb0=
X-Google-Smtp-Source: AMsMyM4TgHgkrqxf6VHibb4rSlNYQ97UQSTc/g2ynnHpxA4YNITxShcgWNlfNsIymaKZ2UOqUPYpaJ4q2wZhfMLwM0M=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr2219342lfb.122.1666163307042; Wed, 19
 Oct 2022 00:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <e4dd6f83a49551d72682ad399dba8feeea955fb4.1662459668.git.baskov@ispras.ru>
In-Reply-To: <e4dd6f83a49551d72682ad399dba8feeea955fb4.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:08:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6wZ2UK7cPeym8M4WioCUABa5qAo48LyGKHNA=QZ8YCw@mail.gmail.com>
Message-ID: <CAMj1kXG6wZ2UK7cPeym8M4WioCUABa5qAo48LyGKHNA=QZ8YCw@mail.gmail.com>
Subject: Re: [PATCH 04/16] x86/boot: Increase boot page table size
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
> Previous calculations ignored pages implicitly mapped by ACPI code,

I'm not sure I understand what this means. Which ACPI code and which
pages does it map?

> so theoretical upper limit is higher than was set.
>
> Using 4KB pages is desirable for better memory protection granularity.
> Approximately twice as much memory is required for those.
>
> Increase initial page table size to 64 4KB page tables.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/include/asm/boot.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index 9191280d9ea3..024d972c248e 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -41,22 +41,24 @@
>  # define BOOT_STACK_SIZE       0x4000
>
>  # define BOOT_INIT_PGT_SIZE    (6*4096)
> -# ifdef CONFIG_RANDOMIZE_BASE
>  /*
>   * Assuming all cross the 512GB boundary:
>   * 1 page for level4
> - * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
> - * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
> - * Total is 19 pages.
> + * (3+3)*2 pages for param and cmd_line
> + * (2+2+S)*2 pages for kernel and randomized kernel, where S is total number
> + *     of sections of kernel. Explanation: 2+2 are upper level page tables.
> + *     We can have only S unaligned parts of section: 1 at the end of the kernel
> + *     and (S-1) at the section borders. The start address of the kernel is
> + *     aligned, so an extra page table. There are at most S=6 sections in
> + *     vmlinux ELF image.
> + * 3 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
> + * Total is 36 pages.
> + *
> + * Some pages are also required for UEFI memory map and
> + * ACPI table mappings, so we need to add extra space.
> + * FIXME: Figure out exact amount of pages.
>   */
> -#  ifdef CONFIG_X86_VERBOSE_BOOTUP
> -#   define BOOT_PGT_SIZE       (19*4096)
> -#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
> -#   define BOOT_PGT_SIZE       (17*4096)
> -#  endif
> -# else /* !CONFIG_RANDOMIZE_BASE */
> -#  define BOOT_PGT_SIZE                BOOT_INIT_PGT_SIZE
> -# endif
> +# define BOOT_PGT_SIZE         (64*4096)
>
>  #else /* !CONFIG_X86_64 */
>  # define BOOT_STACK_SIZE       0x1000
> --
> 2.35.1
>
