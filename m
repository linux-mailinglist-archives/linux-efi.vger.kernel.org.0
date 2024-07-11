Return-Path: <linux-efi+bounces-1420-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7592E030
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 08:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585E3B21ACC
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E312F385;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw3NCHVQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145C55C08;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679469; cv=none; b=Y3WfKz1isBoxe0f/4/RCwhB7UsTo0tT3ycjln3ALB9rA5iaLBBjgugSKJayCIoNhCLj3MPWaL5jNdfvXSR1oM8U7KDGfzjR9kk1f2kWpSKS7XYe7zSp57uLHMnhkaFmqT5B5eaZ659Gw16ChytY8Hpt9rm2lUZ4jiAFwNjA30GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679469; c=relaxed/simple;
	bh=H9Jo/lswhPifjqpyYOQ7Iu6s++FZSqM6T+tAx/ll7ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sPlqV5I2GzCiElCd0HaWbWp/jC1rsuBfK8alAoqnJ7tnZBWlxGEq5GVKwAohVdfBZ67VrIZu9WZd9QvstOOBjK8y1ZlGqmrGGbuX2VFFLGz5mU5XMTiYYgeHA/wRJYq/588DKYPPF1AbBnAdFmKaQhMp7+bbcz3YGW+VZV/2Vr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw3NCHVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37439C4AF0C;
	Thu, 11 Jul 2024 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679469;
	bh=H9Jo/lswhPifjqpyYOQ7Iu6s++FZSqM6T+tAx/ll7ic=;
	h=From:To:Cc:Subject:Date:From;
	b=rw3NCHVQOohmkxABNcLqpkIPmS9q1tud3vlgFYdMsFJY8Yo2n87heO0xJq8rBBixX
	 F3xj6es1oC73EcE5NBbei+SfITtOrl06zKgrQtpdE7ysqwdKX6G3KXTItddv6FPv2w
	 hXBZ+ZFk5+lAJcGIgOk4iqwbEV2h+U4Q7fsMumFOv7h8qmRnAdY/G5OLgJ8YNuzFvL
	 Q+e3VP4O2uH6TEzrEEDdm4EHL+d73tzo6H/FRXU8hQP3XiE8iHr40NLHCR/JNlNyT2
	 IzAmW+Ja/iBLfirXSwAaoAZhPZXaAlfGVRhWVHN1inZ24FnU2QfkC5LZgsKsTilbEY
	 FIb0fjuDwrXlQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sRnKc-00000002b5O-0ziH;
	Thu, 11 Jul 2024 08:31:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/5] Fix issues with ARM Processor CPER records
Date: Thu, 11 Jul 2024 08:28:51 +0200
Message-ID: <cover.1720678576.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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

	https://github.com/mchehab/rasdaemon/wiki/error-injection

Using the QEMU injection code at:

   https://gitlab.com/mchehab_kernel/qemu/-/commits/arm-error-inject-v2?ref_type=heads

Running it on QEMU and sending those commands via QEMU QMP interface:

    { "execute": "qmp_capabilities" } 
    { "execute": "arm-inject-error", "arguments": {
	"validation": ["mpidr-valid", "affinity-valid",
		       "running-state-valid", "vendor-specific-valid"],
	"running-state": [], "psci-state": 1229279264, "error": [
	{"type": ["tlb-error", "bus-error", "micro-arch-error"],
		  "multiple-error": 2},
	{"type": ["micro-arch-error"]},
	{"type": ["tlb-error"]},
	{"type": ["bus-error"]},
	{"type": ["cache-error"]}]} }

The CPER event is now properly handled:

