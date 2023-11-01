Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9E7DE73F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 22:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjKAVLs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjKAVLs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 17:11:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778209F;
        Wed,  1 Nov 2023 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873102; x=1730409102;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=d2+i1aESa6COj7u5uFub21JO1xpdrNwNXm/jrZkkmng=;
  b=GRHYv8/LjUp+VQ/dSHcixhkrlcX2a5+iP73dW6NFIoGakyu8sijzwf5W
   Z/Q9/h33eNbMeHJaz1i5RbfVv45YzS0tn9EGmJ7cHlFq6p+kpNIgwbhJ4
   w+S742pQ4aFxM8n1RwLGX1T5vj9TG4tNsNXwWS+CeYWom2+c8Ry4uiCxV
   Z54qVAWYHigskSQ93ATv5j9Ne9WG/FkSK+4RAPeGcdEGr1Ay1978eIAQl
   +9dZFCiFwJutKMOKST/sfezNlpmbFstyJeqcw53EipBklk4bz6kns1yyc
   eoH5tgttDNsMGr8anpDKtgGFGRqRvY2u8sDY3HQyd4AQ7kOpAXbS75TF8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373625186"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="373625186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737533772"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="737533772"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.80.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC v3 0/6] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date:   Wed, 01 Nov 2023 14:11:17 -0700
Message-Id: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPW+QmUC/3WNQQqDMBBFryJZNyUmErWrQqEH6LZ0kUwnNaBRE
 gkW8e6NWRVKl3/+f/NWEtBbDORUrMRjtMGOLgVxKAh0yr2Q2mfKhDMumGQlhaWnMKGnXBoDjWh
 BgiRprlVAqr1y0O3AoMKMfi8mj8Yu2XEnt+uFPNKxs2Ee/Tt7Y5mrX0UsKaNtq1UlTGPqmp2tm
 7E/wjjkJ5H/A3kCRVk9WxBSaca/wW3bPmhVpEn3AAAA
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698873100; l=3362;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=d2+i1aESa6COj7u5uFub21JO1xpdrNwNXm/jrZkkmng=;
 b=rzqLHTKj8l8LskzladGW4ILV2msefey0gyrj0oGgqJRfp9x20ssJ5MRDNw/vBaI2nlJB+d4h2
 TYHVYbsOzfeD6e7Nb5eryr9Brnm0JGHZlKmL+J6YrDcyOfg72PXOvC8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Series status/background
========================

This is another RFC version of processing the CXL CPER records through
the CXL trace mechanisms as Dan mentioned in [1].

This raises the cxl event structures to a core header and rearranges them
such that they can be shared most efficiently.  Thus eliminating a
memcpy Smita noticed.  Also BDF is used instead of serial number.

NOTE: I'm still fuzzy on which fields in the CPER record are correct to
find the BDF in the Linux code.  It would be nice to double check those
for me.

The CPER code remains compile tested only.  The original event code
continues to pass cxl-test.

[1] https://lore.kernel.org/all/6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch/

Cover letter
============

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI Common Platform Error Record (CPER)
record.  If a device is configured for firmware first CXL event records
are not sent directly to the host.

The CXL sub-system uniquely has DPA to HPA translation information.  It
also already properly decodes the event format.  Send the CXL CPER
records to the CXL sub-system for processing.

With CXL event logs the device interrupts the host with events.  In the
EFI case events are wrapped with device information which needs to be
matched with memdev devices the CXL driver is tracking.

A number of alternatives were considered to match the memdev with the
CPER record.  The most robust was to find the PCI device via Bus,
Device, Function and match it to the memdev driver data.

CPER records are identified with GUID's while CXL event logs contain
UUID's.  The UUID was previously printed for all events.  But the UUID
is redundant information which presents unnecessary complexity when
processing CPER data.  Remove the UUIDs from known events.  Restructure
the code to make sharing the data between CPER/event logs most
efficient.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in RFC v3:
- djbw: Share structures between CPER/event logs
- Smita: use BDF to resolve the memdev
- djbw/Smita: various cleanups
- Link to v2: https://lore.kernel.org/r/20230601-cxl-cper-v2-0-314d9c36ab02@intel.com

---
Ira Weiny (6):
      cxl/trace: Remove uuid from event trace known events
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Remove UUID from non-generic event structures
      cxl/events: Create a CXL event union
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         |  57 +++++++++-----
 drivers/cxl/core/trace.h        |  18 ++---
 drivers/cxl/cxlmem.h            |  96 ++---------------------
 drivers/cxl/pci.c               |  59 +++++++++++++-
 drivers/firmware/efi/cper.c     |  15 ++++
 drivers/firmware/efi/cper_cxl.c |  40 ++++++++++
 drivers/firmware/efi/cper_cxl.h |  29 +++++++
 include/linux/cxl-event.h       | 160 ++++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c    | 166 +++++++++++++++++++++++-----------------
 9 files changed, 451 insertions(+), 189 deletions(-)
---
base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

