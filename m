Return-Path: <linux-efi+bounces-1532-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FE947B56
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A630B21923
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4F15A874;
	Mon,  5 Aug 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDbTcCNy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26508158DD4;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862446; cv=none; b=F8Yrzx1uQHtEmVYpga0Pv0RoDpayW3979NCSe0T+FXlVLY3fgCJFlTGraNixt/LRzhirzzh9FIur+M9H6ijfQsxKaGoQ6H62sEglB5G87ERSavhprlFqj7HkTwWr8YnNS8hBGfbnNoA+rzfVqjrZwFaIKHJ+buywzYHSI+cf29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862446; c=relaxed/simple;
	bh=dhPdOqZ+898xPYzWbd1j5IL1OdyNFVd1v7509mSM+TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6rpvbaMwzZdDQv97FgxHRUmq9dUtPsPmDIMhyJ/Ga45Clzu0HLBnhJKHA08Vc1o9JcG3iax525UkPiBpUcpASb7X9BZwocU3GCFO7nxzaHL3c9178UUuEkt3RFTxC4rBofswdVCWHa/CUO6zWxUMsrMo3GDPNa8LTgLgcfPp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDbTcCNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36E0C4AF0D;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862445;
	bh=dhPdOqZ+898xPYzWbd1j5IL1OdyNFVd1v7509mSM+TI=;
	h=From:To:Cc:Subject:Date:From;
	b=JDbTcCNycT0kZSoUwobWeqVrd0fZIRJ+kKrq4eS03ay3gg+zyKCgOZEgnxN6hvzlN
	 859uvczYpYykY4wCuvFLIVDk5jXf0VmG8Tz0Wx33WE8kFC+JAm0V58rOhE1Szm5yy6
	 LIcyp0TUsvWHlQg11qe2qh9NczZ8T9JOi4E98Klj388Txo/ip0GW7C8uNrBvqNfxyK
	 VKFGxVeSjLUomZjeTUAM28RYfJTOjyUQ3bi7oVWeuimJImMTbI6zbVK1m/+KidXal2
	 /rl35r8a5vAf6V1m+kMF9dORvnMO3y5/KjDRs4BXGwxf8eJPR1lJxTtZ30VNwoNU+D
	 RS84UcvEu6+mQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1saxDv-0000000CyYd-3Rza;
	Mon, 05 Aug 2024 14:54:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <mchehab+huawei@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Len Brown <mchehab+huawei@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Fix issues with ARM Processor CPER records
Date: Mon,  5 Aug 2024 14:53:31 +0200
Message-ID: <cover.1722861911.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is needed for both kernelspace and userspace properly handle
ARM processor CPER events.

Patch 1 of this series fix the UEFI 2.6+ implementation of the ARM
trace event, as the original implementation was incomplete.
Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
added such event, but it reports only some fields of the CPER record
defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough
actually parse such events on userspace, as not even the event type
is exported.

Patch 2 fixes a compilation breakage when W=1;

Patch 3 adds a new helper function to be used by cper and ghes drivers to
display CPER bitmaps;

Patch 4 fixes CPER logic according with UEFI 2.9A errata. Before it, there
was no description about how processor type field was encoded. The errata
defines it as a bitmask, and provides the information about how it should
be encoded.

Patch 5 adds CPER functions to Kernel-doc.

This series was validated with the help of an ARM EINJ code for QEMU:
	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission_v5.1?ref_type=heads

	$ ./scripts/ghes_inject.py -d arm -m 2 4 -t tlb-error bus-error,micro-arch
	GUID: e19e3d16-bc11-11e4-9caa-c2051d5d46b0
	CPER:
	      00000000  04 00 00 00 02 00 00 00 68 00 00 00 00 00 00 00   ........h.......
	      00000010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
	      00000020  00 00 00 00 00 00 00 00 00 20 05 00 04 02 00 03   ......... ......
	      00000030  7f 00 54 00 00 00 00 00 ef be ad de 00 00 00 00   ..T.............
	      00000040  ad 0b ba ab 00 00 00 00 00 20 00 00 18 01 00 03   ......... ......
	      00000050  00 00 00 00 00 00 00 00 ef be ad de 00 00 00 00   ................
	      00000060  ad 0b ba ab 00 00 00 00                           ........

	Error injected.

The CPER event is now properly handled:

[   83.807957] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[   83.808314] {1}[Hardware Error]: event severity: recoverable
[   83.808545] {1}[Hardware Error]:  Error 0, type: recoverable
[   83.808806] {1}[Hardware Error]:   section_type: ARM processor error
[   83.809045] {1}[Hardware Error]:   MIDR: 0x0000000000000000
[   83.809262] {1}[Hardware Error]:   running state: 0x0
[   83.809441] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[   83.809691] {1}[Hardware Error]:   Error info structure 0:
[   83.809885] {1}[Hardware Error]:   num errors: 3
[   83.810128] {1}[Hardware Error]:    error_type: 0x04: TLB error
[   83.810364] {1}[Hardware Error]:    error_info: 0x000000000054007f
[   83.810595] {1}[Hardware Error]:     transaction type: Instruction
[   83.810821] {1}[Hardware Error]:     TLB error, operation type: Instruction fetch
[   83.811095] {1}[Hardware Error]:     TLB level: 1
[   83.811283] {1}[Hardware Error]:     processor context not corrupted
[   83.811501] {1}[Hardware Error]:     the error has not been corrected
[   83.811721] {1}[Hardware Error]:     PC is imprecise
[   83.811924] {1}[Hardware Error]:   Error info structure 1:
[   83.812105] {1}[Hardware Error]:   num errors: 2
[   83.812263] {1}[Hardware Error]:    error_type: 0x18: bus error|micro-architectural error
[   83.812956] [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
[   83.813212] [Firmware Warn]: GHES: Unhandled processor error type 0x18: bus error|micro-architectural error

- 

I also tested the ghes and cper reports both with and without this
change, using different versions of rasdaemon, with and without
support for the extended trace event. Those are a summary of the
test results:

- adding more fields to the trace events didn't break userspace API:
  both versions of rasdaemon handled it;

- the rasdaemon patches to handle the new trace report was missing
  a backward-compatibility logic. I fixed already. So, rasdaemon
  can now handle both old and new trace events.

Btw, rasdaemon has gained support for the extended trace since its
version 0.5.8 (released in 2021). I didn't saw any issues there
complain about troubles on it, so either distros used on ARM servers
are using an old version of rasdaemon, or they're carrying on the trace
event changes as well.

---

v3:
 - rebased on the top of 6.11-rc1;
 - test example updated to reflect latest error-inj patch series submitted
   to qemu-devel

v2:
  - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
  - cper_bits_to_str() now returns the number of chars filled at the buffer;
  - did a cosmetic (blank lines) improvement at include/linux/ras.h;
  - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.
    

Daniel Ferguson (1):
  RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
  docs: efi: add CPER functions to driver-api

 .../driver-api/firmware/efi/index.rst         | 11 ++--
 drivers/acpi/apei/ghes.c                      | 26 +++++-----
 drivers/firmware/efi/cper-arm.c               | 52 +++++++++----------
 drivers/firmware/efi/cper.c                   | 45 +++++++++++++++-
 drivers/ras/ras.c                             | 45 +++++++++++++++-
 include/linux/cper.h                          | 12 +++--
 include/linux/ras.h                           | 16 ++++--
 include/ras/ras_event.h                       | 48 +++++++++++++++--
 8 files changed, 196 insertions(+), 59 deletions(-)

-- 
2.45.2



