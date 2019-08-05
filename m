Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD181457
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHEIgA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 04:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEIgA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 5 Aug 2019 04:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44C19300BCE9;
        Mon,  5 Aug 2019 08:36:00 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-149.pek2.redhat.com [10.72.12.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8803E5C1A1;
        Mon,  5 Aug 2019 08:35:57 +0000 (UTC)
Date:   Mon, 5 Aug 2019 16:35:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthewgarrett@google.com, bhsharma@redhat.com
Subject: [PATCH] do not clean dummy variable in kexec path
Message-ID: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 05 Aug 2019 08:36:00 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

kexec reboot fails randomly in UEFI based kvm guest.  The firmware
just reset while calling efi_delete_dummy_variable();  Unfortunately
I don't know how to debug the firmware, it is also possible a potential
problem on real hardware as well although nobody reproduced it.

The intention of efi_delete_dummy_variable is to trigger garbage collection
when entering virtual mode.  But SetVirtualAddressMap can only run once
for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
a good place to clean dummy object.

Drop efi_delete_dummy_variable so that kexec reboot can work.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c |    3 ---
 1 file changed, 3 deletions(-)

--- linux-x86.orig/arch/x86/platform/efi/efi.c
+++ linux-x86/arch/x86/platform/efi/efi.c
@@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
 
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
-
-	/* clean DUMMY object */
-	efi_delete_dummy_variable();
 #endif
 }
 
