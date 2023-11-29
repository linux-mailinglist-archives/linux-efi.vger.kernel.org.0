Return-Path: <linux-efi+bounces-98-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88477FDEFC
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91141C20A54
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4075B5A8;
	Wed, 29 Nov 2023 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivUyYVOK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECA90;
	Wed, 29 Nov 2023 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280848; x=1732816848;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=o8Db8liVmIHRdeM+5hCUQllrxeYOIsuUtygP4rZCS0k=;
  b=ivUyYVOK0SzKZvBprryD3V8+MzBT36tLoVuKOCMoZiAkXFEDAqogDUcE
   5ZM/adanMA0z1uYOmwQMuyaAQGJ55AjU0/5fXOR2fnnn6qJM6fNo3LoqQ
   4cIhez/tNh53rKXcicsSIBkvwpb4gaHAmouekHcNN7aiY/AUZyZ2qOojM
   pdoqgzktY+xD09G2kazIxa6F5cEBCna3hRwuE4UovvwCkJc4TF2NRBFx3
   Q+tfWLgSrror1poPCuGXg6lnfrBYbwuCYXeQfv/UDtcSg+veCUvu0mkQ7
   Zj0GKKPhSuCHxGFfJl6PiTm6NLV7ZHS8xDradr3mKALyVgIWYT4K5n1yC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="457524454"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="457524454"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="835096088"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="835096088"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.127.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:00:47 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/6] efi/cxl-cper: Report CPER CXL component events through
 trace events
Date: Wed, 29 Nov 2023 10:00:40 -0800
Message-Id: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEh8Z2UC/3XNwQ7CIAwG4FcxnMVQQDY8+R7GA3TFkehmYFk0y
 95dtpMx7vi3/fpPLFOKlNlpN7FEY8yx70qA/Y5h67ob8diUzKSQShgBHF93jk9KXJoQsFYWDRp
 Wzr3LxH1yHbYLeLg8UFoWz0QhvtaOy7XkNuahT++1coRl+uf7CFxwa73TKtShqsQ5dgPdD9g/2
 PJklFtQFqhANxaVcV7IX6i2oCpQQG0bA6GyR/ML9RbUBerKeysggDrSN5zn+QPOq80lZAEAAA=
 =
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701280847; l=2858;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=o8Db8liVmIHRdeM+5hCUQllrxeYOIsuUtygP4rZCS0k=;
 b=nVI1Spi5q3bjD7WM7Z73eDy8dLzwKcTFPYLnS378pMwWKsaf3ZJvQ4cJ5b4lgpmWktsObnxY2
 5c4Z4KbBtuLDlVz2L1qr7RuXYf8Ndlwh5TzpNIAm4pYDknzMxhFh5V+
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Series status/background
========================

Smita has been a great help with this series.  This includes testing the
last RFC version enough that I feel confident to make this a V1 with the
change suggested.[1]

[1] https://lore.kernel.org/all/7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com/

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
case events are wrapped with device information which needs to be
matched with memdev devices.  A number of alternatives were considered
to match the memdev with the CPER record.  The most robust was to find
the PCI device via Bus, Device, Function and match it to the memdev
driver data.

CPER records are identified with GUID's while CXL event logs contain
UUID's.  The UUID is reported for all events.  While the UUID is
redundant for the known events the UUID's are already used by rasdaemon.
To keep compatibility UUIDs are injected for CPER records based on the
record type.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes from RFC:
- iweiny: remove RFC
- Smita: Use pragma pack for the entire cper structure
- Link to v4: https://lore.kernel.org/r/20230601-cxl-cper-v4-0-47bb901f135e@intel.com

---
Ira Weiny (6):
      cxl/trace: Pass uuid explicitly to event traces
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Separate UUID from event structures
      cxl/events: Create a CXL event union
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         |  65 ++++++++++------
 drivers/cxl/core/trace.h        |  34 ++++----
 drivers/cxl/cxlmem.h            |  96 ++---------------------
 drivers/cxl/pci.c               |  58 +++++++++++++-
 drivers/firmware/efi/cper.c     |  15 ++++
 drivers/firmware/efi/cper_cxl.c |  40 ++++++++++
 drivers/firmware/efi/cper_cxl.h |  29 +++++++
 include/linux/cxl-event.h       | 164 +++++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c    | 166 +++++++++++++++++++++++-----------------
 9 files changed, 465 insertions(+), 202 deletions(-)
---
base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


