Return-Path: <linux-efi+bounces-988-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233438B409F
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 22:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FAC282578
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EB1CFBC;
	Fri, 26 Apr 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuK8mgWC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC701208AF;
	Fri, 26 Apr 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161788; cv=none; b=pahRN99076vs+1IRoBiJkRCGVmJEADhsWtGxboX4WFxF8roSmstyCWckeNBrT9jYNPgPwbUe0DnJX+067waOtJxGHtYy7EibP1k7c58M9o+x5IC1eSDhx6IleZ/HS3fxG8t2IzDYyBmoqoSOpdUxwq6P48TDB5Qv9cIXj4Xx2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161788; c=relaxed/simple;
	bh=Mq+HIvBiRfXqX7bq1lJIJQ9QW1/+6x26EYOzLbZxohA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c6Gtr2NJbx9fi7tUqMVRoDj+2KwemIad/035UKOZKZgQvm3YGPvWyQZZjtbeex7tgULDbosSxcFEFX1+tW3v9Np/KCLUcfEPF0vaZZYwXT3s+0YuRo84/03ihuJP5M1JegVXAolZ6XqFnnW679VrB6CYQgHFSrXTTt282ATye64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuK8mgWC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161787; x=1745697787;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Mq+HIvBiRfXqX7bq1lJIJQ9QW1/+6x26EYOzLbZxohA=;
  b=cuK8mgWCptBDl8wueIv3g8KnABfIBBa43DWs3I/eH1xpC19JGHIwIzW0
   qtz9ZWAAyBkYADAAj0RXII9DXuxwp07nGX0ayfNSKKNh5u/EHzClo6KBI
   HrR5gzJWyLym/kixjUT7cKqVEzR4J/attvbn8y7huFQ6NVcpY+MPRwF9k
   wYaZMVJIag0JvSJAiWF9NjbX8AefW3t5VetqEfSTeeEG9r4FeW/NG95XM
   ULdRZcZgdaDgW35LfXJuBt/MrFLGDAf0RiJHHFNL+MX2ZNhVPpxygJdQ3
   iSwHd7ox3dVKSUdKwJ9+JPTub2NByB2Zu1Gz4TYrpRz7zWr2IWy+T47P6
   g==;
X-CSE-ConnectionGUID: CYfZzpiITgW4BgpGhf24bw==
X-CSE-MsgGUID: quzStg/eQH6Bp2WiXnq0/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9787163"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9787163"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:03:06 -0700
X-CSE-ConnectionGUID: e0o/VpuZQaeWZc6Nd3Pjsw==
X-CSE-MsgGUID: ISuVIbRnTHCF0MvS+8y3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25516139"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.176.246])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:03:05 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 0/2] efi/cxl-cper: Report CXL CPER events through
 tracing
Date: Fri, 26 Apr 2024 13:02:58 -0700
Message-Id: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHIILGYC/02MywqDMBBFf0Wybkqc8b3qf5Qu7GRSA1YlkWAR/
 71RKHV5LvecVXh2lr1oklU4DtbbcYiAl0RQ1w4vllZHFqAgUwBK0tJLmtihRMV5DmVtaixE/E+
 OjV2O1v0RubN+Ht3nSId0X3+V6lQJqVSyaFs0KWZIBd3sMHN/pfEt9kqAv5kBnE2IZk5aY1kZ0
 up5Nrdt+wKk1Vs23AAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714161785; l=2068;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Mq+HIvBiRfXqX7bq1lJIJQ9QW1/+6x26EYOzLbZxohA=;
 b=nlX+XmIEYn5bLLKXFjPw8b3YJxtR6DsOTI4QuOaR0qOT43FN3rMoeQBeS4iIo0TpQYm2wnkdk
 NTyTlzZOQjNCd459/a59z2OeeC2prP/oy11j6lJj4JxatErN1T1Azyb
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

Series status/background
========================

Smita and Jonathan have been a great help with this series.  Once again
thank you.

Unfortunately, with all the churn surrounding the bug which Dan
Carpenter found the maintainers were force to revert this work.

Testing
=======

Continue to use my quick hack in debugfs to facilitate easier testing.[1]

[0]
Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
[1]
Link: https://github.com/weiny2/linux-kernel/commit/9b1f33314e8488506dbad63dc1c896386d4803d6

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v3:
- djbw: drop patch which traces errors if CXL is not loaded
- djbw: Let CXL layer declare work struct.  Leave kfifo management in
  GHES layer
- Link to v2: https://lore.kernel.org/r/20240422-cxl-cper3-v2-0-5cdd378fcd0b@intel.com

---
Ira Weiny (2):
      acpi/ghes: Process CXL Component Events
      cxl/pci: Process CPER events

 drivers/acpi/apei/ghes.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c         |  71 +++++++++++++++++++++++++++++-
 include/linux/cxl-event.h |  27 ++++++++++++
 3 files changed, 207 insertions(+), 1 deletion(-)
---
base-commit: e33c4963bf536900f917fb65a687724d5539bc21
change-id: 20240220-cxl-cper3-30e55279f936

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


