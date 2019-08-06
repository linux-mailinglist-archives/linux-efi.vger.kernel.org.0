Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E339829B7
	for <lists+linux-efi@lfdr.de>; Tue,  6 Aug 2019 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfHFClP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 22:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfHFClP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 5 Aug 2019 22:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20FB9C0546F1;
        Tue,  6 Aug 2019 02:41:15 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E9365C1D4;
        Tue,  6 Aug 2019 02:41:12 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:41:08 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190806024108.GA6956@dhcp-128-65.nay.redhat.com>
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 06 Aug 2019 02:41:15 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 08/05/19 at 06:55pm, Ard Biesheuvel wrote:
> On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung@redhat.com> wrote:
> >
> > kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> > just reset while calling efi_delete_dummy_variable();  Unfortunately
> > I don't know how to debug the firmware, it is also possible a potential
> > problem on real hardware as well although nobody reproduced it.
> >
> > The intention of efi_delete_dummy_variable is to trigger garbage collection
> > when entering virtual mode.  But SetVirtualAddressMap can only run once
> > for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> > a good place to clean dummy object.
> >
> 
> I would argue that this means it is not a good place to *create* the
> dummy variable, and if we don't create it, we don't have to delete it
> either.
> 
> > Drop efi_delete_dummy_variable so that kexec reboot can work.
> >
> 
> Creating it and not deleting it is bad, so please try and see if we
> can omit the creation on this code path instead.

I'm not sure in this case the var is created or not, the logic seems
tricky to me.  It seems to me it is intend to force delete a non-exist
var here.

Matthew, can you comment here about Ard's question?

> 
> 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/efi.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > --- linux-x86.orig/arch/x86/platform/efi/efi.c
> > +++ linux-x86/arch/x86/platform/efi/efi.c
> > @@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
> >
> >         if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
> >                 runtime_code_page_mkexec();
> > -
> > -       /* clean DUMMY object */
> > -       efi_delete_dummy_variable();
> >  #endif
> >  }
> >
