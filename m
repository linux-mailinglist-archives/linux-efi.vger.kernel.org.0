Return-Path: <linux-efi+bounces-956-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1F8AD736
	for <lists+linux-efi@lfdr.de>; Tue, 23 Apr 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19FC1C20E36
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0141F922;
	Mon, 22 Apr 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqFeJsfF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BB1CF8B;
	Mon, 22 Apr 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824748; cv=none; b=ru9Glat8jUyr/vJ8RFklFd8/Qe+dUutB6VJLikGF89K4vP/9txBpdh41nVALvk/NmtapxzafXa3KjCOOeBdNNRi0+qIJi40t+SSIkZ/Dc79BnW/ZO4COWl8oEHFstUvlC3HInoZYCHGwcIijFBHGFdGPKxpoT7bmMgfrEY0ITiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824748; c=relaxed/simple;
	bh=2Phf3ks/cnNo6Uuryp1lm3GfxtwMoBkYFhifOVUn7P8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fqAVcICCjqRTBo3x9yWribmjWv7NXKV6SGnJT83CdXqEkwmqa2PGjHLIe39pokY2nCIBz9MrHDm30ZChLAe+a0t4sroqa32rRWfPg+EYFOMTelfYsRryy+CGS0qeonQz4pyZqYBXuDQrEpSTqzCA1P/scGY2Mtfq7czh4u2B7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqFeJsfF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824747; x=1745360747;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=2Phf3ks/cnNo6Uuryp1lm3GfxtwMoBkYFhifOVUn7P8=;
  b=nqFeJsfFu7tk7xyS2QNgLdA1CnH03H6lWHiR0fhfKO1ljSKQ9E/yhso5
   JFok174Fp2RmA7kr4S5vhpbpfAHrsjkmTnglaTZt/UaJqzkoC2yxvqNWu
   sobCtEzcBKPrzOrvvTnUWfDEBiHkYFhJAbDCTrhxHLENLwXZl4SCulSZW
   PcE+oCoNTZj08j+Ighna5k/UlurSBz5Yht556/KToPdCPRLi3wLmZyBbM
   NDagKy3mB+1lFEqKgsfxD1aQSQpsQFFgy8JfaNFFO/9IswXtJ/OTyOgUB
   DN5oA64V8TbBfGyvP06xtNvFpamOLPU1BHq77cLf3bLN0PvkFzjbgFHmm
   A==;
X-CSE-ConnectionGUID: XSNrLJzUT4aSw+Eha4vNuA==
X-CSE-MsgGUID: YoxEcCtWQnCnXlHW2btkAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19997720"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19997720"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:46 -0700
X-CSE-ConnectionGUID: e08MvUHVSUCsr/0sawEHtw==
X-CSE-MsgGUID: 7pXqjSa/S32tnHQd847OPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55094320"
Received: from iweiny-mobl.sc.intel.com (HELO localhost) ([10.144.160.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:25:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/3] efi/cxl-cper: Report CXL CPER events through
 tracing
Date: Mon, 22 Apr 2024 15:25:44 -0700
Message-Id: <20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjjJmYC/03MSwrCMBSF4a2UOzaSRxttR+5DOgjxxl6oSUlKq
 JTs3VgQHP6Hw7dDwkiYYGh2iJgpUfA15KkBOxn/REaP2iC5bLmUnNltZnbBqJji2HXy0rteaaj
 /JaKj7bDuY+2J0hri+6Cz+K4/5fqnZME408YoJ1SrrLY38ivOZxteMJZSPnhExYKiAAAA
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713824744; l=2465;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=2Phf3ks/cnNo6Uuryp1lm3GfxtwMoBkYFhifOVUn7P8=;
 b=lu2kTiZytHzyWJb7z+ye6p1Xw6SNeCJkq85Q8tJcdSeUnRYRafxBapuzQL6oNsJhjcZbyCPzB
 /eaANkp6I9uDIyL/LR0cZ6YcB9me2tZmHS03lPK6bwhcfBXnNmTOIjL
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

If a device is configured for firmware first CXL event records are not
sent directly to the host, rather they are reported through the EFI
Common Platform Error Records (CPER).  EFI 2.10 Section N.2.14 defines
the CXL CPER to wrap a mostly CXL event payload.

The CXL sub-system uniquely has DPA to HPA translation information.[0]
It also already has event decoding/tracing.  Such translations are very
useful for users to determine which system issues may correspond to
specific hardware events.

The restructuring of the event data structures in 6.8 made sharing the
data between CPER/event logs more efficient.  Now re-wire the sending of
CPER records to the CXL sub-system.

In addition provide a default RAS event should the CXL module not be
loaded.

Series status/background
========================

Smita and Jonathan have been a great help with this series.  Once again
thank you.

Unfortunately, with all the churn surrounding the bug which Dan
Carpenter found the maintainers were force to revert this work.

Testing
=======

A quick hack was added to debugfs patch to facilitate easier testing.[1]

With this it was verified that the bug Dan Carpenter found is fixed.
However, the tp_printk bug Jonathan found remains.  Fortunately,
tp_printk is not widely used so it is anticipated this will not be an
issue.

[0]
Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
[1]
Link: https://github.com/weiny2/linux-kernel/commit/9b1f33314e8488506dbad63dc1c896386d4803d6

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- iweiny: address comments from V1 (noted in the patches themselves)
- iweiny: drop header file clean up patch (only needed for my debugfs test)
- Link to v1: https://lore.kernel.org/r/20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com

---
Ira Weiny (3):
      acpi/ghes: Process CXL Component Events
      cxl/pci: Process CPER events
      ras/events: Trace CXL CPER events without CXL stack

 drivers/acpi/apei/ghes.c  | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c         |  61 +++++++++++++++++++++-
 include/linux/cxl-event.h |  18 +++++++
 include/ras/ras_event.h   |  51 ++++++++++++++++++
 4 files changed, 257 insertions(+), 1 deletion(-)
---
base-commit: 4d2008430ce87061c9cefd4f83daf2d5bb323a96
change-id: 20240220-cxl-cper3-30e55279f936

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


