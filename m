Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87B05BE274
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiITJyc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiITJya (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 05:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A61D9D;
        Tue, 20 Sep 2022 02:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1FD6287A;
        Tue, 20 Sep 2022 09:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7684BC433C1;
        Tue, 20 Sep 2022 09:54:24 +0000 (UTC)
Date:   Tue, 20 Sep 2022 10:54:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 3/8] efi/libstub: use EFI provided memcpy/memset
 routines
Message-ID: <YymNzUoGGOKu1e1d@arm.com>
References: <20220910081152.2238369-1-ardb@kernel.org>
 <20220910081152.2238369-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910081152.2238369-4-ardb@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Sep 10, 2022 at 10:11:47AM +0200, Ard Biesheuvel wrote:
> The stub is used in different execution environments, but on arm64,
> RISC-V and LoongArch, we still use the core kernel's implementation of
> memcpy and memset, as they are just a branch instruction away, and can
> generally be reused even from code such as the EFI stub that runs in a
> completely different address space.
> 
> KAsan complicates this slightly, resulting in the need for some hacks to
> expose the uninstrumented, __ prefixed versions as the normal ones, as
> the latter are instrumented to include the KAsan checks, which only work
> in the core kernel.
> 
> Unfortunately, #define'ing memcpy to __memcpy when building C code does
> not guarantee that no explicit memcpy() calls will be emitted. And with
> the upcoming zboot support, which consists of a separate binary which
> therefore needs its own implementation of memcpy/memset anyway, it's
> better to provide one explicitly instead of linking to the existing one.
> 
> Given that EFI exposes implementations of memmove() and memset() via the
> boot services table, let's wire those up in the appropriate way, and
> drop the references to the core kernel ones.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/image-vars.h            | 13 ---------

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
