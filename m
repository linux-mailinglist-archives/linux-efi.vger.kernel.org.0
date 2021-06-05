Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCA939C6A9
	for <lists+linux-efi@lfdr.de>; Sat,  5 Jun 2021 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFEHxM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Jun 2021 03:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhFEHxL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Jun 2021 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622879483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AFxfbRh44tx3itGF+2reHu0Dp0ddlJOouXymhxZA6d8=;
        b=GYt53Obj6jmFG7mv9mvDmSAoW+EsmUQAKN1fWHPTWBGukhW00aNHxq1iG/KH9RzE+bXevO
        yocY9CYv7i3HZw7RF6wmlIIfqrcwwxdxXt1/W1sA76L66geJySaswt1UBqtaIrl6mfz7hw
        KLBSQwIoL75YHgXhCgX8uWf8gfnEmk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-fqSHjizUNGWV-HX4g9qZow-1; Sat, 05 Jun 2021 03:51:21 -0400
X-MC-Unique: fqSHjizUNGWV-HX4g9qZow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652ED801B12;
        Sat,  5 Jun 2021 07:51:20 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BCB71B5B7;
        Sat,  5 Jun 2021 07:51:16 +0000 (UTC)
Date:   Sat, 5 Jun 2021 15:51:05 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed
 kernel
Message-ID: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLdG91qspr19heDS@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,
On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> +Cc: Ard
> 
> On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > it has been done for ACPI RSDP.
> > > 
> > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > particular the default I2C host speed is choosen based on DMI system
> > > information and now gets it correct.
> > 
> > Still nothing happens for a while and problem still exists.
> > Can we do something about it, please?

Seems I totally missed this thread. Old emails lost.

The question Ard asked is to confirm if the firmware converted the
SMBIOS3 addr to a virtual address after exit boot service. I do not
remember some easy way to check it due to lost the context of the code.
But you can try to check it via dmesg|grep SMBIOS both in normal boot
and kexeced boot log.  And then compare if those addresses are
identical.

If the SMBIOS3 addr in kexec kernel is different then it should have
been modified by firmware. Then we need patch kernel and kexec-tools to
support it.

You can try below patch to see if it works:

apply a kexec-tools patch to kexec-tools if you do not use kexec -s
(kexec_file_load):
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -533,7 +533,8 @@ struct efi_setup_data {
 	uint64_t runtime;
 	uint64_t tables;
 	uint64_t smbios;
-	uint64_t reserved[8];
+	uint64_t smbios3;
+	uint64_t reserved[7];
 };
 
 struct setup_data {
@@ -580,6 +581,8 @@ static int get_efi_values(struct efi_set
 
 	ret = get_efi_value("/sys/firmware/efi/systab", "SMBIOS=0x",
 			    &esd->smbios);
+	ret |= get_efi_value("/sys/firmware/efi/systab", "SMBIOS3=0x",
+			    &esd->smbios3);
 	ret |= get_efi_value("/sys/firmware/efi/fw_vendor", "0x",
 			     &esd->fw_vendor);
 	ret |= get_efi_value("/sys/firmware/efi/runtime", "0x",

=============================================
Kernel patch:

--- linux-x86.orig/arch/x86/include/asm/efi.h
+++ linux-x86/arch/x86/include/asm/efi.h
@@ -167,7 +167,8 @@ struct efi_setup_data {
 	u64 __unused;
 	u64 tables;
 	u64 smbios;
-	u64 reserved[8];
+	u64 smbios3;
+	u64 reserved[7];
 };
 
 extern u64 efi_setup;
--- linux-x86.orig/arch/x86/kernel/kexec-bzimage64.c
+++ linux-x86/arch/x86/kernel/kexec-bzimage64.c
@@ -144,6 +144,7 @@ prepare_add_efi_setup_data(struct boot_p
 	esd->fw_vendor = efi_fw_vendor;
 	esd->tables = efi_config_table;
 	esd->smbios = efi.smbios;
+	esd->smbios3 = efi.smbios3;
 
 	sd->type = SETUP_EFI;
 	sd->len = sizeof(struct efi_setup_data);
--- linux-x86.orig/arch/x86/platform/efi/quirks.c
+++ linux-x86/arch/x86/platform/efi/quirks.c
@@ -497,8 +497,8 @@ void __init efi_free_boot_services(void)
  * their physical addresses therefore we pass them via setup_data and
  * correct those entries to their respective physical addresses here.
  *
- * Currently only handles smbios which is necessary for some firmware
- * implementation.
+ * Currently only handles smbios and smbios3 which is necessary for
+ * some firmware implementation.
  */
 int __init efi_reuse_config(u64 tables, int nr_tables)
 {
@@ -521,7 +521,7 @@ int __init efi_reuse_config(u64 tables,
 		goto out;
 	}
 
-	if (!data->smbios)
+	if (!data->smbios  && !data->smbios3)
 		goto out_memremap;
 
 	sz = sizeof(efi_config_table_64_t);
@@ -538,8 +538,10 @@ int __init efi_reuse_config(u64 tables,
 
 		guid = ((efi_config_table_64_t *)p)->guid;
 
-		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
+		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID) && data->smbios)
 			((efi_config_table_64_t *)p)->table = data->smbios;
+		else if (!efi_guidcmp(guid, SMBIOS3_TABLE_GUID) && data->smbios3)
+			((efi_config_table_64_t *)p)->table = data->smbios3;
 		p += sz;
 	}
 	early_memunmap(tablep, nr_tables * sz);


Thanks
Dave

