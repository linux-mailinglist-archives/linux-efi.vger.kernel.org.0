Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF38C1123AF
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 08:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLDHws (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 02:52:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfLDHws (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 02:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575445967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CmZsBRvE51ACJrut6MCysLB+nDBJN/2JjOUocQctg1k=;
        b=eczMlvwVDgI6RUytY0wV3Lxrtb2IuOP0Pd4lr9fHlnunM9ACoh1ulQuDFk/yPrPWUScp+K
        vbqsu4vUzdQNQM9joGSQHJx5h16QVAt8vyA2mUE2rykQ6rjJw0ZlUQQppRfshEbX+jeoZq
        BHvS7KzVnL2wqDn6Zv1BScaix5P0PnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-M1dUFJOENXixzcIe7-m3FA-1; Wed, 04 Dec 2019 02:52:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01B2F107ACFE;
        Wed,  4 Dec 2019 07:52:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33D775DA60;
        Wed,  4 Dec 2019 07:52:36 +0000 (UTC)
Date:   Wed, 4 Dec 2019 15:52:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/efi: update e820 about reserved EFI boot services data
 to fix kexec breakage
Message-ID: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: M1dUFJOENXixzcIe7-m3FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Michael Weiser reported he got below error during a kexec rebooting:
esrt: Unsupported ESRT version 2904149718861218184.

The ESRT memory stays in EFI boot services data, and it was reserved
in kernel via efi_mem_reserve().  The initial purpose of the reservation
is to reuse the EFI boot services data across kexec reboot. For example
the BGRT image data and some ESRT memory like Michael reported.=20

But although the memory is reserved it is not updated in X86 e820 table.
And kexec_file_load iterate system ram in io resource list to find places
for kernel, initramfs and other stuff. In Michael's case the kexec loaded
initramfs overwritten the ESRT memory and then the failure happened.

Since kexec_file_load depends on the e820 to be updated, just fix this
by updating the reserved EFI boot services memory as reserved type in e820.

Originally any memory descriptors with EFI_MEMORY_RUNTIME attribute are
bypassed in the reservation code path because they are assumed as reserved.
But the reservation is still needed for multiple kexec reboot.
And it is the only possible case we come here thus just drop the code
chunk then everything works without side effects.=20

On my machine the ESRT memory sits in an EFI runtime data range, it does
not trigger the problem, but I successfully tested with BGRT instead.
both kexec_load and kexec_file_load work and kdump works as well.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/quirks.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-x86.orig/arch/x86/platform/efi/quirks.c
+++ linux-x86/arch/x86/platform/efi/quirks.c
@@ -260,10 +260,6 @@ void __init efi_arch_mem_reserve(phys_ad
 =09=09return;
 =09}
=20
-=09/* No need to reserve regions that will never be freed. */
-=09if (md.attribute & EFI_MEMORY_RUNTIME)
-=09=09return;
-
 =09size +=3D addr % EFI_PAGE_SIZE;
 =09size =3D round_up(size, EFI_PAGE_SIZE);
 =09addr =3D round_down(addr, EFI_PAGE_SIZE);
@@ -293,6 +289,8 @@ void __init efi_arch_mem_reserve(phys_ad
 =09early_memunmap(new, new_size);
=20
 =09efi_memmap_install(new_phys, num_entries);
+=09e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+=09e820__update_table(e820_table);
 }
=20
 /*

