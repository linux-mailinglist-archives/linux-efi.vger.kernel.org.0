Return-Path: <linux-efi+bounces-2540-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA94A067AD
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F5D7A240A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C42204087;
	Wed,  8 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivld4VO5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C41547E0;
	Wed,  8 Jan 2025 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373622; cv=none; b=DKi0rtBmEholIzuoIpM2Gj1e3/FKTv4UR+Dl4+4jqnMsUdSU74v//9HYeUuPxszWQrUxVHpidSd6r0+NPwftnAPwByiuR1aLiwKCc5a45cR/8HKtXJn7o1EfCE1Rm1SuhRHaHrohYKYeCcxQVoAoYGAGAPvp01I4rEYYcWFFSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373622; c=relaxed/simple;
	bh=LoH8NxbpvfgZwhXxRdKPiRx+zCJ7f6IAgHwJscXkeBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0qddCioJWF490xf1SkwyYASR+JoToKAqxWqRjipgl4Ive56qhDZM1rIEsl33guV7fdw0rGc92U0YnXUtO6XYiLlRycfHkncxfmxpXbVebFpQ0Zw9a7CXsKHWA0ZR5FLEDOyO848hA5952wqkaVbqrlriL//FdfeOeTZk52qAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivld4VO5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so3904886d6.1;
        Wed, 08 Jan 2025 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373618; x=1736978418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HeT4ErdiiGPVV6JW5GrqxuTR4ROk2Xofm4urABtvZA8=;
        b=Ivld4VO5k9KTy1DgrkNg1CzeBoUmZVJqmU10lUfpIdmn+RibVxLVP6yxFJ+jpm03cX
         Mnr5Fm5kIko0zzl8DGVkNkH8x3QdOZVGSBY8rGWDdwlQaJgwq37nIO+Kn9qVjxVrbpxt
         fxEkxXwhBMla2kfWuCbu0XGR5kd4FxSeWLaGSzRHCNPwT2ZNM1joTJrga336owdMbpJx
         /+nSoY3dCN2t6rYV9rM8CuS61B4hqunMTLPa8xtr54Ivo//LHvMF+d2tQpVkRZu24XVN
         RsEGKTY5+hvTgHGVpF0p1AZbJmpa5NSP9GZGeKBgZXzYXU/71xXEAhU7v1jjooHT1ma6
         aPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373618; x=1736978418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeT4ErdiiGPVV6JW5GrqxuTR4ROk2Xofm4urABtvZA8=;
        b=I2MUwWglfG9VHYaARN30O3cnIwazDWZh7ZCwBys5aKVRom+cdswWklioAx58qUjfTo
         kCgkucgx+OKPh+DhLJj9QP0uu0s+4FyAjqbOt5O/bsyVS0/n5287aDwzYlUOvHGsq+P+
         mT2ZdalGBFq2cqQ+HvjUHJY2e8FmvJFc7ZmClmigaH0urvp+GOoT1LZmLh7cT7EahaFw
         4Gu8l23jz68PteF/iEtRn0DFluVjeU7ALCZjTlg7/ilZHFfl2FA96JeUl2Vojx4FZyW3
         fJ0e5LA2T1cOTEUIEK6LMf+WHkmjkxc9W9HJD0bxxAuR1lfBKYtJ8LyT73S2D1ZiRyOz
         vIIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+fNTgcYR2vCZ/mRlYVCdBt7ag996PF423JxS9cnAzFN67nIEOjwJxBEo47CxsdpXJ/Rgwgp7rDgxreyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IY0NpMFLjI/PgHRfMRczmiYO8Yqryhtz3vXJYBMkjlSBaO1l
	6r0ox2yKU9pUudIAGKGm9NS6rFw/nmwlJfrIViepbq+d/zrLqAKlEgice691
X-Gm-Gg: ASbGnct5GegNQ3kZyeVTvQ1vBPZgwnO1eagC/aJC0NWsyJDtj+1DPkX9aLpWjTShsfV
	/5VPKkbSWgVhDMp/i0CLSCc7b9S89qCF0bAvEtCuZ4IwlJ7XutlxWrpZguZhmdGx/++cPHhGFjc
	DSDRI7Y40RhZ3FlbzZ5n/LpEyBCSTi/kFqAObrceS8Je/BbAhJgZV5f2mxP+jvSJYAg+LRuqnuI
	Go7YAllU8qx3XUqA6eYhJPuVvJ+A3wHzJdgcma7fXyi92T8bucgCmI=
X-Google-Smtp-Source: AGHT+IF4hH60nxcnGXdqVmtHpLDsAQ0bc+xnqwT1KrZUp9d8EtouYvj31KMcJ5KbHMY1SOUkw+kr9g==
X-Received: by 2002:a05:6214:e8b:b0:6d8:81cd:a0ce with SMTP id 6a1803df08f44-6df9b327016mr89269066d6.43.1736373617535;
        Wed, 08 Jan 2025 14:00:17 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1813858csm194311126d6.70.2025.01.08.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:16 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	hannes@cmpxchg.org,
	dyoung@redhat.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	gourry@gourry.net,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 0/2] efi/memattr: Fix memory corruption and warning issues
