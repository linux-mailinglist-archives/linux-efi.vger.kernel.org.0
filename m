Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0851BC25C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Apr 2020 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgD1PLa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Apr 2020 11:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgD1PLa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Apr 2020 11:11:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B6D205C9;
        Tue, 28 Apr 2020 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588086689;
        bh=aamxra8/L8gjllOiveVDPAUmrn8wwP+GQF0Iq8KS/QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpiRez2WIvdzuInq82Nf0S3PYv5YCwZqKrjdv4MQBiyq+3u9y8W2hoKAgxgVlFhJo
         AIk4vnsqN+dwq5AOhKZVvfs0Muvx8BvsscxPjCua0GhClnTEC2uAJc/BBnbKJIb7/L
         nv8pJ8p4peMND1YYHAKBL3M+9Mnl/X9mt028uGac=
Date:   Tue, 28 Apr 2020 16:11:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 5/8] efi/libstub/arm64: align PE/COFF sections to
 segment alignment
Message-ID: <20200428151123.GA12697@willie-the-truck>
References: <20200413155521.24698-1-ardb@kernel.org>
 <20200413155521.24698-6-ardb@kernel.org>
 <CAMj1kXFrzfKerYNL1c+iS33uMR++3w673kxg93bGfdG7ohWJsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFrzfKerYNL1c+iS33uMR++3w673kxg93bGfdG7ohWJsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 22, 2020 at 11:39:39AM +0200, Ard Biesheuvel wrote:
> On Mon, 13 Apr 2020 at 17:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The arm64 kernel's segment alignment is fixed at 64 KB for any page
> > size, and relocatable kernels are able to fix up any misalignment of
> > the kernel image with respect to the 2 MB section alignment that is
> > mandated by the arm64 boot protocol.
> >
> > Let's increase the PE/COFF section alignment to the same value, so that
> > kernels loaded by the UEFI PE/COFF loader are guaranteed to end up at
> > an address that doesn't require any reallocation to be done if the
> > kernel is relocatable.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/efi-header.S  | 2 +-
> >  arch/arm64/kernel/vmlinux.lds.S | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> 
> Catalin, Will: any thoughts whether this should go via the arm64 tree
> or the EFI tree? It is part of a change on the EFI side to stop
> needlessly copying the kernel around before boot, but this particular
> change could go through either tree, as it is not build time
> dependency for the EFI changes, nor does it have a boot time impact
> beyond making it more likely that the copy can be elided (but the code
> still needs to deal with the possibility that it cannot be elided in
> any case)

I've queued this one in the arm64 tree for 5.8. Should appear on
for-next/misc in the next day or so.

Thanks,

Will
