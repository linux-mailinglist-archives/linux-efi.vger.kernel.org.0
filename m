Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482487BF78B
	for <lists+linux-efi@lfdr.de>; Tue, 10 Oct 2023 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjJJJj0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Oct 2023 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjJJJjZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Oct 2023 05:39:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6A93;
        Tue, 10 Oct 2023 02:39:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC772C433C7;
        Tue, 10 Oct 2023 09:39:15 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:39:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 9/9] efi: move screen_info into efi init code
Message-ID: <ZSUbwXQCVmuehlKS@arm.com>
References: <20231009211845.3136536-1-arnd@kernel.org>
 <20231009211845.3136536-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009211845.3136536-10-arnd@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 09, 2023 at 11:18:45PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the vga console no longer relies on global screen_info, there are
> only two remaining use cases:
> 
>  - on the x86 architecture, it is used for multiple boot methods
>    (bzImage, EFI, Xen, kexec) to commucate the initial VGA or framebuffer
>    settings to a number of device drivers.
> 
>  - on other architectures, it is only used as part of the EFI stub,
>    and only for the three sysfb framebuffers (simpledrm, simplefb, efifb).
> 
> Remove the duplicate data structure definitions by moving it into the
> efi-init.c file that sets it up initially for the EFI case, leaving x86
> as an exception that retains its own definition for non-EFI boots.
> 
> The added #ifdefs here are optional, I added them to further limit the
> reach of screen_info to configurations that have at least one of the
> users enabled.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/kernel/setup.c                       |  4 ----
>  arch/arm64/kernel/efi.c                       |  4 ----
>  arch/arm64/kernel/image-vars.h                |  2 ++

It's more Ard's thing and he reviewed it already but if you need another
ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
