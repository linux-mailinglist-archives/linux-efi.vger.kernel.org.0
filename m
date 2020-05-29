Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C471E84DB
	for <lists+linux-efi@lfdr.de>; Fri, 29 May 2020 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2RcY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 May 2020 13:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2RcY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 29 May 2020 13:32:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8022072D;
        Fri, 29 May 2020 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590773543;
        bh=1qy2XwZGp6bw0IMioTK3OHYDxNdjw6uX1yU4MFZqyEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqI/h7AsBu9I3eV7QBx+U2GmtaZbGtMR2lueZwwG2zrgxBaTzdr36ogU0oge2PwiG
         AqvStkVV/3iFsl5cOb989SGXYRVMllbsqzQZfKw7sY0zbTHC6AKaDNJSMj3iI1b9RD
         jMCuVD0DHQTc6TOPOPYoVeWqXxKsAoDby5dlqOsQ=
Date:   Fri, 29 May 2020 12:37:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] efi: Replace zero-length array and use struct_size()
 helper
Message-ID: <20200529173722.GB10051@embeddedor>
References: <20200527171425.GA4053@embeddedor>
 <202005290131.4B104937C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005290131.4B104937C@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 29, 2020 at 01:31:54AM -0700, Kees Cook wrote:
> On Wed, May 27, 2020 at 12:14:25PM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > Lastly, make use of the sizeof_field() helper instead of an open-coded
> > version.
> > 
> > This issue was found with the help of Coccinelle and audited _manually_.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks :)

Please, see more comments below...

> > ---
> >  drivers/firmware/efi/efi.c | 3 ++-
> >  include/linux/efi.h        | 7 ++-----
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 7f1657b6c30df..edc5d36caf54e 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
> >  			rsv = (void *)(p + prsv % PAGE_SIZE);
> >  
> >  			/* reserve the entry itself */
> > -			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
> > +			memblock_reserve(prsv,
> > +					 struct_size(rsv, entry, rsv->size));
> >  
> >  			for (i = 0; i < atomic_read(&rsv->count); i++) {
> >  				memblock_reserve(rsv->entry[i].base,
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index c45ac969ea4eb..328cc52a5fd45 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1234,14 +1234,11 @@ struct linux_efi_memreserve {
> >  	struct {
> >  		phys_addr_t	base;
> >  		phys_addr_t	size;
> > -	} entry[0];
> > +	} entry[];
> >  };
> >  
> > -#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
> > -	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> > -
> >  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> > -	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> > +	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
> 
> Whoa. This is kind of a "reverse struct_size()". I wonder if any other
> places in the kernel do a similar calculation?
> 

So far this is the only intance of this I've run into. 

What I've found is that there are many instances of the open-coded
version of sizeof_field() and offsetof(). I'm addressing them on the
way.

Thanks
--
Gustavo
