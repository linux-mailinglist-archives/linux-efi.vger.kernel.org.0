Return-Path: <linux-efi+bounces-5944-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFDCF7ACA
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 11:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944D530FF18D
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269C30F937;
	Tue,  6 Jan 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvOorBs3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2230F802;
	Tue,  6 Jan 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693712; cv=none; b=Hs/5wRMgwDD/pTpWu7k/Y+6uHEE6h+PwdMCYRsKsu38TI0eYQ99nD6u4w9dpWCXkKKwVJdM4jb0Q9hv0z6PP9rciJfEPCl/9LsYDCgox6DErfR3KMa9ncQYwUg1IvlMxTfDWhVlYMlA9k5mQ/r5nylvuqhRd1l57vC/G7j1/xAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693712; c=relaxed/simple;
	bh=N13GlUqWB+FxkmAZcovRjJqMegXZ8A3lxIKH7KbwRvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oglgb9o0wxoa9nei7HieCKrNJvc+GAkcuMBopDVOgb1WNUKK1ySCdh3M9fb49Ov45I0pf6pfzEDDaP8RTW22lwcq5rU4iNfjrDwup0dkWyR2nJaFncdh2TgAzUwr/oDfNWLSJFM/1NEJ+iSGruGEcrytdWyifPEzaIhe1bl98IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvOorBs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB8C19424;
	Tue,  6 Jan 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767693710;
	bh=N13GlUqWB+FxkmAZcovRjJqMegXZ8A3lxIKH7KbwRvs=;
	h=From:To:Cc:Subject:Date:From;
	b=TvOorBs3oF0WJmvBxhgmcfMSnYSUEMVQF2eWDtidXC8CNLdfGu/UEa1QUsGW2ivKB
	 cZETNKB4D660Hk5QttLtFIJYq8aMhZztAMnk3oIEaodbQxciB4qZifzI4nn0xf49VY
	 uReBUd1Q6ehETMmKCpMdnL94o+je8q20/RlX2YnmFgFFTNzSHdgHKPGbmm2Msu36XF
	 Ze/5kOEmLtIzf1CR3clSEEP3z86lO6BbMqYvmvOOnC7dVkHP4pxIv9P7GGrzKsmooY
	 MQ0GTXCqJ0FAEBKlFc9PZISY+BLoyC1xvs2P9eJPq2jf3Vn1RLHexVmwIfOIQkOjs3
	 bXo6u5H7B++Qw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vd3sp-000000008ZF-3xPz;
	Tue, 06 Jan 2026 11:01:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v4 0/4] apei/ghes: don't OOPS with bad ARM error CPER records
Date: Tue,  6 Jan 2026 11:01:34 +0100
Message-ID: <cover.1767693532.git.mchehab+huawei@kernel.org>
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


