Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C00112A70
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 12:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfLDLpm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 06:45:42 -0500
Received: from heinz.dinsnail.net ([81.169.187.250]:40280 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLpl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 06:45:41 -0500
Received: from heinz.dinsnail.net ([IPv6:0:0:0:0:0:0:0:1])
        by heinz.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB4BjCuD029792;
        Wed, 4 Dec 2019 12:45:12 +0100
Received: from eldalonde.UUCP (uucp@localhost)
        by heinz.dinsnail.net (8.15.2/8.15.2/Submit) with bsmtp id xB4BjCEg029791;
        Wed, 4 Dec 2019 12:45:12 +0100
Received: from eldalonde.weiser.dinsnail.net (localhost [IPv6:0:0:0:0:0:0:0:1])
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2) with ESMTP id xB4BVe65003589;
        Wed, 4 Dec 2019 12:31:40 +0100
Received: (from michael@localhost)
        by eldalonde.weiser.dinsnail.net (8.15.2/8.15.2/Submit) id xB4BVexW003588;
        Wed, 4 Dec 2019 12:31:40 +0100
Date:   Wed, 4 Dec 2019 12:31:40 +0100
From:   Michael Weiser <michael@weiser.dinsnail.net>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191204113140.GA3081@weiser.dinsnail.net>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-dinsnail-net-MailScanner-Information: Please contact the ISP for more information
X-dinsnail-net-MailScanner-ID: xB4BjCuD029792
X-dinsnail-net-MailScanner: Found to be clean
X-dinsnail-net-MailScanner-From: michael@weiser.dinsnail.net
X-Spam-Status: No
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Dave,

On Wed, Dec 04, 2019 at 03:59:17PM +0800, Dave Young wrote:
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/quirks.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> > +++ linux-x86/arch/x86/platform/efi/quirks.c
> > @@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
> >  		return;
> >  	}
> >  
> > -	/* No need to reserve regions that will never be freed. */
> > -	if (md.attribute & EFI_MEMORY_RUNTIME)
> > -		return;
> > -
> >  	size += addr % EFI_PAGE_SIZE;
> >  	size = round_up(size, EFI_PAGE_SIZE);
> >  	addr = round_down(addr, EFI_PAGE_SIZE);
> > @@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
> >  	early_memunmap(new, new_size);
> >  
> >  	efi_memmap_install(new_phys, num_entries);
> > +	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > +	e820__update_table(e820_table);
> >  }
> >  
> >  /*
> Michael, could you a one more test and provide a tested-by if it works
> for you?

Did three successful kexecs in sequence of mainline 5.4.0 plus the patch
(had problems getting recent -next to boot on my machine). ESRT region
stayed reserved and intact so that the "Invalid version" error message   
is gone.

Tested-by: Michael Weiser <michael.weiser@gmx.de>
--
Thanks!
Michael
