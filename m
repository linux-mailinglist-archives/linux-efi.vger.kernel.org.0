Return-Path: <linux-efi+bounces-1457-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AD934A8C
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D3286575
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jul 2024 08:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFE7EEF5;
	Thu, 18 Jul 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnSYcTZJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1B7A715
	for <linux-efi@vger.kernel.org>; Thu, 18 Jul 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293106; cv=none; b=Sukrq1Zg5fQQqjOscEJI5t794C7PphyfJdxCxNq5R/BHJFDqfsp7S6LiMi1OfFylXJy5EdQkZ/3N1UQWmF2qI/6134Kpn5IfWts8dtXtjeT0cMtkkC4fGQq6zk1PaT9Uf1irWV6H9TT7CqXycxEopJ/Fvl+7IvBB75W8oSrEmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293106; c=relaxed/simple;
	bh=pmbAI7WkhsbypM3B2OzT+jPbhKPAmmYuU8lgjqsoTqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akh3j3zia5o3//5G2pH+7eXFGCobOVqdgpkK6aiMKHV1jT5sYxLz+LM/5jjv1HzfeUOlVeiNwsvvaYMf2uru4KbcLSPoTlkalhOGOLAD7b1RqBiNtixYGRfG2drZ/fZgs7WANtqYQjdzd+2sdt1QGpSBFcl7jfXVbqbC2gpLGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnSYcTZJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721293104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cx+//M4mwT1/oyzWMG3NiAKSYFzIbWrxzN4Vn4DAQzM=;
	b=XnSYcTZJTdLr+sEMY8wNCLMrIasZHfwz+wagzwgs9NXA0VLxOTLLU8uivXk+IYsAOBk0dD
	VQugkgf2uDX202Tucz9QC6rNXq7w1T2B6nH8KpleqDRlvTqZeKS/a/z7HrVlSOhEtZK3g9
	HdCKhv0bso2pV0Bhe2mO9ivAJ1pcZTE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-S-tQwn_uOC21t6sHERRXcw-1; Thu,
 18 Jul 2024 04:58:20 -0400
X-MC-Unique: S-tQwn_uOC21t6sHERRXcw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C8551954128;
	Thu, 18 Jul 2024 08:58:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBB6F3000188;
	Thu, 18 Jul 2024 08:58:08 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC 0/7] UEFI emulator for kexec
Date: Thu, 18 Jul 2024 16:57:50 +0800
Message-ID: <20240718085759.13247-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


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

Currently, it only works on arm64 _zboot_ image on arm64 virt machine. For
arm64 UKI, I have not completed it. But it should be easy to archieve by
implementing EFI_LOAD_FILE2_PROTOCOL.LoadFile(). And with a slightly
improvement, it would work on x86. 

Besides that, as POC, I skip four functions in efistub: setup_graphics(),
efi_random_get_seed() and efi_enable_reset_attack_mitigation(),
efi_retrieve_eventlog(). Hence skipping the corresponding boot services.

Also, this series does not implement a memory allocator, which I plan to
implement with the help of bitmap.

About console, currently it hard code for arm64 virt machine, later it should
extract the information through ACPI table.

[1]: https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
[2]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/
[3]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985


Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org

Pingfan Liu (7):
  efi/libstub: Ask efi_random_alloc() to skip unusable memory
  debug/libstub: cheats to step around some boot service
  efi/emulator: Initial rountines to emulate EFI boot time service
  efi/emulator: Turn on mmu for arm64
  arm64: mm: Change to prototype of
  arm64: kexec: Prepare page table for emulator
  kexec: Introduce kexec_pe_image to parse and load PE file

 arch/arm64/include/asm/kexec.h                |   3 +
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/kexec_image.c               |   1 +
 arch/arm64/kernel/kexec_pe_image.c            | 519 ++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c             |  90 ++-
 arch/arm64/kernel/machine_kexec_file.c        |   1 +
 arch/arm64/mm/mmu.c                           |  67 ++-
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/efi_emulator/Makefile    |  98 ++++
 .../firmware/efi/efi_emulator/amba-pl011.c    |  80 +++
 .../efi_emulator/arm64_emulator_service.lds   |  45 ++
 .../firmware/efi/efi_emulator/arm64_proc.S    | 172 ++++++
 .../firmware/efi/efi_emulator/config_table.c  |  23 +
 drivers/firmware/efi/efi_emulator/core.c      | 211 +++++++
 drivers/firmware/efi/efi_emulator/earlycon.h  |  19 +
 .../firmware/efi/efi_emulator/efi_emulator.S  |  12 +
 drivers/firmware/efi/efi_emulator/emulator.h  |  66 +++
 drivers/firmware/efi/efi_emulator/entry.c     |  64 +++
 drivers/firmware/efi/efi_emulator/head.S      |  10 +
 drivers/firmware/efi/efi_emulator/initrd.c    |  15 +
 drivers/firmware/efi/efi_emulator/lib.c       |  73 +++
 drivers/firmware/efi/efi_emulator/memory.c    |  27 +
 .../firmware/efi/efi_emulator/memory_api.c    |  73 +++
 drivers/firmware/efi/efi_emulator/misc.c      |  76 +++
 drivers/firmware/efi/efi_emulator/pe_loader.c | 124 +++++
 drivers/firmware/efi/efi_emulator/printf.c    | 389 +++++++++++++
 .../efi/efi_emulator/runtime_service.c        |  28 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/random.c         |   2 +
 drivers/firmware/efi/libstub/randomalloc.c    |   5 +
 drivers/firmware/efi/libstub/tpm.c            |   4 +
 include/linux/efi_emulator.h                  |  46 ++
 include/linux/kexec.h                         |   5 +
 35 files changed, 2327 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/kernel/kexec_pe_image.c
 create mode 100644 drivers/firmware/efi/efi_emulator/Makefile
 create mode 100644 drivers/firmware/efi/efi_emulator/amba-pl011.c
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_emulator_service.lds
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_proc.S
 create mode 100644 drivers/firmware/efi/efi_emulator/config_table.c
 create mode 100644 drivers/firmware/efi/efi_emulator/core.c
 create mode 100644 drivers/firmware/efi/efi_emulator/earlycon.h
 create mode 100644 drivers/firmware/efi/efi_emulator/efi_emulator.S
 create mode 100644 drivers/firmware/efi/efi_emulator/emulator.h
 create mode 100644 drivers/firmware/efi/efi_emulator/entry.c
 create mode 100644 drivers/firmware/efi/efi_emulator/head.S
 create mode 100644 drivers/firmware/efi/efi_emulator/initrd.c
 create mode 100644 drivers/firmware/efi/efi_emulator/lib.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory.c
 create mode 100644 drivers/firmware/efi/efi_emulator/memory_api.c
 create mode 100644 drivers/firmware/efi/efi_emulator/misc.c
 create mode 100644 drivers/firmware/efi/efi_emulator/pe_loader.c
 create mode 100644 drivers/firmware/efi/efi_emulator/printf.c
 create mode 100644 drivers/firmware/efi/efi_emulator/runtime_service.c
 create mode 100644 include/linux/efi_emulator.h

-- 
2.41.0


