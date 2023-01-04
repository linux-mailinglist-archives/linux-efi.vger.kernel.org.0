Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15565D758
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjADPiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 10:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjADPiT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 10:38:19 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2321DDF4;
        Wed,  4 Jan 2023 07:38:16 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pD5qA-0007gv-QA; Wed, 04 Jan 2023 16:38:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 4/6] riscv: Fix EFI stub usage of KASAN instrumented string functions
Date:   Wed, 04 Jan 2023 16:38:05 +0100
Message-ID: <10490920.nUPlyArG6x@diego>
In-Reply-To: <20221216162141.1701255-5-alexghiti@rivosinc.com>
References: <20221216162141.1701255-1-alexghiti@rivosinc.com> <20221216162141.1701255-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Freitag, 16. Dezember 2022, 17:21:39 CET schrieb Alexandre Ghiti:
> The EFI stub must not use any KASAN instrumented code as the kernel
> proper did not initialize the thread pointer and the mapping for the
> KASAN shadow region.
> 
> Avoid using generic string functions by copying stub dependencies from
> lib/string.c to drivers/firmware/efi/libstub/string.c as RISC-V does
> not implement architecture-specific versions of those functions.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I think a similar change already went into 6.2-rc1 [0],
though it seems to leave strcmp in place in image-vars.h



[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da8dd0c75b3f82eb366eb1745fb473ea92c8c087


