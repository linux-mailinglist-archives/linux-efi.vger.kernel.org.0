Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E33E0608
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhHDQh1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:37:27 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36767 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhHDQh1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Aug 2021 12:37:27 -0400
Received: by mail-wr1-f48.google.com with SMTP id b13so2957315wrs.3;
        Wed, 04 Aug 2021 09:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pC7bibdDVPfsZA3a8PgeXYRmZOp++TNQJNDaoefINLI=;
        b=VnjQIIpXyrB36559cJ7xXvw53Hz9As+KSD1vfpxR7P7s8Xl2bZ3Q0z/Vhp6x5Rr6M0
         hdr40zempkd8HCBCHy5eev0TWZMmBgsqYp79MzWzU0JjfhV/aHhkJNuS30c29skz9mdu
         ELzi77L2Yn32fMM5xmAAXS2fnqi6dcEhsMZRRdcxSgPhDMkUdHVn6NbNrhQ8wsgPCbEw
         wGi/tPl0sLsREFYC3Smue5zqz7Sh3tNYyp4UlyF11g0Fih6nBl2ZKEXJKEyePsH3tCrx
         mjoZGaPy2PYteQMzORH/Tp53BbB3abGSNfoM77CXO/V583OPqTka6AGZHFyvRz293RhN
         PeHg==
X-Gm-Message-State: AOAM532981mbjhVEYd3weykepZ6xuBVDCjY/eLWgQdgRff1ycTpxDnBD
        bX8JjezTUfy5smz5CVs3Jnk=
X-Google-Smtp-Source: ABdhPJwVdpP0+AGfnKTfw1KDUmM7zLy9gvSYD6gbCcZvRinE6pdU+9uBwN7GL5/jZV/QCDRKh0pXuw==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr253473wrl.61.1628095032373;
        Wed, 04 Aug 2021 09:37:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h12sm2984204wrm.62.2021.08.04.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 09:37:11 -0700 (PDT)
Date:   Wed, 4 Aug 2021 16:37:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michael Kelley <mikelley@microsoft.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, ardb@kernel.org
Subject: Re: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210804163709.afu53w5sk35k23m7@liuwe-devbox-debian-v2>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <20210804162555.GD4857@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804162555.GD4857@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 05:25:57PM +0100, Catalin Marinas wrote:
> On Wed, Aug 04, 2021 at 08:52:34AM -0700, Michael Kelley wrote:
> > This series enables Linux guests running on Hyper-V on ARM64
> > hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> > Hyper-V and its hypercall mechanism.  Existing architecture
> > independent drivers for Hyper-V's VMbus and synthetic devices just
> > work when built for ARM64. Hyper-V code is built and included in
> > the image and modules only if CONFIG_HYPERV is enabled.
> [...]
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
> 
> Is it possible to rebase this on top of -rc3? Are there any
> dependencies or do you plan to upstream this via a different tree?

Some prerequisite patches are in hyperv-next.

https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Wei.