[   53.223383] {1}[Hardware Error]: event severity: recoverable
[   53.223690] {1}[Hardware Error]:  Error 0, type: recoverable
[   53.224073] {1}[Hardware Error]:   section_type: ARM processor error
[   53.224419] {1}[Hardware Error]:   MIDR: 0x0000000000000000
[   53.224694] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[   53.225029] {1}[Hardware Error]:   error affinity level: 2
[   53.225266] {1}[Hardware Error]:   running state: 0x0
[   53.225516] {1}[Hardware Error]:   Power State Coordination Interface state: 1229279264
[   53.225857] {1}[Hardware Error]:   Error info structure 0:
[   53.226094] {1}[Hardware Error]:   num errors: 3
[   53.226317] {1}[Hardware Error]:    first error captured
[   53.226548] {1}[Hardware Error]:    propagated error captured
[   53.226806] {1}[Hardware Error]:    overflow occurred, error info is incomplete
[   53.227180] {1}[Hardware Error]:    error_type: 0x1c: TLB error|bus error|micro-architectural error
[   53.227549] {1}[Hardware Error]:    error_info: 0x000000000054007f
[   53.227819] {1}[Hardware Error]:    virtual fault address: 0x0000000067320230
[   53.228106] {1}[Hardware Error]:    physical fault address: 0x000000005cdfd492
[   53.228403] {1}[Hardware Error]:   Error info structure 1:
[   53.228636] {1}[Hardware Error]:   num errors: 3
[   53.228840] {1}[Hardware Error]:    first error captured
[   53.229061] {1}[Hardware Error]:    propagated error captured
[   53.229296] {1}[Hardware Error]:    overflow occurred, error info is incomplete
[   53.229577] {1}[Hardware Error]:    error_type: 0x10: micro-architectural error
[   53.229873] {1}[Hardware Error]:    error_info: 0x0000000078da03ff
[   53.230130] {1}[Hardware Error]:    virtual fault address: 0x0000000067320230
[   53.230412] {1}[Hardware Error]:    physical fault address: 0x000000005cdfd492
[   53.230694] {1}[Hardware Error]:   Error info structure 2:
[   53.230924] {1}[Hardware Error]:   num errors: 3
[   53.231128] {1}[Hardware Error]:    first error captured
[   53.231349] {1}[Hardware Error]:    propagated error captured
[   53.231582] {1}[Hardware Error]:    overflow occurred, error info is incomplete
[   53.231863] {1}[Hardware Error]:    error_type: 0x04: TLB error
[   53.232116] {1}[Hardware Error]:    error_info: 0x000000000054007f
[   53.232396] {1}[Hardware Error]:     transaction type: Instruction
[   53.232686] {1}[Hardware Error]:     TLB error, operation type: Instruction fetch
[   53.232998] {1}[Hardware Error]:     TLB level: 1
[   53.233215] {1}[Hardware Error]:     processor context not corrupted
[   53.233479] {1}[Hardware Error]:     the error has not been corrected
[   53.233740] {1}[Hardware Error]:     PC is imprecise
[   53.233974] {1}[Hardware Error]:    virtual fault address: 0x0000000067320230
[   53.234264] {1}[Hardware Error]:    physical fault address: 0x000000005cdfd492
[   53.234547] {1}[Hardware Error]:   Error info structure 3:
[   53.234776] {1}[Hardware Error]:   num errors: 3
[   53.234980] {1}[Hardware Error]:    first error captured
[   53.235199] {1}[Hardware Error]:    propagated error captured
[   53.235433] {1}[Hardware Error]:    overflow occurred, error info is incomplete
[   53.235714] {1}[Hardware Error]:    error_type: 0x08: bus error
[   53.235966] {1}[Hardware Error]:    error_info: 0x00000080d6460fff
[   53.236223] {1}[Hardware Error]:     transaction type: Generic
[   53.236478] {1}[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)
[   53.236923] {1}[Hardware Error]:     affinity level at which the bus error occurred: 1
[   53.237234] {1}[Hardware Error]:     processor context corrupted
[   53.237481] {1}[Hardware Error]:     the error has been corrected
[   53.237728] {1}[Hardware Error]:     PC is imprecise
[   53.237937] {1}[Hardware Error]:     Program execution can be restarted reliably at the PC associated with the error.
[   53.238329] {1}[Hardware Error]:     participation type: Local processor observed
[   53.238627] {1}[Hardware Error]:     request timed out
[   53.238851] {1}[Hardware Error]:     address space: External Memory Access
[   53.239129] {1}[Hardware Error]:     memory access attributes:0x20
[   53.239393] {1}[Hardware Error]:     access mode: secure
[   53.239613] {1}[Hardware Error]:    virtual fault address: 0x0000000067320230
[   53.239890] {1}[Hardware Error]:    physical fault address: 0x000000005cdfd492
[   53.240168] {1}[Hardware Error]:   Error info structure 4:
[   53.240396] {1}[Hardware Error]:   num errors: 3
[   53.240601] {1}[Hardware Error]:    first error captured
[   53.240816] {1}[Hardware Error]:    propagated error captured
[   53.241048] {1}[Hardware Error]:    overflow occurred, error info is incomplete
[   53.241332] {1}[Hardware Error]:    error_type: 0x02: cache error
[   53.241589] {1}[Hardware Error]:    error_info: 0x000000000091000f
[   53.241843] {1}[Hardware Error]:     transaction type: Data Access
[   53.242101] {1}[Hardware Error]:     cache error, operation type: Data write
[   53.242385] {1}[Hardware Error]:     cache level: 2
[   53.242596] {1}[Hardware Error]:     processor context not corrupted
[   53.242847] {1}[Hardware Error]:    virtual fault address: 0x0000000067320230
[   53.243125] {1}[Hardware Error]:    physical fault address: 0x000000005cdfd492
[   53.243426] {1}[Hardware Error]:   Context info structure 0:
[   53.243675] {1}[Hardware Error]:    register context type: AArch64 EL1 context registers
[   53.244185] {1}[Hardware Error]:    00000000: 12abde67 00000000 00000000 00000000
[   53.244540] {1}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000
[   53.244864] {1}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000
[   53.245183] {1}[Hardware Error]:    00000030: 00000000 00000000 00000000 00000000
[   53.245504] {1}[Hardware Error]:    00000040: 00000000 00000000 00000000 00000000
[   53.245828] {1}[Hardware Error]:    00000050: 00000000 00000000 00000000 00000000
[   53.246149] {1}[Hardware Error]:    00000060: 00000000 00000000 00000000 00000000
[   53.246475] {1}[Hardware Error]:    00000070: 00000000 00000000 00000000 00000000
[   53.246799] {1}[Hardware Error]:    00000080: 00000000 00000000 00000000 00000000
[   53.247122] {1}[Hardware Error]:    00000090: 00000000 00000000 00000000 00000000
[   53.247446] {1}[Hardware Error]:    000000a0: 00000000 00000000 00000000 00000000
[   53.247767] {1}[Hardware Error]:    000000b0: 00000000 00000000 00000000 00000000
[   53.248090] {1}[Hardware Error]:    000000c0: 00000000 00000000 00000000 00000000
[   53.248415] {1}[Hardware Error]:    000000d0: 00000000 00000000 00000000 00000000
[   53.248739] {1}[Hardware Error]:    000000e0: 00000000 00000000 00000000 00000000
[   53.249064] {1}[Hardware Error]:    000000f0: 00000000 00000000 00000000 00000000
[   53.249398] {1}[Hardware Error]:    00000100: 00000000 00000000 00000000 00000000
[   53.249727] {1}[Hardware Error]:    00000110: 00000000 00000000 00000000 00000000
[   53.250053] {1}[Hardware Error]:    00000120: 00000000 00000000 00000000 00000000
[   53.250377] {1}[Hardware Error]:    00000130: 00000000 00000000 00000000 00000000
[   53.250700] {1}[Hardware Error]:    00000140: 00000000 00000000 00000000 00000000
[   53.251038] {1}[Hardware Error]:    00000150: 00000000 00000000 00000000 00000000
[   53.251368] {1}[Hardware Error]:    00000160: 00000000 00000000 00000000 00000000
[   53.251694] {1}[Hardware Error]:    00000170: 00000000 00000000 00000000 00000000
[   53.252017] {1}[Hardware Error]:    00000180: 00000000 00000000 00000000 00000000
[   53.252342] {1}[Hardware Error]:    00000190: 00000000 00000000 00000000 00000000
[   53.252664] {1}[Hardware Error]:    000001a0: 00000000 00000000 00000000 00000000
[   53.252984] {1}[Hardware Error]:    000001b0: 00000000 00000000 00000000 00000000
[   53.253309] {1}[Hardware Error]:    000001c0: 00000000 00000000 00000000 00000000
[   53.253630] {1}[Hardware Error]:    000001d0: 00000000 00000000 00000000 00000000
[   53.253949] {1}[Hardware Error]:    000001e0: 00000000 00000000 00000000 00000000
[   53.254273] {1}[Hardware Error]:    000001f0: 00000000 00000000 00000000 00000000
[   53.254595] {1}[Hardware Error]:    00000200: 00000000 00000000 00000000 00000000
[   53.254917] {1}[Hardware Error]:    00000210: 00000000 00000000 00000000 00000000
[   53.255245] {1}[Hardware Error]:    00000220: 00000000 00000000 00000000 00000000
[   53.255569] {1}[Hardware Error]:    00000230: 00000000 00000000 00000000 00000000
[   53.255890] {1}[Hardware Error]:    00000240: 00000000 00000000 00000000 00000000
[   53.256794] [Firmware Warn]: GHES: Unhandled processor error type 0x1c: TLB error|bus error|micro-architectural error
[   53.257203] [Firmware Warn]: GHES: Unhandled processor error type 0x10: micro-architectural error
[   53.257543] [Firmware Warn]: GHES: Unhandled processor error type 0x04: TLB error
[   53.257842] [Firmware Warn]: GHES: Unhandled processor error type 0x08: bus error

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




