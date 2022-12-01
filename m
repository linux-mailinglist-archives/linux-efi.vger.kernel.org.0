Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7349463E61F
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 01:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLAAGr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 19:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiLAAEn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 19:04:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439495802
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 16:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC1161E6C
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 00:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF49C433D6;
        Thu,  1 Dec 2022 00:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669852932;
        bh=lFbpQju0LYAyA4JDJno4ubTWIcXTZRKwPLUuIF23GHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TRUuHyatpNvvg14Os7laEijCKTdhxazYDqmEZp4j2Ol4Zva+dLGutnqpc7c/UKeFj
         nqzasadYW67rWBfKdlm9GOzJN3YPy/d525nw9UZHsbecBQFGsDO5GrdHhB5yn8gjEM
         gTEyAfdpzOhYgjixn2L1DJf8vLcNR4fPuokQR9qTX6lgoaZ+4VVYj5Sw5BN/ErgM1h
         PLsjkMM916TT8e/chaNAO1UpcH9EV/ztc9Cod5GRn92WX+yLjaPf+fGUca/D0MbvYj
         WNebNy1RhgzprWDk/gLXmTnpH9mBnDZlLCgbtjW0X8JDavsuSb9/VBtWcFzSA8rRvH
         5R3vqIQsvLCtA==
Message-ID: <81679d42-7800-3f77-eac8-d7d942e3065f@kernel.org>
Date:   Thu, 1 Dec 2022 00:02:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/14] Zbb string optimizations and call support in
 alternatives
To:     Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, emil.renner.berthing@canonical.com,
        ardb@kernel.org, linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
References: <20221130225614.1594256-1-heiko@sntech.de>
Content-Language: en-US
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <20221130225614.1594256-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 30/11/2022 22:56, Heiko Stuebner wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The Zbb extension can be used to make string functions run a lot
> faster.
> 
> To allow There are essentially two problems to solve:
> - making it possible for str* functions to replace what they do
>   in a performant way
> 
>   This is done by inlining the core functions and then
>   using alternatives to call the actual variant.
> 
>   This of course will need a more intelligent selection mechanism
>   down the road when more variants may exist using different
>   available extensions.
> 
> - actually allowing calls in alternatives
>   Function calls use auipc + jalr to reach those 32bit relative
>   addresses but when they're compiled the offset will be wrong
>   as alternatives live in a different section. So when the patch
>   gets applied the address will point to the wrong location.
> 
>   So similar to arm64 the target addresses need to be updated.
> 
>   This is probably also helpful for other things needing more
>   complex code in alternatives.
> 
> 
> In my half-scientific test-case of running the functions in question
> on a 95 character string in a loop of 10000 iterations, the Zbb
> variants shave off around 2/3 of the original runtime.
> 
> 
> For v2 I got into some sort of cleanup spree for the general instruction
> parsing that already existed. A number of places do their own
> instruction parsing and I tried consolidating some of them.
> 
> Noteable, the kvm parts still do, but I had to stop somewhere :-)
> 
> The series is based on v6.1-rc7 right now.
> 
> changes since v2:
> - add patch fixing the c.jalr funct4 value
> - reword some commit messages
> - fix position of auipc addition patch (earlier)
> - fix compile errors from patch-reordering gone wrong
>   (worked at the end of v2, but compiling individual patches
>    caused issues) - patches are now tested individually
> - limit Zbb variants for GNU as for now
>   (LLVM support for .option arch is still under review)

Still no good on that front chief:
ld.lld: error: undefined symbol: __strlen_generic
>>> referenced by ctype.c
>>>               arch/riscv/purgatory/purgatory.ro:(strlcpy)
>>> referenced by ctype.c
>>>               arch/riscv/purgatory/purgatory.ro:(strlcat)
>>> referenced by ctype.c
>>>               arch/riscv/purgatory/purgatory.ro:(strlcat)
>>> referenced 3 more times
make[5]: *** [/stuff/linux/arch/riscv/purgatory/Makefile:85: arch/riscv/purgatory/purgatory.chk] Error 1
make[5]: Target 'arch/riscv/purgatory/' not remade because of errors.
make[4]: *** [/stuff/linux/scripts/Makefile.build:500: arch/riscv/purgatory] Error 2

