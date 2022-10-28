Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476F6611B9C
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJ1Uf5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJ1Ufz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 16:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508FFEA9EF;
        Fri, 28 Oct 2022 13:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC58E62A51;
        Fri, 28 Oct 2022 20:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F01FC433D6;
        Fri, 28 Oct 2022 20:35:46 +0000 (UTC)
Date:   Fri, 28 Oct 2022 21:35:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.bennee@linaro.org, arnd@arndb.de
Subject: Re: [PATCH V2] arm64/mm: Fix __enable_mmu() for new TGRAN range
 values
Message-ID: <Y1w9Hqh4YZFUIp2z@arm.com>
References: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
 <20220826120020.GB520@mutt>
 <84e674ab-3eee-3f2b-28c1-a08ff99d6d3b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e674ab-3eee-3f2b-28c1-a08ff99d6d3b@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 28, 2022 at 10:18:41AM +0800, Zenghui Yu wrote:
> On 2022/8/26 20:00, Anders Roxell wrote:
> > On 2021-03-10 11:23, Anshuman Khandual wrote:
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
> > > might contain a range of values to describe supported translation granules
> > > (4K and 16K pages sizes in particular) instead of just enabled or disabled
> > > values. This changes __enable_mmu() function to handle complete acceptable
> > > range of values (depending on whether the field is signed or unsigned) now
> > > represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
> > > also fix similar situations in EFI stub and KVM as well.
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: kvmarm@lists.cs.columbia.edu
> > > Cc: linux-efi@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > 
> > When building an arm64 defconfig kernel from stable/linux-5.10.y and
> > booting that in QEMU (version: 1:7.0+dfsg-2~bpo11+2) with '-cpu max' the
> > kernel doesn't boot. I don't get any output.  The kernel boots fine if I
> > change to '-cpu cortex-a72'.
> > 
> > If I cherry-pick this patch to stable/linux-5.10.y I'm able too boot the
> > kernel with '-cpu max'.
> 
> You can workaround the kernel boot failure by specifying
> '-cpu max,lpa2=off' [*] in the QEMU command line.
> 
> > However, I'm not comfortable to backport this patch to older kernels
> > since there are a lot of conflicts.
> > Can someone help out to do the packport?
> 
> Upstream commit 26f55386f964 ("arm64/mm: Fix __enable_mmu() for new
> TGRAN range values") can still be applied cleanly on top of
> linux-5.10.y. I can send it to <stable@vger.kernel.org> if maintainers
> are okay with the stable-5.10 backport.

If you have a backport, please send it (and cc the original
author/reviewers just to double-check that the backport is correct).

Thanks.

-- 
Catalin
