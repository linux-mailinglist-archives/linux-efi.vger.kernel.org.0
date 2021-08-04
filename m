Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764F43E05E2
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhHDQ0O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236825AbhHDQ0O (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 12:26:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF6BC60E78;
        Wed,  4 Aug 2021 16:25:59 +0000 (UTC)
Date:   Wed, 4 Aug 2021 17:25:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210804162555.GD4857@arm.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 08:52:34AM -0700, Michael Kelley wrote:
> This series enables Linux guests running on Hyper-V on ARM64
> hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> Hyper-V and its hypercall mechanism.  Existing architecture
> independent drivers for Hyper-V's VMbus and synthetic devices just
> work when built for ARM64. Hyper-V code is built and included in
> the image and modules only if CONFIG_HYPERV is enabled.
[...]
> Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> with 4K/16K/64K page size. Linux guests with this patch series
> work with all three supported ARM64 page sizes.
> 
> The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> x86/x64-specific code and is not being built for ARM64. Enabling
> Hyper-V vPCI devices on ARM64 is in progress via a separate set
> of patches.
> 
> This patch set is based on the linux-next20210720 code tree.

Is it possible to rebase this on top of -rc3? Are there any
dependencies or do you plan to upstream this via a different tree?

It applies cleanly but it doesn't build for me:

In file included from arch/arm64/include/asm/mshyperv.h:52,
                 from arch/arm64/hyperv/hv_core.c:19:
include/asm-generic/mshyperv.h: In function 'hv_do_rep_hypercall':
include/asm-generic/mshyperv.h:86:3: error: implicit declaration of function 'touch_nmi_watchdog' [-Werror=implicit-function-declaration]
   86 |   touch_nmi_watchdog();
      |   ^~~~~~~~~~~~~~~~~~

A quick fix for the above was to include nmi.h in mshyperv.h.

However, the below I can't fix since there's no trace of
hv_common_init() on top of 5.14-rc3:

arch/arm64/hyperv/mshyperv.c: In function 'hyperv_init':
arch/arm64/hyperv/mshyperv.c:66:8: error: implicit declaration of function 'hv_common_init' [-Werror=implicit-function-declaration]
   66 |  ret = hv_common_init();
      |        ^~~~~~~~~~~~~~
arch/arm64/hyperv/mshyperv.c:71:5: error: 'hv_common_cpu_init' undeclared (first use in this function)
   71 |     hv_common_cpu_init, hv_common_cpu_die);
      |     ^~~~~~~~~~~~~~~~~~
arch/arm64/hyperv/mshyperv.c:71:5: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/hyperv/mshyperv.c:71:25: error: 'hv_common_cpu_die' undeclared (first use in this function)
   71 |     hv_common_cpu_init, hv_common_cpu_die);
      |                         ^~~~~~~~~~~~~~~~~
arch/arm64/hyperv/mshyperv.c:73:3: error: implicit declaration of function 'hv_common_free' [-Werror=implicit-function-declaration]
   73 |   hv_common_free();
      |   ^~~~~~~~~~~~~~

-- 
Catalin
