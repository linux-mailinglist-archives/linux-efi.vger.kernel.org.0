Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8874258D5A6
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiHIIrW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiHIIrO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:47:14 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F49A190
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:47:09 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 721604155D; Tue,  9 Aug 2022 09:47:07 +0100 (BST)
Date:   Tue, 9 Aug 2022 09:47:07 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v2 0/6] efi: implement generic compressed boot support
Message-ID: <20220809084707.GA3357@srcf.ucam.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 09, 2022 at 10:09:38AM +0200, Ard Biesheuvel wrote:

> The only slight downside is that when UEFI secure boot is enabled, the
> generic LoadImage/StartImage only allow signed images to be loaded and
> started, and we prefer to avoid the need to sign both the inner and
> outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
> override an internal UEFI/PI protocol that is used by the image loader,
> to allow the inner image to be booted after decompression. This has been
> tested to work with Tianocore based EFI implementations on arm64, but
> u-boot will need some interoperability tweaks as well, ideally just a
> protocol that exposes a LoadImage/StartImage combo that the decompresor
> can use directly to circumvent the signature check. (Note that EFI apps
> have full control over the CPU, page tables, etc. so having code that
> circumvents authentication checks is not as crazy as it sounds, given
> that the app can do anything it pleases already.)

I think it's worth mentioning that Shim doesn't do this by default 
because it's not guaranteed that something implementing the UEFI DXE 
layer also implements the PI layer. I don't have an objection to it 
being an expectation on any Linux-supporting platform that the 
implementation works this way, but it should maybe be made clear that 
this could unexpectedly fail on generic platforms.
