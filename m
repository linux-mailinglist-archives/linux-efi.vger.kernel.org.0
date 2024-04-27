Return-Path: <linux-efi+bounces-994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C758B43F3
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 05:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605272822A1
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 03:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC953BBF5;
	Sat, 27 Apr 2024 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUD8lGh1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204B2E40F;
	Sat, 27 Apr 2024 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714188846; cv=none; b=rlVUSd7d1KFi58G0qlYnZZBVYPBvfn1aeIlykuBra0hgXLrr2ch/uVo2XUj5vVjJY9AhsSgpz9Iwzaipa9TC2hiPrms1JSfoSVRBkCxxWDe7w31w/8Bbs9GPCOl4OHhkfMrdWHFt7cAO/h3bea9OIYXkaNLe3GLuG9BBx3qaczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714188846; c=relaxed/simple;
	bh=yJzWU1o+Vmb73FKY90QGQEz8T9t/sfLKnbH4RR3sjXc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cmxuiqvnth0NmxI4OTD3vFGoeIGl4wvqz3p/aBctuT5pD6xXchMkuU3FWbVB5opBEqPfU6ao2+TFMPUvOrodcrYxMStm2/mKEG+NwYeBYHfmhMIgEko20n1d2uMnz3/pFg71NtSpdFYFP+YdV2EqcMfIlxItASFnlnpSzeSMOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUD8lGh1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714188845; x=1745724845;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=yJzWU1o+Vmb73FKY90QGQEz8T9t/sfLKnbH4RR3sjXc=;
  b=QUD8lGh1kzRuMhBs9G7W63wNpPSJiLqrPFjT2Jb9mmbPwGjO7a/nLfoF
   FoSyVbSSa65GqLboe4eDTa8Lrp3r+ugkxBrhtoDOsatENS55fRGnwc6bU
   +Dba3PtD9doxcoIeVvJcJm3N62YbGffJEVQIoW8wt0xYuMDmSYHhILRr+
   yCgMANne4z7WiCQoCfU2mwd71SWzQcwJ8Iu3dCixN3wOibTtKtxPTmFbB
   wFtgj4BnLrvGUNMWjtpmYRToCmA9g5RNDbSneIbaSgmOaIMnMVRcoTVUG
   BTN9m9nglrnEPvfm4OVtgQFcALjcM7bhOfNTWsF/wa8ohc2mOGIafM8dr
   A==;
X-CSE-ConnectionGUID: E91+YY1MQem4kqJYPCNbWA==
X-CSE-MsgGUID: PhOnADFsRVCqPWMe8haiAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20620060"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="20620060"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:34:04 -0700
X-CSE-ConnectionGUID: NKF6R7GjTH26y6ylFvw4KA==
X-CSE-MsgGUID: MRy2CD0PQ2y0DYAGos2TBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25593985"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:34:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v4 0/2] efi/cxl-cper: Report CXL CPER events through
 tracing
Date: Fri, 26 Apr 2024 20:33:59 -0700
Message-Id: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChyLGYC/13NTQqDMBCG4atI1k2JM/Gvq96jdGEnkxqwKlHEI
 t69USgNXX5DnjerGNk7HsUlWYXn2Y2u78LQp0RQU3dPls6ELUCBVgBK0tJKGtijRMVZBkVlK8x
 FeD94tm45Wrd72I0bp96/j/Sc7tdvpYwqcyqVzOsabYoaKaer6yZuz9S/xF6Z4Sc1QCwhyIyMw
 aK0ZNTjX2Is81ji8afhwlgqdcWx3LbtA09qE0QWAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714188842; l=1952;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=yJzWU1o+Vmb73FKY90QGQEz8T9t/sfLKnbH4RR3sjXc=;
 b=fNPJwripoCGmVixNwjvc0tWirTSUobbH6rbpBnJaaWPYgzAmMO/D6ixQu5VQv4GfQQ4Ubqfll
 kfH5ccEJDOqBTzcthWCo3ozhXZAedod7QbPimL6a/ifCb9p540d9r1a
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

Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/ [0]
Link: https://github.com/weiny2/linux-kernel/commit/9b1f33314e8488506dbad63dc1c896386d4803d6 [1]

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v4:
- djbw: Use proper link format
- Link to v3: https://lore.kernel.org/r/20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com

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


