Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9623DDDAE
	for <lists+linux-efi@lfdr.de>; Mon,  2 Aug 2021 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhHBQ3L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Aug 2021 12:29:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHBQ3K (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Aug 2021 12:29:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C944511D4;
        Mon,  2 Aug 2021 09:29:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E7C3F66F;
        Mon,  2 Aug 2021 09:28:58 -0700 (PDT)
Date:   Mon, 2 Aug 2021 17:28:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, will@kernel.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, ardb@kernel.org
Subject: Re: [PATCH v11 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210802162856.GD59710@C02TD0UTHF1T.local>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <87k0l325vl.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0l325vl.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 02, 2021 at 05:01:02PM +0100, Marc Zyngier wrote:
> On Tue, 20 Jul 2021 15:56:58 +0100,
> Michael Kelley <mikelley@microsoft.com> wrote:
> > 
> > This series enables Linux guests running on Hyper-V on ARM64
> > hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> > Hyper-V and its hypercall mechanism.  Existing architecture
> > independent drivers for Hyper-V's VMbus and synthetic devices just
> > work when built for ARM64. Hyper-V code is built and included in
> > the image and modules only if CONFIG_HYPERV is enabled.
> > 
> > The five patches are organized as follows:
> > 
> > 1) Add definitions and functions for making Hyper-V hypercalls
> >    and getting/setting virtual processor registers provided by
> >    Hyper-V
> > 
> > 2) Add the function needed by the arch independent VMbus driver
> >    for reporting a panic to Hyper-V.
> > 
> > 3) Add Hyper-V initialization code and utility functions that
> >    report Hyper-v status.
> > 
> > 4) Export screen_info so it may be used by the Hyper-V frame buffer
> >    driver built as a module. It is already exported for x86,
> >    powerpc, and alpha architectures.
> > 
> > 5) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.
> > 
> > Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> > with 4K/16K/64K page size. Linux guests with this patch series
> > work with all three supported ARM64 page sizes.
> > 
> > The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> > x86/x64-specific code and is not being built for ARM64. Enabling
> > Hyper-V vPCI devices on ARM64 is in progress via a separate set
> > of patches.
> > 
> > This patch set is based on the linux-next20210720 code tree.
> > 
> > Changes in v11:
> > * Drop the previous Patch 1 as the fixes have already been
> >   separately accepted upstream.
> > * Drop the previous Patch 3 for enabling Hyper-V enlightened
> >   clocks/timers.  Hyper-V is now offering the full ARM64
> >   architectural Generic Timer in guest VMs, so the existing
> >   arch_arch_timer.c driver just works. [Mark Rutland, Marc
> >   Zyngier]
> 
> Thanks for doing this. Assuming you fix the issue I mentioned in my
> reply to patch #3. FWIW:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

I've tried to provide concrete options for those. With those fixed up
somehow:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
