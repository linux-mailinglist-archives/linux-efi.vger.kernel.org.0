Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5719602AB6
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJRL5v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJRL5l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3845BCB8D
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 401A761536
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E4CC433D6;
        Tue, 18 Oct 2022 11:57:29 +0000 (UTC)
Date:   Tue, 18 Oct 2022 12:57:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/21] arm64: efi: Avoid dcache_clean_poc() altogether in
 efi_enter_kernel()
Message-ID: <Y06UpeYYYm9qSATn@arm.com>
References: <20221017171700.3736890-1-ardb@kernel.org>
 <20221017171700.3736890-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017171700.3736890-3-ardb@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 17, 2022 at 07:16:41PM +0200, Ard Biesheuvel wrote:
> To allow efi_enter_kernel() to be shared with the EFI zboot decompressor
> build, drop another reference to dcache_clean_poc() and replace it with
> a single DC CVAC instruction. To ensure that it covers the remainder of
> efi_enter_kernel() as intended, reorganize the code a bit so it fits in
> a 32-byte cacheline, and align it to 32 bytes. (Even though the
> architecture defines 16 as the minimum D-cache line size, even the
> chosen value of 32 is highly unlikely to ever be encountered on real
> hardware, and this works with any line size >= 32)

This should do.

> -0:
> +	adr	x4, 1f
> +	dc	civac, x4

s/civac/cvac/ ?

Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
