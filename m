Return-Path: <linux-efi+bounces-5952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1183CFEFC8
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 18:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 355A33002D01
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C12389DF5;
	Wed,  7 Jan 2026 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B22R1tlp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4783803E7;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804131; cv=none; b=gXNAwTcYWRBHhJhrf+Zs+34oc9gXDYLR1HweeCXO27ljbPBknsh8IbiDgKR8oR1htGqLoqQceiSs8SPcGYuDrvGypBgPcUerhR5x596U+HKE0TAW6XzmSQGwevrYNhcNPAhfnGY9GfbhHJKueUdvYC9XJ2k7Cdc4RB3IGIb83m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804131; c=relaxed/simple;
	bh=3pM5blFk05NRQwtrP5FPBeMNRlbo0ncNsartwdktr4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vc66P0riM5/4ZQXb2qusWbzx/cmn03d0P833nM5kjrzdmk7tpMt3ENZ9rTSfJ7NHcfAGU5lQ4182owmgvZSNTG1tEXuiL7Fu0TrM2sZkSUqV4P5U3iHM+wMFXXL3vygiiNOV5iuo75PbhShxjpKkqreJuFPJc/LZeYJrOc250VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B22R1tlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158E7C4CEF1;
	Wed,  7 Jan 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804130;
	bh=3pM5blFk05NRQwtrP5FPBeMNRlbo0ncNsartwdktr4I=;
	h=From:To:Cc:Subject:Date:From;
	b=B22R1tlpNgOSIuXwB7Mqjn1nWoZbWRQY/SSc8IpFHpF+cW+IO2hhHCOz9EJ8Itj22
	 L2eT7hla7UkBRqIflXnQ+VOLrOCHAp7BLtA7Fz5jETRTbyCzFTTNwBXWnOIwlpZIFf
	 UhfreSc9XTzRUBfij+fZKsCqlyB1RP2h/vJtW1mJiNjKY7FTsCVZS3xMP3qkWPX+Yu
	 4yR2GwsitYHtyCJ3FRQc56anqUVBlw3Ik8KZVgk+gex/ZflC3idHmZoafK5Urk83cG
	 bFvwoaBK+fCiFDggFkB9EYBaYR3NJnmb7FZ5jKTenuKroBSK0dBrzgH83vySISzmt8
	 G6F8rZpTez+tQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdWbo-00000001bUP-0eLR;
	Wed, 07 Jan 2026 17:42:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Agrawal <ankita@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Ingo Molnar <mingo@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 0/4] apei/ghes: don't OOPS with bad ARM error CPER records
Date: Wed,  7 Jan 2026 17:41:48 +0100
Message-ID: <cover.1767804050.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Rafael,

Current parsing logic at apei/ghes for ARM Processor Error
assumes that the record sizes are correct. Yet, a bad BIOS
might produce malformed GHES reports.

Worse than that, it may end exposing data from other memory
addresses, as the logic may end dumping large portions of
the memory.

Avoid that by checking the buffer sizes where needed.

---

v5:
 - Changed the name of a var as requested by Jonathan

v4:
 - addressed Jonathan comments;
 - added two extra patches to prevent other OOM issues.

v3:
  - addressed Shuai feedback;
  - moved all ghes code to one patch;
  - fixed a typo and a bad indent;
  - cleanup the size check logic at ghes.c.


Mauro Carvalho Chehab (4):
  apei/ghes: ARM processor Error: don't go past allocated memory
  efi/cper: don't go past the ARM processor CPER record buffer
  apei/ghes: ensure that won't go past CPER allocated record
  efi/cper: don't dump the entire memory region

 drivers/acpi/apei/ghes.c        | 38 ++++++++++++++++++++++++++++-----
 drivers/firmware/efi/cper-arm.c | 12 +++++++----
 drivers/firmware/efi/cper.c     |  8 ++++++-
 drivers/ras/ras.c               |  6 +++++-
 include/acpi/ghes.h             |  1 +
 include/linux/cper.h            |  3 ++-
 6 files changed, 56 insertions(+), 12 deletions(-)

-- 
2.52.0


