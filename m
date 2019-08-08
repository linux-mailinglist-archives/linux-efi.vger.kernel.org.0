Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BABB85BFF
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2019 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfHHHtL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Aug 2019 03:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHHtL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Aug 2019 03:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4D0B30EA180;
        Thu,  8 Aug 2019 07:49:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 484B95D70D;
        Thu,  8 Aug 2019 07:49:08 +0000 (UTC)
Date:   Thu, 8 Aug 2019 15:49:04 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190808074904.GA5300@dhcp-128-65.nay.redhat.com>
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 08 Aug 2019 07:49:11 +0000 (UTC)
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
> 

Check the code for the dummy var, it is created only in below chunk:
arch/x86/platform/efi/quirks.c:
efi_query_variable_store():
[snip]
	/*
	 * We account for that by refusing the write if permitting it would
	 * reduce the available space to under 5KB. This figure was provided by
	 * Samsung, so should be safe.
	 */
	if ((remaining_size - size < EFI_MIN_RESERVE) &&
		!efi_no_storage_paranoia) {

		/*
		 * Triggering garbage collection may require that the firmware
		 * generate a real EFI_OUT_OF_RESOURCES error. We can force
		 * that by attempting to use more space than is available.
		 */
		unsigned long dummy_size = remaining_size + 1024;
		void *dummy = kzalloc(dummy_size, GFP_KERNEL);

		if (!dummy)
			return EFI_OUT_OF_RESOURCES;

		status = efi.set_variable((efi_char16_t *)efi_dummy_name,
					  &EFI_DUMMY_GUID,
					  EFI_VARIABLE_NON_VOLATILE |
					  EFI_VARIABLE_BOOTSERVICE_ACCESS |
					  EFI_VARIABLE_RUNTIME_ACCESS,
					  dummy_size, dummy);

		if (status == EFI_SUCCESS) {
			/*
			 * This should have failed, so if it didn't make sure
			 * that we delete it...
			 */
			efi_delete_dummy_variable();
		}

[snip]

So the dummy var only be created when the if condition matched, also
once creating succeeded it is deleted.  The deleting while entering
virtual mode is always deleting a non exist efi var.  Please correct me
if I miss something. 

If above is true, then at least in the kexec path can be dropped because
we have a real bug which resets machine.

Thanks
Dave
