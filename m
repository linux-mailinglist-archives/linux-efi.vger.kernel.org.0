Return-Path: <linux-efi+bounces-1548-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27A956DE9
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BA51F22279
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA11741FD;
	Mon, 19 Aug 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS1u1G5B"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3D17335C
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079300; cv=none; b=pOVZk7rRmlfqhIYVzhzbpZzKxCro3m0ZCiyRVL20F7+hyAGGMr7v/QCRAP0ycNeCMjWJrzKgyV8mBJtNsKf8z9iAxqSO42Q6VGTRE+JdosvoCAy5m12NxMtmwPNX4TBJfelEkaOH6hj3Q0oSJp7XbBKkJwPx70dIgXqQX0Fa7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079300; c=relaxed/simple;
	bh=5gyzCA9IMKouWHURS+l0n18eMUg7Uks4WRKfTZXV630=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7ELgCOSPnpe8uLfir/FtrZrfUsGSzhYEUoxYbu0inH/4cn5MY4fWxNuhssOLR+PVkVv1Xis0uWjMPewBdLMSOtpDQ5AmIPhyDv3Occ3ddPVUmn5pgmWDb+sGQnSGA0wNqxf+jBWSer7UfO0oYY/q+hXZXPhSuh6A0/D5yi+ZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS1u1G5B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Izfgba6IG+m/4Kb14zgrGQLPZWHoqwnlWTdyhbi7My8=;
	b=IS1u1G5BxvFdcRrSPjM5boR42RQqOa0D32bTNvnn94ODWhLaKbj/N63c9+guK7c9JDwN24
	36cA9Vo3BnWs6PZenxGKyfH8hB2Juo9T+Ix8qW0VmGL2s5cY6qzVN7byEJg4s75RNKfwjs
	enSd6lb8F6ZS4QYQpFqKHIU9GU1xN+8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-NQTYQEy7Of6LQpzcKNkb2w-1; Mon,
 19 Aug 2024 10:54:51 -0400
X-MC-Unique: NQTYQEy7Of6LQpzcKNkb2w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 264631955BF7;
	Mon, 19 Aug 2024 14:54:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A61541955F44;
	Mon, 19 Aug 2024 14:54:39 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 0/9] UEFI emulator for kexec
Date: Mon, 19 Aug 2024 22:53:33 +0800
Message-ID: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

*** Background ***

As more PE format kernel images are introduced, it post challenge to kexec to
cope with the new format.

In my attempt to add support for arm64 zboot image in the kernel [1],
Ard suggested using an emulator to tackle this issue.  Last year, when
Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
emulator approach again [3]

After discussion, Ard's approach seems to be a more promising solution
to handle PE format kernels once and for all.  This series follows that
approach and implements an emulator to emulate EFI boot time services,
allowing the efistub kernel to self-extract and boot.

Another year has passed, and UKI kernel is more and more frequently used
in product. I think it is time to pay effort to resolve this issue.


*** Overview of implement ***
The whole model consits of three parts:

-1. The emulator
It is a self-relocatable PIC code, which is finally linked into kernel, but not
export any internal symbol to kernel.  It mainly contains: a PE file parser,
which loads PE format kernel, a group of functions to emulate efi boot service.

-2. inside kernel, PE-format loader
Its main task is to set up two extra kexec_segment, one for emulator, the other
for passing information from the first kernel to emulator.

-3. set up identity mapping only for the memory used by the emulator.
Here it relies on kimage_alloc_control_pages() to get pages, which will not
stamped during the process of kexec relocate (cp from src to dst). And since the
mapping only covers a small range of memory, it cost small amount memory.


*** To do ***

Currently, it only works on arm64 virt machine. For x86, it needs some slightly
changes. (I plan to do it in the next version)

Also, this series does not implement a memory allocator, which I plan to
implement with the help of bitmap.

About console, currently it hard code for arm64 virt machine, later it should
extract the information through ACPI table.

For kdump code, it is not implmented yet. But it should share the majority of
this series.


*** Test of this series ***
I have tested this series on arm64 virt machine. There I booted the vmlinuz.efi
and kexec_file_load a UKI image, then switch to the second kernel.

I used a modified kexec-tools [4], which just skips the check of the file format and passes the file directly to kernel.

[1]: https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
[2]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/
[3]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985
[4]: https://github.com/pfliu/kexec-tools.git branch: kexec_uefi_emulator


RFCv1 -> RFCv2:
-1.Support to run UKI kernel by: add LoadImage() and StartImage(), add
   PE file relocation support, add InstallMultiProtocol()
-2.Also set up idmap for EFI runtime memory descriptor since UKI's
   systemd-stub calls runtime service
