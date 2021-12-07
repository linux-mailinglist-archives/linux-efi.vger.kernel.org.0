Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0C46C42E
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhLGUKc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 15:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLGUKc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 15:10:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BB2C061574;
        Tue,  7 Dec 2021 12:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB770CE1DEF;
        Tue,  7 Dec 2021 20:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E5FC341C1;
        Tue,  7 Dec 2021 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638907617;
        bh=FSLhkQaVEX4dZ0fRYSqHC72laF/cCWIOhtt3ea/nX1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au5zEZNVNz/BP4lbQZPH5XikalbsunVV6IX4OhCHDMFothBnUy1rmTRqTHm+r+IPg
         QRWV13JsYuO0vQNPj0RfUfVkao09D+yaWpxvflgKMBSDyECeoeciBahAupV/FPO/8m
         B10yDlmIBFYfEd0p+QsiN+yXHj/aR+J6mVLk/zexbf711nPNUVLhL0kDCHYx4+V/89
         4X4Ub64KfxdCeoGvVOXCHBtVNlNFGU3nBTicPZsxnX4+inTHs6crndKhlIZQmxu+Zk
         3R2Y+757qc6m1CFB02LZARnMpVzhnX2hCbVHahS2f6awiQ7Oz4H68eNDluOjNALNie
         3Ym3IMN50txdg==
Date:   Tue, 7 Dec 2021 22:06:44 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <Ya++1FwWzKr2wYQH@kernel.org>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <YaxWXACBguZxWmKS@kernel.org>
 <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
 <Ya8MUOKPOKVfBfjJ@kernel.org>
 <CAKgze5Y6F40bk=PgoS3LshcDEAreefOmF4xpCuSxgpiSr+99Kw@mail.gmail.com>
 <1ed6020b-f84b-a29b-690a-9eee683c93a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed6020b-f84b-a29b-690a-9eee683c93a6@intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 07, 2021 at 11:52:54AM -0800, Dave Hansen wrote:
> On 12/7/21 11:45 AM, Martin Fernandez wrote:
> >> I wonder, for example, why did you choose per-node reporting rather than
> >> per-region as described in UEFI spec.
> > Some time ago we discussed about this and concluded with Dave Hansen
> > that it was better to do it in this per-node way.
> 
> Physical memory regions aren't exposed to userspace in any meaningful way.

Well, we have /sys/firmware/memory that exposes e820...
 
> An ABI that says "everything is encrypted" is pretty meaningless and
> only useful for this one, special case.
> 
> A per-node ABI is useful for this case and is also useful going forward
> if folks want to target allocations from applications to NUMA nodes
> which have encryption capabilities.  The ABI in this set is useful for
> the immediate case and is useful to other folks.

I don't mind per-node ABI, I'm just concerned that having a small region
without the encryption flag set will render the entire node "not
encryptable". This may happen because a bug in firmware, a user that shoot
themself in a leg with weird memmap= or some hidden gem in interaction
between e820, EFI and memblock that we still didn't discover.

I agree that per-node flag is useful, but maybe we should also have better
granularity as well.

-- 
Sincerely yours,
Mike.
