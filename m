Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC91A4724
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDJOCF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 10:02:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57172 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDJOCF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 10:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586527325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3QXqDUhhTTnEycU5mLu9/N4q4wfryLPSIfzA3mQPkI=;
        b=bk1ejNclVK1+B2D3v6oN/0qEvKRh2usFFWUhhp12EhzHKuua7+kRzo/0XVWeRgmUHdH3K5
        iRXXy/DCx34JARLjL2trdg1mhPYVy3t38mY543Mu/woJ8I1zQQ3aD6vzo4fOJQBRAUq4ro
        vwRKuC/cHOhvBI5t0qrdOgrUXsV/h2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-CLGH3it2MNysR5qEbGXYkQ-1; Fri, 10 Apr 2020 10:02:01 -0400
X-MC-Unique: CLGH3it2MNysR5qEbGXYkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8164D107ACC7;
        Fri, 10 Apr 2020 14:01:59 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D6B0CDBC8;
        Fri, 10 Apr 2020 14:01:56 +0000 (UTC)
Date:   Fri, 10 Apr 2020 22:01:51 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org, tytso@mit.edu,
        bp@alien8.de, mingo@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 04/10/20 at 09:56pm, Dave Young wrote:
> On 04/10/20 at 09:43am, Ard Biesheuvel wrote:
> > Commit
> > 
> >   0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")
> > 
> > removed the code that retrieves the non-remapped UEFI runtime services
> > pointer from the data structure provided by kexec, as it was never really
> > needed on the kexec boot path: mapping the runtime services table at its
> > non-remapped address is only needed when calling SetVirtualAddressMap(),
> > which never happens during a kexec boot in the first place.
> > 
> > However, dropping the 'runtime' member from struct efi_setup_data was a
> > mistake. That struct is shared ABI between the kernel and the kexec tooling
> > for x86, and so we cannot simply change its layout. So let's put back the
> > removed field, but call it 'unused' to reflect the fact that we never look
> > at its contents. While at it, add a comment to remind our future selves
> > that the layout is external ABI.
> > 
> > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > Tested-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > 
> > Ingo, Thomas, Boris: I sent out my efi-urgent pull request just yesterday,
> > so please take this directly into tip:efi/urgent - no need to wait for the
> > next batch.
> > 
> >  arch/x86/include/asm/efi.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 781170d36f50..96044c8d8600 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
> >  extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
> >  extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> >  
> > +/* kexec external ABI */
> >  struct efi_setup_data {
> >  	u64 fw_vendor;
> > +	u64 unused;
> >  	u64 tables;
> >  	u64 smbios;
> >  	u64 reserved[8];
> > -- 
> > 2.17.1
> > 
> 
> Ah, replied too quick in another mail.  I just cced kexec list again.
> 
> Thanks for the fix:
> 
> Reviewed-by: Dave Young <dyoung@redhat.com>
> 

BTW, a fixes tag is good to have.. 

