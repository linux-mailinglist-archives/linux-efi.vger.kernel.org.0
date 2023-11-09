Return-Path: <linux-efi+bounces-10-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A188A7E7428
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5625628114E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Nov 2023 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0F38FA7;
	Thu,  9 Nov 2023 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgS5+1gx"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89338F9A;
	Thu,  9 Nov 2023 22:07:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02BB386A;
	Thu,  9 Nov 2023 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699567640; x=1731103640;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=vFDM721BmWzXCAqHdUJ+uv7GGpaz4QADTyvOIolr30k=;
  b=NgS5+1gx44kDB+l+TKQFsT2J6v34kjb21H7C0XbvDs5ywsA9+GK+grtr
   RNNyocj6kduZU2ETbtwm9UWsPQ9nj2r5vuu5FApjRuzRnEsZClG3wzfTX
   uASmJz1KeNYERH2jNsp/w5kZAmNyX79SkDeJZg69FWL9SIczvPmq75js0
   dP5cfR4zYOvm79f1PP9fErQnfyyxpNo495pwwkfILvLWS0M0Z+DQDZAPK
   WEEM6x6jNT0en4rry51+ejIHoANJfODSV7aFsRYNoyoabc97UIWNJKJW4
   LiVr1FaQoSMI/qmq6mnCZVX21wimkM4Odwracyc3y7y78zIZmgAqoWqfm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375124156"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="375124156"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713453293"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713453293"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.16.95])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:07:18 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC v4 0/6] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date: Thu, 09 Nov 2023 14:07:13 -0800
Message-Id: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJYTWUC/3XNywrCMBAF0F8pWRvJo6aNK0HwA9yKi3Q6sYG+S
 EqplP67aVeidHln5sydSUDvMJBzMhOPowuua2NIDwmByrQvpK6MmQgmJFOMU5hqCj16KpS1kEs
 NChSJ54UJSAtvWqhW0JgwoF8XvUfrpq3jQe63K3nGYeXC0Pn31jvybfVfMXLKqNaFSaXNbZaxi
 2sHrI/QNduTUexBEaHkaalBKlMw8QvlHpQRMp7rUnGb6ZP6hsuyfABtQIidMAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699567638; l=2895;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=vFDM721BmWzXCAqHdUJ+uv7GGpaz4QADTyvOIolr30k=;
 b=DzTHT08LnyJc6N7Hlb4DmGBrqHRVJx1508rCKWsyBphr3Ysg6NhjdOs+NycdlQJdgReQ4689i
 kn3JxBda30LAKb4/oaYqwo4kD79mJFvED3UbDIY3zplfZIRH9IxpcS5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Series status/background
========================

This RFC should be very close to done but I'm still working on getting a
system to test on.  Therefore, the CPER code remains compile tested
only.  The modified event log code continues to pass cxl-test.

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
Changes in v4:
- Jonathan/Shiju: Put UUID back in trace points.
- Smita: Fix packed structure
- Smita: use PCI_DEVFN() properly
- iweiny: update cover letter/commit messages
- Link to v3: https://lore.kernel.org/r/20230601-cxl-cper-v3-0-0189d61f7956@intel.com

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
 include/linux/cxl-event.h       | 160 ++++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c    | 166 +++++++++++++++++++++++-----------------
 9 files changed, 461 insertions(+), 202 deletions(-)
---
base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


