Return-Path: <linux-efi+bounces-270-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F481ABA1
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488B21C21C17
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9319D;
	Thu, 21 Dec 2023 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix0cdLIp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F5370;
	Thu, 21 Dec 2023 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118281; x=1734654281;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=QzeXiqvA/RcvyC4x0SwVxlIEq7c/c29xjKXw4I1UKu4=;
  b=ix0cdLIpo3YhMsPrwTGe/sUikJ0SOXumbotXjdyT6F2TCvpn1QHNJAQ3
   o7m+9BqzdmZew+xuUGxX4/8uIp//H1cbc0xIJgTgTwqMgYbuyMyMHzhqo
   fmhiQxWto3EJTMSRbJ1EoBYSmzd9yAzkaMKpEkpM1lW+TB54c5g7avXBw
   wTSImBZw0qK0CdKFEswp31GNf7K4w3C0mH9nsfZUufiUM4hYjMVGAIN28
   iohDp9DYG9mxIQGKpiM/FJPzwu4MSmaEJf2lD/JyVMoBiuOBvN7pAmihC
   Tq/vLtlYZG4hmIsF1l55g8IZUGg1B0459gt7VQCksNFsI5i6gQtdVS+Wj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730042"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730042"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661604"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661604"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:37 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date: Wed, 20 Dec 2023 16:17:27 -0800
Message-Id: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeEg2UC/3XNS27DIBCA4atErEvF8BibrnqPqgsYoEFK7AgsK
 1XkuxdnFbn2cmD++R6sxpJjZR+nBytxzjWPQxvM24nR2Q0/kefQZiaFVAIFcLpfON1i4RJTol5
 ZQkLW1r2rkfviBjqvwdXVKZb141Ziyven8fXd5nOu01h+n+QM6+vO9Rm44NZ6p1XqU9eJzzxM8
 fJO43W9eRAEsAkcQe88vgSrOssjSbZQgQ6WFDov5H8JJGwDAkArhHdo+q2kjiTVQgG9DQipswZ
 3JbUJuhR6VCGIIM1W0keSbqHuvLcCEigTdyWzCQR4DM5rnSi8Ssuy/AH4mFYSKAIAAA==
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
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=3656;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=QzeXiqvA/RcvyC4x0SwVxlIEq7c/c29xjKXw4I1UKu4=;
 b=vMkwSiVffu+Am0wL3komMMO/XzimqrJwRo6xKY6gKVhu2XzhmRSUS2NDKlLseINxWLVRN5gBP
 OzHqVvI2XvRDGVriOOpedSLS2gS9Ub+ljvE6u5HItDIBvnRDRcPkzzS
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Series status/background
========================

Smita has been a great help with this series.  Thank you again!

Smita's testing found that the GHES code ended up printing the events
twice.  This version avoids the duplicate print by calling the callback
from the GHES code instead of the EFI code as suggested by Dan.

Dependencies
============

NOTE this series still depends on Dan's addition of a device guard[1].
Therefore, the base commit is not a stable commit.  I've pushed a branch
with this commit included for testing if folks are interested.[2]

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
[2] https://github.com/weiny2/linux-kernel/tree/cxl-cper-2023-12-20

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
UUID's.  The UUID is reported for all events no matter the source.
While the UUID is redundant for the known events the UUID's are already
used by rasdaemon.  To keep compatibility UUIDs are still reported.

In addition this series cleans up the UUID defines.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v5:
- Smita/djbw: trigger trace from ghes_do_proc()
- Jonathan: split out pci scoped based functions to it's own patch
- Jonathan: remove unneeded static uuid variables
- Smita/djbw: trace an unknown event type as a generic with null UUID
- Jonathan: code clean ups
- Link to v4: https://lore.kernel.org/r/20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com

---
Ira Weiny (9):
      cxl/trace: Pass uuid explicitly to event traces
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Create common event UUID defines
      cxl/events: Remove passing a UUID to known event traces
      cxl/events: Separate UUID from event structures
      cxl/events: Create a CXL event union
      acpi/ghes: Process CXL Component Events
      PCI: Define scoped based management functions
      cxl/pci: Register for and process CPER events

 drivers/acpi/apei/ghes.c     |  88 +++++++++++++++++++++++
 drivers/cxl/core/mbox.c      |  87 +++++++++++------------
 drivers/cxl/core/trace.h     |  14 ++--
 drivers/cxl/cxlmem.h         | 110 +++++++----------------------
 drivers/cxl/pci.c            |  58 ++++++++++++++-
 include/linux/cxl-event.h    | 162 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h          |   2 +
 tools/testing/cxl/test/mem.c | 163 ++++++++++++++++++++++++-------------------
 8 files changed, 476 insertions(+), 208 deletions(-)
---
base-commit: 6436863dfabce0d7ac416c8dc661fd513b967d39
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


