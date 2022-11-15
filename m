Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C1629714
	for <lists+linux-efi@lfdr.de>; Tue, 15 Nov 2022 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiKOLRa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Nov 2022 06:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiKOLRN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Nov 2022 06:17:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730626484
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 03:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A1ACB81886
        for <linux-efi@vger.kernel.org>; Tue, 15 Nov 2022 11:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7367BC433D6;
        Tue, 15 Nov 2022 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668511025;
        bh=NMScK8aB29AuO1YZaSUj0lXpS/m6IsmLF61BjgXSc3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhbsDZNmofRhtzQqQuIrDDdZIbU+S4xV9vtonPajkieSh3x2eaWiqtxJo6x5u9xQX
         4oU+L4+wD+xJN9wLFt0a3oRw1+AC5Q5F/17pZM6r0zZkn3SKFQrHOkmN3Jv+7w9Ja7
         1yh03HpUTjBL3WkPOvAUAwOTd1sc2OUJhd+hHzEk2izvE/aR5kkLmrAP4z/xpldqgl
         Y8tofix5KHgr/xKccbVxVCB8IOxDWEYuT5h/u94rNkcApoM7EQNhtT9pJKMl4H5pTO
         BOpkcDmBEsTHFyItJ6XKeWZY9o0lCw+obDdu9SktldoxnIDJ5/xbaoR40nfuI05dyj
         zifekriLgEpbA==
Date:   Tue, 15 Nov 2022 11:17:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
Message-ID: <20221115111658.GA32523@willie-the-truck>
References: <20221108182204.2447664-1-ardb@kernel.org>
 <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26IE5NEVhyId4KH@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 11, 2022 at 05:36:19PM +0000, Mark Rutland wrote:
> On Tue, Nov 08, 2022 at 07:21:57PM +0100, Ard Biesheuvel wrote:
> > The purpose of this series is to remove any explicit cache maintenance
> > for coherency during early boot that becomes unnecessary if we simply
> > retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
> > and use it to populate the ID map page tables. After setting up this
> > preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> > TCR and SCTLR registers as before, and proceed as usual, avoiding the
> > need for any manipulations of memory while the MMU and caches are off.
> > 
> > The only properties of the firmware provided 1:1 map we rely on is that
> > it does not require any explicit cache maintenance for coherency, and
> > that it covers the entire memory footprint of the image, including the
> > BSS and padding at the end - all else is under control of the kernel
> > itself, as before.
> 
> As a high-level thing, I'm still very much not keen on entering the kernel with
> the MMU on. Given that we have to support booting with the MMU off for !EFI
> boot (including kexec when EFI is in use), I think this makes it harder to
> reason about the boot code overall (e.g. due to the conditional maintenance
> added to head.S), and adds more scope for error, even if it simplifies the EFI
> stub itself.

As discussed offline, two things that would help the current series are:

  (1) Some performance numbers comparing MMU off vs MMU on boot

  (2) Use of a separate entry point for the MMU on case, potentially failing
      the boot if the MMU is on and we're not using EFI

Will
