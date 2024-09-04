Return-Path: <linux-efi+bounces-1651-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C096B0F7
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C4F1F2660C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D684E14;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbOdppse"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC084A36;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430064; cv=none; b=UMT2guDJyKy6LQKfUolomz0E2L4RLVJOp6HWPK+SiGEQ1CLRMjW/mpyj3yLks2XGvOFUvpxjV87soxTG9sgdF0ip0oWpQ0aJVYkWGQYc94uFz144hYxrCZB0if1ePDudcfW3Rd3EM1q3P18iJognWXyaDMlS3Ez6dqOsopo/zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430064; c=relaxed/simple;
	bh=EPR34i1ApP1W3IN8ZGV5gYeG+Qdt78uCwjXb2+lkZ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSIE2/HprRnwFkUdfg4GgKp6641Cfy3WvhnqqpMCaQzssbM5sANOUP/AF8oujc55I8PQNhN1wmdPKqbTLQxJONOKXl+KBxeivQX9GFT5XdjuQlfABWZTE0vHmna+IUEvc3eOBHinyG1S/t0nGOd624Rj78hTQaOROxm46KAqbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbOdppse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC72C4CECA;
	Wed,  4 Sep 2024 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430064;
	bh=EPR34i1ApP1W3IN8ZGV5gYeG+Qdt78uCwjXb2+lkZ7E=;
	h=From:To:Cc:Subject:Date:From;
	b=hbOdppseLYiL43y+tAVIiYWL2VdtT043qE/WzBHwrFRYQk6vUA2QrqxoQPuaM+6JK
	 2ZbU0w3Vavl8lhwfSoe7VY13CRmoS9lfNZlb7k8SbENTUpiMWrj35TUUPZ8XgJvJrg
	 Fyz4E1a/lZnxBsjwypa55JgLao0rgc6rPC+seKwuch2ZDO0HMACYUnjVn5mojUjWL6
	 H+Cr8MRwd9Jj70aWbMnRB+zg67VQ8v1ABL60JrXqpYIskCQO1iRUQ9+tMboh19GjJt
	 QE14MJdgPt0HbWrzHan8id3Q6dfO7Akhj/nPHtYuNVomEQocI1y9EPbYF3vZYtTsMM
	 eBDXUoaU/QvCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sljB8-00000006Ite-04Ih;
	Wed, 04 Sep 2024 08:07:42 +0200
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
Date: Wed,  4 Sep 2024 08:07:13 +0200
Message-ID: <cover.1725429659.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
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

	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission

$ scripts/ghes_inject.py -d arm -p 0xdeadbeef -t cache,bus,micro-arch

[   11.094205] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[   11.095009] {1}[Hardware Error]: event severity: recoverable
[   11.095486] {1}[Hardware Error]:  Error 0, type: recoverable
[   11.096090] {1}[Hardware Error]:   section_type: ARM processor error
[   11.096399] {1}[Hardware Error]:   MIDR: 0x00000000000f0510
[   11.097135] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[   11.097811] {1}[Hardware Error]:   running state: 0x0
[   11.098193] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[   11.098699] {1}[Hardware Error]:   Error info structure 0:
[   11.099174] {1}[Hardware Error]:   num errors: 2
[   11.099682] {1}[Hardware Error]:    error_type: 0x1a: cache error|bus error|micro-architectural error
[   11.100150] {1}[Hardware Error]:    physical fault address: 0x00000000deadbeef
[   11.111214] Memory failure: 0xdeadb: recovery action for free buddy page: Recovered

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
 - history of patch 1 improved with a chain of co-developed-by;
 - add a better description and an example on patch 3;
 - use BIT_ULL() on patch 3;
 - add a missing include on patch 4.

v2:
  - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
  - cper_bits_to_str() now returns the number of chars filled at the buffer;
  - did a cosmetic (blank lines) improvement at include/linux/ras.h;
  - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.
    


Jason Tian (1):
  RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
  docs: efi: add CPER functions to driver-api

 .../driver-api/firmware/efi/index.rst         | 11 +++-
 drivers/acpi/apei/ghes.c                      | 27 ++++----
 drivers/firmware/efi/cper-arm.c               | 52 ++++++++--------
 drivers/firmware/efi/cper.c                   | 62 ++++++++++++++++++-
 drivers/ras/ras.c                             | 41 +++++++++++-
 include/linux/cper.h                          | 12 ++--
 include/linux/ras.h                           | 16 ++++-
 include/ras/ras_event.h                       | 48 ++++++++++++--
 8 files changed, 210 insertions(+), 59 deletions(-)

-- 
2.46.0