allmodconfig, same toolchain as before.

> - prevent str-functions from getting optimized to builtin-variants
> 
> changes since v1:
> - a number of generalizations/cleanups for instruction parsing
> - use accessor function to access instructions (Emil)
> - actually patch the correct location when having more than one
>   instruction in an alternative block
> - string function cleanups (comments etc) (Conor)
> - move zbb extension above s* extensions in cpu.c lists
> 
> changes since rfc:
> - make Zbb code actually work
> - drop some unneeded patches
> - a lot of cleanups
> 
> Heiko Stuebner (14):
>   RISC-V: fix funct4 definition for c.jalr in parse_asm.h
>   RISC-V: add prefix to all constants/macros in parse_asm.h
>   RISC-V: detach funct-values from their offset
>   RISC-V: add ebreak instructions to definitions
>   RISC-V: add auipc elements to parse_asm header
>   RISC-V: Move riscv_insn_is_* macros into a common header
>   RISC-V: rename parse_asm.h to insn.h
>   RISC-V: kprobes: use central defined funct3 constants
>   RISC-V: add U-type imm parsing to insn.h header
>   RISC-V: add rd reg parsing to insn.h header
>   RISC-V: fix auipc-jalr addresses in patched alternatives
>   efi/riscv: libstub: mark when compiling libstub
>   RISC-V: add infrastructure to allow different str* implementations
>   RISC-V: add zbb support to string functions
> 
>  arch/riscv/Kconfig                       |  24 ++
>  arch/riscv/Makefile                      |   3 +
>  arch/riscv/include/asm/alternative.h     |   3 +
>  arch/riscv/include/asm/errata_list.h     |   3 +-
>  arch/riscv/include/asm/hwcap.h           |   1 +
>  arch/riscv/include/asm/insn.h            | 292 +++++++++++++++++++++++
>  arch/riscv/include/asm/parse_asm.h       | 219 -----------------
>  arch/riscv/include/asm/string.h          |  83 +++++++
>  arch/riscv/kernel/alternative.c          |  72 ++++++
>  arch/riscv/kernel/cpu.c                  |   1 +
>  arch/riscv/kernel/cpufeature.c           |  29 ++-
>  arch/riscv/kernel/image-vars.h           |   6 +-
>  arch/riscv/kernel/kgdb.c                 |  63 ++---
>  arch/riscv/kernel/probes/simulate-insn.c |  19 +-
>  arch/riscv/kernel/probes/simulate-insn.h |  26 +-
>  arch/riscv/lib/Makefile                  |   6 +
>  arch/riscv/lib/strcmp.S                  |  38 +++
>  arch/riscv/lib/strcmp_zbb.S              |  96 ++++++++
>  arch/riscv/lib/strlen.S                  |  29 +++
>  arch/riscv/lib/strlen_zbb.S              | 115 +++++++++
>  arch/riscv/lib/strncmp.S                 |  41 ++++
>  arch/riscv/lib/strncmp_zbb.S             | 112 +++++++++
>  drivers/firmware/efi/libstub/Makefile    |   2 +-
>  23 files changed, 982 insertions(+), 301 deletions(-)
>  create mode 100644 arch/riscv/include/asm/insn.h
>  delete mode 100644 arch/riscv/include/asm/parse_asm.h
>  create mode 100644 arch/riscv/lib/strcmp.S
>  create mode 100644 arch/riscv/lib/strcmp_zbb.S
>  create mode 100644 arch/riscv/lib/strlen.S
>  create mode 100644 arch/riscv/lib/strlen_zbb.S
>  create mode 100644 arch/riscv/lib/strncmp.S
>  create mode 100644 arch/riscv/lib/strncmp_zbb.S
> 
> --
> 2.35.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

