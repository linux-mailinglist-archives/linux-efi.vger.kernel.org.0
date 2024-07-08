Return-Path: <linux-efi+bounces-1374-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25D92A0E0
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013902828C8
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B7B7E563;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j008E0SA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E57C6EB;
	Mon,  8 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437554; cv=none; b=HRL5E+ubJdRmxLDxtexZzq3J46wi1fDvDvNomcnbwQzflzdoNaLJ6ec1K7dFBjxMqM6r3FMnEzmA9Sg321dNMdeSUENiRMWflxiXO0fNv7JhYXMeQCfJpIt2U0hZ24Fu15VDV3Ci7/+dXa5xM0QibKb8YOmupPbqs531x6OYiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437554; c=relaxed/simple;
	bh=oC15OE0ts5A8K/1eYAbJ9HeUTumGagQU0KI7p+3Ve5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UX2pW3c2k82B68tH5bEv1NGS6KUutxm4b7NUgk/mQ+jKFghm6alr5yty7r52QYN855FKM9KPh1GAksyKZB3T/QYOFmuY5Sn/55VU+YCDc3zjsP9DQVUi8XQRDlx6Tmupd/JhWkE3cyMyAwiqZ96OKVoZmTszzbhPV01bEtAt1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j008E0SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E1C4AF0B;
	Mon,  8 Jul 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720437554;
	bh=oC15OE0ts5A8K/1eYAbJ9HeUTumGagQU0KI7p+3Ve5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=j008E0SA6PnRAtXijxtSHd1socLvbD6CMjH91VFwjXsANbsNPdXBadj0t2q39yXS/
	 pacNCVMlaz0jPfVxpymZ3c/aZtxejpg4R8CBUCPRQ2yntTeU+ForD4oYgqSqXkGZMd
	 k/VtsiP0qwgA9PIzd91sDBX9RQSJdm4m6Na3kkgU6XG1Qu8amw5JpcxIcLtdTAqd9L
	 CG65OvEfcp5aiiHcMUPAoJqDJheQIwBHpirFZjxM0uKaLJaTRn4/fS3BnuBVMTmrCN
	 5AVAxBzjKu5KBKyu/AmX/cTZ3GDNLuhnzDbNgv3Z8YlMNby/9eJawzHHJOgNAGgGCz
	 kmuc/UWEAeNlg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sQmOl-00000001SQW-28jU;
	Mon, 08 Jul 2024 13:19:11 +0200
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
Subject: [PATCH 0/6] Fix issues with ARM Processor CPER records
Date: Mon,  8 Jul 2024 13:18:09 +0200
Message-ID: <cover.1720436039.git.mchehab+huawei@kernel.org>
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

This series replaces two previously-sent series:
- https://lore.kernel.org/linux-edac/cover.1719219886.git.mchehab+huawei@kernel.org/T/#t
- https://lore.kernel.org/linux-edac/cover.1719484498.git.mchehab+huawei@kernel.org/T/#t

It is also available at:

	https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git/log/?h=edac-arm64

This is needed for both kernelspace and userspace properly handle ARM processor CPER
events.

Patches 1 and 2 of this series fix the UEFI 2.6+ implementation of the ARM 
trace event, as the original implementation was incomplete.
Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
added such event, but it reports only some fields of the CPER record
defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough 
actually parse such events on userspace, as not even the event type
is exported.

Patch 3 fixes a compilation breakage when W=1;

Patch 4 adds a new helper function to be used by cper and ghes drivers to
display CPER bitmaps;

Patch 5 fixes CPER logic according with UEFI 2.9A errata. Before it, there
was no description about how processor type field was encoded. The errata
defines it as a bitmask, and provides the information about how it should
be encoded.

Patch 6 adds CPER functions to Kernel-doc.

This series was validated with the help of an ARM EINJ code for QEMU:

	https://github.com/mchehab/rasdaemon/wiki/error-injection

Using the QEMU injection code at:

   https://gitlab.com/mchehab_kernel/qemu/-/commits/arm-error-inject-v2?ref_type=heads

Running it on QEMU and sending those commands via QEMU QMP interface:

    { "execute": "qmp_capabilities" } 
    { "execute": "arm-inject-error", "arguments": {
	"validation": ["mpidr-valid", "affinity-valid", "running-state-valid", "vendor-specific-valid"],
	"running-state": [], "psci-state": 1229279264, "error": [
	{"type": ["tlb-error", "bus-error", "micro-arch-error"], "multiple-error": 2}, 
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

Daniel Ferguson (1):
  RAS: ACPI: APEI: add conditional compilation to ARM error report
    functions

Mauro Carvalho Chehab (4):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
  docs: efi: add CPER functions to driver-api

Shengwei Luo (1):
  RAS: Report all ARM processor CPER information to userspace

 .../driver-api/firmware/efi/index.rst         | 11 ++--
 drivers/acpi/apei/ghes.c                      | 31 +++++------
 drivers/firmware/efi/cper-arm.c               | 52 +++++++++----------
 drivers/firmware/efi/cper.c                   | 43 ++++++++++++++-
 drivers/ras/ras.c                             | 47 ++++++++++++++++-
 include/linux/cper.h                          | 12 +++--
 include/linux/ras.h                           | 16 ++++--
 include/ras/ras_event.h                       | 48 +++++++++++++++--
 8 files changed, 198 insertions(+), 62 deletions(-)

-- 
2.45.2



