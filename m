Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2498E3E0619
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHDQoV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239441AbhHDQoP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 12:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CB260238;
        Wed,  4 Aug 2021 16:44:01 +0000 (UTC)
Date:   Wed, 4 Aug 2021 17:43:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210804164358.GE4857@arm.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <20210804162555.GD4857@arm.com>
 <MWHPR21MB159317B1D47ED60C73B47021D7F19@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159317B1D47ED60C73B47021D7F19@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 04:39:02PM +0000, Michael Kelley wrote:
> From: Catalin Marinas <catalin.marinas@arm.com> Sent: Wednesday, August 4, 2021 9:26 AM
> > 
> > On Wed, Aug 04, 2021 at 08:52:34AM -0700, Michael Kelley wrote:
> > > This series enables Linux guests running on Hyper-V on ARM64
> > > hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> > > Hyper-V and its hypercall mechanism.  Existing architecture
> > > independent drivers for Hyper-V's VMbus and synthetic devices just
> > > work when built for ARM64. Hyper-V code is built and included in
> > > the image and modules only if CONFIG_HYPERV is enabled.
> > [...]
> > > Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
> > > with 4K/16K/64K page size. Linux guests with this patch series
> > > work with all three supported ARM64 page sizes.
> > >
> > > The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
> > > x86/x64-specific code and is not being built for ARM64. Enabling
> > > Hyper-V vPCI devices on ARM64 is in progress via a separate set
> > > of patches.
> > >
> > > This patch set is based on the linux-next20210720 code tree.
> > 
> > Is it possible to rebase this on top of -rc3? Are there any
> > dependencies or do you plan to upstream this via a different tree?
> 
> There are dependencies on changes in the hyperv-next tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/)
> which is why you are getting the build errors.  The changes
> common-ized some code between the x86 side and previous
> versions of this patch set (and fixed the #include nmi.h problem). 
> So the code would most naturally go upstream through that tree.

In that case, for this series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I don't think there'd be conflicts with the arm64 changes but we can
spot them early in -next.

-- 
Catalin