-3.Move kexec_pe_image.c from arch/arm64/kernel to kernel/, since it
   aims to provide a more general architecture support.

RFCv1: https://lore.kernel.org/linux-efi/20240718085759.13247-1-piliu@redhat.com/
RFCv2: https://github.com/pfliu/linux.git  branch kexec_uefi_emulator_RFCv2

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: kexec@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org



Pingfan Liu (9):
  efi/libstub: Ask efi_random_alloc() to skip unusable memory
  efi/libstub: Complete efi_simple_text_output_protocol
  efi/emulator: Initial rountines to emulate EFI boot time service
  efi/emulator: Turn on mmu for arm64
  kexec: Introduce kexec_pe_image to parse and load PE file
  arm64: kexec: Introduce a new member param_mem to kimage_arch
  arm64: mm: Change to prototype of
  arm64: kexec: Prepare page table for emulator
  arm64: kexec: Enable kexec_pe_image

 arch/arm64/Kconfig                            |   4 +
 arch/arm64/include/asm/kexec.h                |   1 +
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/kernel/asm-offsets.c               |   2 +-
 arch/arm64/kernel/machine_kexec.c             | 103 +++-
 arch/arm64/kernel/machine_kexec_file.c        |   4 +
 arch/arm64/kernel/relocate_kernel.S           |   2 +-
 arch/arm64/mm/mmu.c                           |  67 ++-
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi_emulator/Makefile    |  99 ++++
 .../firmware/efi/efi_emulator/amba-pl011.c    |  81 +++
 .../efi_emulator/arm64_emulator_service.lds   |  45 ++
 .../firmware/efi/efi_emulator/arm64_proc.S    | 175 ++++++
 .../firmware/efi/efi_emulator/config_table.c  |  25 +
 drivers/firmware/efi/efi_emulator/core.c      | 376 +++++++++++++
 .../firmware/efi/efi_emulator/device_handle.c | 138 +++++
 drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
 .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
 drivers/firmware/efi/efi_emulator/emulator.h  | 106 ++++
 drivers/firmware/efi/efi_emulator/entry.c     |  68 +++
 drivers/firmware/efi/efi_emulator/head.S      |  10 +
 drivers/firmware/efi/efi_emulator/lib.c       |  73 +++
 drivers/firmware/efi/efi_emulator/memory.c    |  27 +
 .../firmware/efi/efi_emulator/memory_api.c    |  74 +++
 drivers/firmware/efi/efi_emulator/misc.c      |  43 ++
 drivers/firmware/efi/efi_emulator/pe_loader.c | 173 ++++++
 drivers/firmware/efi/efi_emulator/printf.c    | 373 +++++++++++++
 .../efi/efi_emulator/protocol_device_path.c   |  75 +++
 .../protocol_simple_text_output.c             |  50 ++
 drivers/firmware/efi/libstub/efistub.h        |   7 +
 drivers/firmware/efi/libstub/randomalloc.c    |   5 +
 include/linux/efi_emulator.h                  |  46 ++
 include/linux/kexec.h                         |   6 +
 kernel/Makefile                               |   1 +
 kernel/kexec_pe_image.c                       | 503 ++++++++++++++++++
 35 files changed, 2764 insertions(+), 36 deletions(-)
 create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
 create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_proc.S
 create mode 100644 drivers/firmware/efi/efi_emulator/config_table.c
 create mode 100644 drivers/firmware/efi/efi_emulator/core.c
 create mode 100644 drivers/firmware/efi/efi_emulator/device_handle.c
 create mode 100644 drivers/firmware/efi/efi_emulator/earlycon.h
 create mode 100644 drivers/firmware/efi/efi_emulator/efi_emulator.S
 create mode 100644 drivers/firmware/efi/efi_emulator/emulator.h
 create mode 100644 drivers/firmware/efi/efi_emulator/entry.c
 create mode 100644 drivers/firmware/efi/efi_emulator/head.S
 create mode 100644 drivers/firmware/efi/efi_emulator/lib.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory_api.c
 create mode 100644 drivers/firmware/efi/efi_emulator/misc.c
 create mode 100644 drivers/firmware/efi/efi_emulator/pe_loader.c
 create mode 100644 drivers/firmware/efi/efi_emulator/printf.c
 create mode 100644 drivers/firmware/efi/efi_emulator/protocol_device_path.c
 create mode 100644 drivers/firmware/efi/efi_emulator/protocol_simple_text_output.c
 create mode 100644 include/linux/efi_emulator.h
 create mode 100644 kernel/kexec_pe_image.c

-- 
2.41.0


