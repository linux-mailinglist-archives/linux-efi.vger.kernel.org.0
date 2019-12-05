Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1F113FBF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfLEK4B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 05:56:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728735AbfLEK4B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 05:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575543359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcSvDAAQF2KhEEObz4gP9gUoPID8X22sgxJqtYom4vk=;
        b=dHIxLFOpBSaGAJ2NjmbrnSpu6bHEaAut6OiTOEnGrnGH9QZYqBcX19oRdVr2I/A+xWcoDc
        dlG3UV1JD1isgYsEeumv0oYR+RfrP1LSbI0mMFqE7Lkdbczxv8vohG6FfNZnUFE3C4qYly
        URdMXn7/l+AygeMyeWfjjoson7OQa4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-3ho80iwfOzeRYyNYyHkmRA-1; Thu, 05 Dec 2019 05:55:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 357A2800D41;
        Thu,  5 Dec 2019 10:55:54 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 813305D9C5;
        Thu,  5 Dec 2019 10:55:49 +0000 (UTC)
Date:   Thu, 5 Dec 2019 18:55:45 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
Message-ID: <20191205105545.GA6710@dhcp-128-65.nay.redhat.com>
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <20191204075917.GA10587@dhcp-128-65.nay.redhat.com>
 <20191204101412.GD114697@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191204101412.GD114697@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3ho80iwfOzeRYyNYyHkmRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/04/19 at 11:14am, Ingo Molnar wrote:
>=20
> * Dave Young <dyoung@redhat.com> wrote:
>=20
> > On 12/04/19 at 03:52pm, Dave Young wrote:
> > > Michael Weiser reported he got below error during a kexec rebooting:
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >=20
> > > The ESRT memory stays in EFI boot services data, and it was reserved
> > > in kernel via efi_mem_reserve().  The initial purpose of the reservat=
ion
> > > is to reuse the EFI boot services data across kexec reboot. For examp=
le
> > > the BGRT image data and some ESRT memory like Michael reported.=20
> > >=20
> > > But although the memory is reserved it is not updated in X86 e820 tab=
le.
> > > And kexec_file_load iterate system ram in io resource list to find pl=
aces
> > > for kernel, initramfs and other stuff. In Michael's case the kexec lo=
aded
> > > initramfs overwritten the ESRT memory and then the failure happened.
> >=20
> > s/overwritten/overwrote :)  If need a repost please let me know..
> >=20
> > >=20
> > > Since kexec_file_load depends on the e820 to be updated, just fix thi=
s
> > > by updating the reserved EFI boot services memory as reserved type in=
 e820.
> > >=20
> > > Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute a=
re
> > > bypassed in the reservation code path because they are assumed as res=
erved.
> > > But the reservation is still needed for multiple kexec reboot.
> > > And it is the only possible case we come here thus just drop the code
> > > chunk then everything works without side effects.=20
> > >=20
> > > On my machine the ESRT memory sits in an EFI runtime data range, it d=
oes
> > > not trigger the problem, but I successfully tested with BGRT instead.
> > > both kexec_load and kexec_file_load work and kdump works as well.
> > >=20
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
>=20
>=20
> So I edited this to:
>=20
>  From: Dave Young <dyoung@redhat.com>
>=20
>  Michael Weiser reported he got this error during a kexec rebooting:
>=20
>    esrt: Unsupported ESRT version 2904149718861218184.
>=20
>  The ESRT memory stays in EFI boot services data, and it was reserved
>  in kernel via efi_mem_reserve().  The initial purpose of the reservation
>  is to reuse the EFI boot services data across kexec reboot. For example
>  the BGRT image data and some ESRT memory like Michael reported.
>=20
>  But although the memory is reserved it is not updated in the X86 E820 ta=
ble,
>  and kexec_file_load() iterates system RAM in the IO resource list to fin=
d places
>  for kernel, initramfs and other stuff. In Michael's case the kexec loade=
d
>  initramfs overwrote the ESRT memory and then the failure happened.
>=20
>  Since kexec_file_load() depends on the E820 table being updated, just fi=
x this
>  by updating the reserved EFI boot services memory as reserved type in E8=
20.
>=20
>  Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
>  bypassed in the reservation code path because they are assumed as reserv=
ed.
>=20
>  But the reservation is still needed for multiple kexec reboots,
>  and it is the only possible case we come here thus just drop the code
>  chunk, then everything works without side effects.
>=20
>  On my machine the ESRT memory sits in an EFI runtime data range, it does
>  not trigger the problem, but I successfully tested with BGRT instead.
>  both kexec_load() and kexec_file_load() work and kdump works as well.
>=20

Thanks for the amending, also thank all for the review and test.

Dave

