Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03B7D8831
	for <lists+linux-efi@lfdr.de>; Thu, 26 Oct 2023 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjJZSWQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjJZSWQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 14:22:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C39192;
        Thu, 26 Oct 2023 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698344534; x=1729880534;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=cYIxkR82XJN7QwgqI+OKwTqx/44GZ0qbMpYYJhx2f0k=;
  b=QnBIt7bmSZVy4HsKubEwvHmbQvNNAaZIH1J8NSltswB4BLGsvX35ILon
   KNAbWELeUwZk0gE3Zzg3MPWTctBFxUfNxCI5hh85yDOa5bXDNhi+qbKNq
   umjq6hLLrdwGJQjGKIdKUC4S/wgoXtbIh5Ga2In5Pge414cW6WVtwhDyd
   jmRYIpGtnAac/lWTaZBetwzPfriJ0aApg3eHsy/1LZYeCTDyHLlyyvEP/
   QqLUUKy3LBw+t07ZIWGz0S4CxDgEyMIATzJaVz45wgsSDQZIMucBF4irr
   AZVP5G2G2n8bYj0fHlEyuMsWhItgbdEIlPh2VZ8hNbvMV4KYTXnO2WzXU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418733766"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="418733766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825087494"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="825087494"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.121.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:21:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC v2 0/3] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date:   Thu, 26 Oct 2023 11:21:37 -0700
Message-Id: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGuOmUC/2WNTQqDMBBGryKzbkqMJWpXhUIP0G1xEaeTOqBRk
 iAW8e6Nbrt83w9vhUCeKcA1W8HTzIFHl0CdMsDOuA8JficGJVUhtcwFLr3AibxQ2lqsiho1akj
 z1gQSrTcOu/0wmBDJ78XkyfJyOF7wfNyhSWHHIY7+e3jn/Kj+FXMupKjr1lwKW9mylDd2kfozj
 gM027b9AFG98ky+AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698344500; l=2842;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=cYIxkR82XJN7QwgqI+OKwTqx/44GZ0qbMpYYJhx2f0k=;
 b=7s8SBu/QCI7hecIDsrUe8LMAN6XHfjY8UjXGzODOwwEV327s8tzPiyPjmOufnZe6EodIcttB9
 XVe0rrsDjivCZUnvC5CiRqAnqGaBqx1iOv8LqnggOV4nQJgNOUderDX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Series status/background
========================

This is another RFC version of processing the CXL CPER records through
the CXL trace mechanisms as Dan mentioned in [1].

I moved forward with eliminating the GUID to UUID conversion I mentioned
in the original RFC thread[2].  Instead a new event type is used once
the GUID or UUID's is used to decode the event.

This remains compile tested with only.

[1] https://lore.kernel.org/all/6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch/
[2] https://lore.kernel.org/all/652f45e29915c_2bb07d2949b@iweiny-mobl.notmuch/

Cover letter
============

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI Common Platform Error Record (CPER)
record.  If a device is configured for firmware first CXL event records
are not sent directly to the host.

The CXL sub-system uniquely has DPA to HPA translation information.  It
also already properly decodes the event record format.  Send the CXL
CPER records to the CXL sub-system for processing.

With CXL event logs the device interrupts the host with events.  In the
EFI case events are wrapped with device information which needs to be
matched with memdev devices the CXL driver is tracking.

A number of alternatives were considered to match the memdev with the
CPER record.  The most straight forward comparison is via serial number.

CPER records are identified with GUID's while CXL event logs contain
UUID's.  The UUID was previously printed for all events.  But the UUID
is redundant information which presents unnecessary complexity when
processing CPER data.  Remove the UUIDs from known events.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in RFC v2:
- iweiny: remove uuid from existing known event traces
- iweiny: pass an enum for the event type.
- Link to v1: https://lore.kernel.org/r/20230601-cxl-cper-v1-0-99ba43f8f770@intel.com

---
Ira Weiny (3):
      cxl/trace: Remove uuid from event trace known events
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         | 45 +++++++++++++++++++++------
 drivers/cxl/core/trace.h        | 10 +++---
 drivers/cxl/cxlmem.h            |  7 +++++
 drivers/cxl/pci.c               | 69 ++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/efi/cper.c     | 16 ++++++++++
 drivers/firmware/efi/cper_cxl.c | 40 ++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 +++++++++++++++++
 include/linux/efi.h             | 59 +++++++++++++++++++++++++++++++++++
 8 files changed, 259 insertions(+), 16 deletions(-)
---
base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

