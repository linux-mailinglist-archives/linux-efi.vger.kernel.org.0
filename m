Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9F3A4CE3
	for <lists+linux-efi@lfdr.de>; Sat, 12 Jun 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFLEnI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Jun 2021 00:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhFLEnI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Jun 2021 00:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623472868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BhtisDRssXQT2it4jQW/bgYjuS/QsE3H+8BKWcr+zPM=;
        b=IuG67rIBmJ6Smol1eVUyuKfbxGr4uPWHWSityOBw0myhevhYafcILUAVGTdRxg2L4FoqeW
        YgpFCSGZcpRc53KDKAF8006s3oDqBNM0r3aZjr/aRdCmSPC21QShk/xLY5Y+M/PKyGZXwe
        0aM+ehSG5KzI7YqfcEKl06qV4R+21WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-2k_2Xow2PWGwwTFLf8unag-1; Sat, 12 Jun 2021 00:41:07 -0400
X-MC-Unique: 2k_2Xow2PWGwwTFLf8unag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04C7C1850600;
        Sat, 12 Jun 2021 04:41:05 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6F7C60E3A;
        Sat, 12 Jun 2021 04:41:00 +0000 (UTC)
Date:   Sat, 12 Jun 2021 12:40:57 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Probably it is doable to have kexec on 32bit efi working
> without runtime service support, that means no need the trick of fixed
> mapping.
> 
> If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> patches for test.

Unfortunately I failed to setup a 32bit efi guest,  here are some
untested draft patches, please have a try.

========= kernel draft patch ==============

---
 arch/x86/boot/header.S         |    2 +-
 arch/x86/platform/efi/efi.c    |    6 +++---
 arch/x86/platform/efi/quirks.c |    3 ---
 3 files changed, 4 insertions(+), 7 deletions(-)

--- linux-x86.orig/arch/x86/boot/header.S
+++ linux-x86/arch/x86/boot/header.S
@@ -416,7 +416,7 @@ xloadflags:
 # define XLF23 0
 #endif
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_EFI) && defined(CONFIG_KEXEC_CORE)
+#if defined(CONFIG_EFI) && defined(CONFIG_KEXEC_CORE)
 # define XLF4 XLF_EFI_KEXEC
 #else
 # define XLF4 0
--- linux-x86.orig/arch/x86/platform/efi/efi.c
+++ linux-x86/arch/x86/platform/efi/efi.c
@@ -710,10 +710,10 @@ static void __init kexec_enter_virtual_m
 	unsigned int num_pages;
 
 	/*
-	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI.
+	 * We don't do virtual mode, since we don't do runtime services
+	 * on non-native or IA32 EFI.
 	 */
-	if (efi_is_mixed()) {
+	if (!efi_enabled(EFI_64BIT)) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
--- linux-x86.orig/arch/x86/platform/efi/quirks.c
+++ linux-x86/arch/x86/platform/efi/quirks.c
@@ -524,9 +524,6 @@ int __init efi_reuse_config(u64 tables,
 	if (!efi_setup)
 		return 0;
 
-	if (!efi_enabled(EFI_64BIT))
-		return 0;
-
 	data = early_memremap(efi_setup, sizeof(*data));
 	if (!data) {
 		ret = -ENOMEM;


========= kexec-tools draft patch =========

---
 kexec/arch/i386/kexec-bzImage.c |    5 +++++
 1 file changed, 5 insertions(+)

--- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c
+++ kexec-tools/kexec/arch/i386/kexec-bzImage.c
@@ -83,6 +83,11 @@ int bzImage_probe(const char *buf, off_t
 	if (probe_debug) {
 		fprintf(stderr, "It's a bzImage\n");
 	}
+
+#define XLF_EFI_KEXEC   (1 << 4)
+	if ((header->xloadflags & XLF_EFI_KEXEC) == XLF_EFI_KEXEC)
+		bzImage_support_efi_boot = 1;
+
 	return 0;
 }
 

