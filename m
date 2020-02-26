Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8B1708C6
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 20:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBZTPA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 14:15:00 -0500
Received: from muru.com ([72.249.23.125]:57890 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgBZTPA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 14:15:00 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C71A88022;
        Wed, 26 Feb 2020 19:15:44 +0000 (UTC)
Date:   Wed, 26 Feb 2020 11:14:56 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/5] ARM: decompressor: use by-VA cache maintenance
 for v7 cores
Message-ID: <20200226191456.GZ37466@atomide.com>
References: <20200226165738.11201-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226165738.11201-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Ard Biesheuvel <ardb@kernel.org> [200226 16:58]:
> While making changes to the EFI stub startup code, I noticed that we are
> still doing set/way maintenance on the caches when booting on v7 cores.
> This works today on VMs by virtue of the fact that KVM traps set/way ops
> and cleans the whole address space by VA on behalf of the guest, and on
> most v7 hardware, the set/way ops are in fact sufficient when only one
> core is running, as there usually is no system cache. But on systems
> like SynQuacer, for which 32-bit firmware is available, the current cache
> maintenance only pushes the data out to the L3 system cache, where it
> is not visible to the CPU once it turns the MMU and caches off.
> 
> So instead, switch to the by-VA cache maintenance that the architecture
> requires for v7 and later (and ARM1176, as a side effect).
> 
> Changes since v3:
> - ensure that the region that is cleaned after self-relocation of the zImage
>   covers the appended DTB, if present

I gave these a try on top of the earlier "arm: fix Kbuild issue caused
by per-task stack protector GCC plugin" and booting still works for
me on armv7 including appended dtb:

Tested-by: Tony Lindgren <tony@atomide.com>
