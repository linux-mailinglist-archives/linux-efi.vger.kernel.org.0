Return-Path: <linux-efi+bounces-226-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A781546B
	for <lists+linux-efi@lfdr.de>; Sat, 16 Dec 2023 00:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568811F23F28
	for <lists+linux-efi@lfdr.de>; Fri, 15 Dec 2023 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99618ED0;
	Fri, 15 Dec 2023 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URYmGtaX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8018034;
	Fri, 15 Dec 2023 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682789; x=1734218789;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=3xKqnFB4W5k8UZ3XimdoyygtjqnO8wYj5wwpupdnA+M=;
  b=URYmGtaXwZaY3/0t6rJ6R6Bnw5M4RIIlP3iml42eb/F+oQopzGIWVzIF
   41H1zxQJMX+enrP974OQy6DkQomS1cODC0mMrQiCQJnJ/cnDl8ILlVMsA
   koJkKJtmmxYGvCLGkci5rUeNzv9faQtczaO/CeAWX/fLgAVStDzU6uu3T
   /lGBkQ2lnOUDIfA2NO8LxIQWViXPTcMGXsc02Gj4W6M5xJMYj+zTyoGO7
   /BKHHA0fAu4SEyIxih4ActhF5lar5uYbwQkQvCPp2N8r2L/UA30fRRtPI
   xYe4lW7Mv34JZykGCqWNjiTOY3G8Fht3HhUKqatQWUw3rz30f+SmiUVMF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395079624"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="395079624"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="724605076"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="724605076"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.164.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:27 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v4 0/7] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date: Fri, 15 Dec 2023 15:26:26 -0800
Message-Id: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLgfGUC/3XNwW7DIAyA4VepOI/JBkJgp73HtAMYWJDapIIo6
 lTl3Ud6qrLmaPDv785qLDlW9nG6sxKXXPM0tkG9nRgNbvyJPIc2MwFCggbkdDtzusbChU6JjLS
 kSbO27l2N3Bc30rAFF1fnWLaPa4kp3x7G13ebh1znqfw+yAW31xfXF+TArfVOyWRS38NnHud4f
 qfpst08CALahI7QOK+fgk1dxJEkWihRBUtSOw/iv4QC9wEhagvgne7MXpJHkmwhoLFBY+ptp19
 Kchf0KRgtQ4Agur2kjiTVQtV7bwETyi4+h+u6/gGuWzUM9wEAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702682786; l=3579;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=3xKqnFB4W5k8UZ3XimdoyygtjqnO8wYj5wwpupdnA+M=;
 b=JuXfQqh3TbymZ5dI72fAeYajBa6O+cQ8wS+BQBvK0bfTSQMyVEZJLgox4gdRFGI7LdlYilUPn
 moSFGUgr9UoC16WOjS1mfjVA8PL8q4xCH6roQ6Eglfae7hkqwA/FvsC
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Series status/background
========================

Smita has been a great help with this series.

Dan had a better idea for how to register the call between the efi and
cxl subsystems so this is reworked for V2-4.

Dependencies
============

NOTE this patch depends on Dan's addition of a device guard[1].
Therefore, the base commit is not a stable commit.  I've pushed a branch
with this commit included for testing if folks are interested.[2]

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
[2] https://github.com/weiny2/linux-kernel/tree/cxl-cper-2023-12-15

Cover letter
============

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI Common Platform Error Record (CPER)
record.  If a device is configured for firmware first CXL event records
are not sent directly to the host.

The CXL sub-system uniquely has DPA to HPA translation information.  It
also already has event format tracing.  Restructure the code to make
sharing the data between CPER/event logs most efficient.  Then send the
CXL CPER records to the CXL sub-system for processing.

With event logs the events interrupt the driver directly.  In the EFI
case events are wrapped with device information which allows the CXL
subsystem to identify the PCI device.

Previous version considered matching the memdev differently.  However,
the most robust was to find the PCI device via Bus, Device, Function and
use the PCI device to find the driver data.

CPER records are identified with GUID's while CXL event logs contain
UUID's.  The UUID is reported for all events.  While the UUID is
redundant for the known events the UUID's are already used by rasdaemon.
To keep compatibility UUIDs are injected for CPER records based on the
record type.

In addition this series cleans up the UUID defines used between the
event processing and cxl_test code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v4:
- lkp: Fix 0day build issues
       [Functionally the same as v3]
- Link to v3: https://lore.kernel.org/r/20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com

Changes in v3:
- djbw: use scope based cleanup functions
- iweiny: further clean ups
- Link to v2: https://lore.kernel.org/r/20231211-cxl-cper-v2-0-c116900ba658@intel.com

---
Ira Weiny (7):
      cxl/trace: Pass uuid explicitly to event traces
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Create common event UUID defines
      cxl/events: Separate UUID from event structures
      cxl/events: Create a CXL event union
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         |  93 +++++++++++------------
 drivers/cxl/core/trace.h        |  30 ++++----
 drivers/cxl/cxlmem.h            | 110 ++++++---------------------
 drivers/cxl/pci.c               |  55 +++++++++++++-
 drivers/firmware/efi/cper.c     |  15 ++++
 drivers/firmware/efi/cper_cxl.c |  46 ++++++++++++
 drivers/firmware/efi/cper_cxl.h |  29 +++++++
 include/linux/cxl-event.h       | 161 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h             |   2 +
 tools/testing/cxl/test/mem.c    | 163 +++++++++++++++++++++++-----------------
 10 files changed, 484 insertions(+), 220 deletions(-)
---
base-commit: 6436863dfabce0d7ac416c8dc661fd513b967d39
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