Date: Wed,  8 Jan 2025 21:53:35 +0000
Message-ID: <20250108215957.3437660-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the patch with the warning in [1] was merged, a very significant
number of kexec boots are producing the warning in our (Meta) fleet.

I believe there are 2 problems, the warning itself might not be
triggered on the right condition, and memory attributes
table is getting corrupted.
An example of the warning when its not triggered correctly and
is fixed by patch 1:
efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 2, desc_size == 48, num_entries == 48)
An example of the warning when memory attributes table
is getting corrupted and might possibly be fixed by patch 2:
efi: memattr: [Firmware Bug]: Corrupted EFI Memory Attributes Table detected! (version == 1, desc_size == 2072184435, num_entries == 3248688968)
Its clear that the desc size and num_entries are wrong.

The logic behind patch 1 is explained in its commit message.

The memory corruption is looking very similar to the problem that was
fixed by 77d48d39e99170 ("efistub/tpm: Use ACPI reclaim memory for
event log to avoid corruption"), but this time with memattr table,
where it might not be preserved during kexec. I have
not been able to reproduce this in the test machine I have
over the past couple of days (hence marked as RFC) , but its
happening often in our prod.
When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where
efi_mem_attr_table is and overwrite it and relocate_kernel.

Having a fix in firmware can be difficult to get through.
The next ideal place would be in libstub. However, it looks like
InstallMemoryAttributesTable [2] is not available as a boot service
call option [3], [4], I tried to use install_configuration_table as
a substitute, but its not valid and corrupts the MemoryAttributesTable.
The prints I got from the below code in coverletter were:
EFI stub: ERROR: KKK tbl 5f19e018 tbl_>version=1, tbl->num_entries 48 tbl->desc_size 48
EFI stub: ERROR: KKK2 tbl 67184018 tbl_>version=2048, tbl->num_entries 0 tbl->desc_size 0
which shows the table got corrupted. This can bee seen in the kernel boot as well after
(with the version showing up as 2048).

As a last option for a fix, the patch marks that region as reserved in
e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
use it for kernel segments.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
[2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
[3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
[4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327


diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d33ccbc4a2c6..a1a956f2d963 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1143,6 +1143,7 @@ efi_enable_reset_attack_mitigation(void) { }
 #endif
 
 void efi_retrieve_eventlog(void);
+void efi_mem_attr_init(void);
 
 struct screen_info *alloc_screen_info(void);
 struct screen_info *__alloc_screen_info(void);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 4f1fa302234d..c5b60aea342e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -128,3 +128,35 @@ void efi_free(unsigned long size, unsigned long addr)
        nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
        efi_bs_call(free_pages, addr, nr_pages);
 }
+
+void efi_mem_attr_init(void)
+{
+       efi_guid_t linux_mem_attr_guid = EFI_MEMORY_ATTRIBUTES_TABLE_GUID;
+       efi_memory_attributes_table_t *tbl = NULL;
+       efi_status_t status;
+       unsigned long size;
+
+       tbl = get_efi_config_table(linux_mem_attr_guid);
+       efi_err("KKK tbl %lx tbl_>version=%d, tbl->num_entries %d tbl->desc_size %d\n", tbl, tbl->version, tbl->num_entries, tbl->desc_size);
+
+       size = tbl->num_entries * tbl->desc_size;
+       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+                            sizeof(*tbl) + size, (void **)&tbl);
+
+       if (status != EFI_SUCCESS) {
+               efi_err("Unable to allocate memory for event log\n");
+               return;
+       }
+
+       status = efi_bs_call(install_configuration_table,
+                            &linux_mem_attr_guid, tbl);
+
+       if (status != EFI_SUCCESS)
+               efi_err("Unable to install configuration table to update memory type\n");
+       efi_bs_call(free_pool, tbl);
+
+       /* verify if its the same table */
+       tbl = get_efi_config_table(linux_mem_attr_guid);
+       efi_err("KKK2 tbl %lx tbl_>version=%d, tbl->num_entries %d tbl->desc_size %d\n", tbl, tbl->version, tbl->num_entries, tbl->desc_size);
+
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..c0c3d278451d 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1036,6 +1036,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
        efi_retrieve_eventlog();
 
+       efi_mem_attr_init();
+
        setup_graphics(boot_params);
 
        setup_efi_pci(boot_params);
 
Usama Arif (2):
  efi/memattr: Use desc_size instead of total size to check for
    corruption
  efi/memattr: add efi_mem_attr_table as a reserved region in
    820_table_firmware

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/e820.c          |  6 ++++++
 arch/x86/platform/efi/efi.c     |  9 +++++++++
 drivers/firmware/efi/memattr.c  | 17 +++++++----------
 include/linux/efi.h             |  7 +++++++
 5 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.5


