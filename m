Return-Path: <linux-efi+bounces-208-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5881246D
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE2F2826A8
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B0645;
	Thu, 14 Dec 2023 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrxmeFkJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5AEE4;
	Wed, 13 Dec 2023 17:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702516808; x=1734052808;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=jkhkSIcuf1Rh0FZaXrLk5FqBQVZsP56o/PlqsqoxTpo=;
  b=VrxmeFkJyKezIoNRqg2RMqL7EGNxsHDceTYLgiVcq+01msBvqmioRD3n
   Vg6p7/3rGTxQIrJ70kJQ0ifbJLmBzqZfwckWdZv1Nyuq4EHeRkUftIdOb
   1OOQGLM3livGsdtB6uxWw0RPUVxy5wvqRxh4AXqfEuJbEstcnrMjQEV1/
   N8bimCArRsu8Ad/INlcumHsrGL3f0B3PuasJ4dJDjE262TXXe7kPL/t03
   MDPou0n/PeF/imvS8MC3CNw+cpMVE9swkXcbPZnOr6jSy7fkI/3r1Ypjs
   hJ5+r/t+ylAkTW67usThAT+twz85T4FJkF/P/KiyWHkUumxzQ9ijEJdtP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13747607"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="13747607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767436284"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767436284"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.117.241])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:20:07 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 0/7] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date: Wed, 13 Dec 2023 17:19:53 -0800
Message-Id: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpYemUC/3WOQW7DIBBFrxKxLtUMYAxd9R5VFjCGGimxI7CsV
 JHvHsgqSurln5n339xYCTmFwr4ON5bDmkqapxrkx4HR6KbfwNNQMxMgJGhATtcTp0vIXOgYyUh
 LmjSr596VwH12E40NOLuyhNwWlxxiuj4cP8eax1SWOf89lCu26T/tK3Lg1nqnZDSx7+E7TUs4f
 dJ8bp07wIA2oiM0zusnoFlXsWcSFZSoBktSOw/i3YQCXwFC1BbAO92ZV5PcM8kKAho7aIy97d5
 eVHugqqDqvbeAEWUXnsFt2+46RIDPxgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702516806; l=3547;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=jkhkSIcuf1Rh0FZaXrLk5FqBQVZsP56o/PlqsqoxTpo=;
 b=79Jt7JQ3ypzKV5TWGucLhSYu+73NPyBXoPIjoyI1OETiMRLtaFtWRoyiYQEngbU4ITEvGUsHK
 upgmIoVcikGBZYowOoMoF0V/UnrMPucSCs+PY5gatNv1SqAlmqiRYZZ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Series status/background
========================

Smita has been a great help with this series.  This includes testing the
last RFC version.[1]

Unfortunately, Dan had a better idea for how to register the call
between the efi and cxl subsystems so this is reworked for V2.

[1] https://lore.kernel.org/all/7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com/

Dependencies
============

NOTE this patch depends on Dan's addition of a device guard[1].
Therefore, the base commit is not a stable commit.  I've pushed a branch
with this commit included for testing if folks are interested.[2]

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
[2] https://github.com/weiny2/linux-kernel/tree/cxl-cper-2023-12-13

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
 include/linux/cxl-event.h       | 154 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h             |   2 +
 tools/testing/cxl/test/mem.c    | 163 +++++++++++++++++++++++-----------------
 10 files changed, 477 insertions(+), 220 deletions(-)
---
base-commit: 6436863dfabce0d7ac416c8dc661fd513b967d39
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


