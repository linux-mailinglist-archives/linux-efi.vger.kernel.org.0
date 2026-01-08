Return-Path: <linux-efi+bounces-5958-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E2FD02AA4
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7554300F242
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0034A65CC;
	Thu,  8 Jan 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzAtJkp8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA64AA358;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872137; cv=none; b=ueuUumwi0Toi2EvHlinNXeC38I5/oTmHGo/jKBD0Awgax7q8qvhVNNtAS9WzRiKg618T84vyeF2mpX/PuaCgXrUIsmLY2FoacUsU6//mdkL4ySoER7CpUGazjmvGq9HTNg5TNNyACiF8S8dnPN5VFYszjawZJVhSJh2t7frW8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872137; c=relaxed/simple;
	bh=scgRQtvxWe1bibGyPBtCn2uk3uO+2XmBApMOmNEAjqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KJv6v2vY1KtDVmBVAyc4hZJqToHUtobN42ySZdWsG7JVxgWbZsxEMsI9EGYPq5saMBKDFKCN3tYs0FwPi+ePinF4Rmf/yKPPYNr71aCmgV5qG8Crv/FRheWuIrn4K5UKwNbFK3DQjvxOAeA3RTvDb77Nk/6FKI8OHNo1KtT9R7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzAtJkp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A459C19422;
	Thu,  8 Jan 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767872136;
	bh=scgRQtvxWe1bibGyPBtCn2uk3uO+2XmBApMOmNEAjqM=;
	h=From:To:Cc:Subject:Date:From;
	b=rzAtJkp8XOdmkDPXGBJuYVQzhczJz27F7HpfSa3hKFr19exjpdmDNPF8LZIsSiZRQ
	 glWm4xiIzDdlCBvTJmKUZSFz/LFw/zNjvBHwRwwY2Yf2ZYzHGbUUpbXLIzjWIEiSK3
	 TtoeNU3kOVcqluVzPjiUyXQlvBweN4D/Auix/g0GZtqc687A+zDhAVR6+2gq630vpA
	 HK+NkIEcKW9nClstA7TwXERnpk0xce3+FPV7KQZulRhMNbTWiCvgtCl6PA0Y8z5YAW
	 uqOSg2lXTHM/+TL372QQzN6CEMnGDo8RKNMrNSgLZP8TWGs1VoWW6Alr+JlYGxj8kF
	 06wfj0JsUut5Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vdoIf-000000033y5-40SB;
	Thu, 08 Jan 2026 12:35:33 +0100
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
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 0/4] apei/ghes: don't OOPS with bad ARM error CPER records
Date: Thu,  8 Jan 2026 12:35:02 +0100
Message-ID: <cover.1767871950.git.mchehab+huawei@kernel.org>
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

v6:
 - No code changes, just a cosmetic change at patch 3 description
 - Added Jonathan's review on all patches

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


