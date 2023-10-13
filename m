Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735A7C7E33
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJMGzX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 02:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJMGzW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 02:55:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C60B7;
        Thu, 12 Oct 2023 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697180120; x=1728716120;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=u61Nkn59oFv60qAsEUE3QSod9li0eALta36qMzDsq10=;
  b=FEfAnbaJm+rzbbbu5TjKL0SmlLC6RFZQok/+3UF+P/emYUlTuZ2jKZ3k
   TZZTs6bjnLTx6fnemkTMbHuGv7QkBrWojX1uUpKOy3MycP0CYjqhPomY/
   Hsn+0750GW1tjTLAIUZNiY6hnWFyh3fNeaH0Z1wPyvh71+8KTlfsV7sdo
   KGdErARnvNd6tmo+l6VoCIyDR+c4spUK2oHFv0Ew2WyNYZYCorYJQbvwW
   6L3XsmPhPMEH8awSWEVowuZXlqtsdc9RkBlTf+bh6LYOM69fs7EQKgtPb
   O001eD0EI2i0ck5VyQ/RgbcwPmjG0JPUWtPydVBVrrJdNylBCg+bQ4AZs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451595995"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="451595995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704512895"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="704512895"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.55.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 23:55:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC 0/2] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date:   Thu, 12 Oct 2023 23:55:18 -0700
Message-Id: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbpKGUC/x2NQQqDQAxFryJZNzCOMNhuhR6g29LFGDM1UKeSl
 CKId3d0+fjv81YwVmGDW7WC8l9MvrlAfamAxpjfjDIUBu9844KrkZYP0syKPqREbXOlQAGK3kd
 j7DVmGo/DFO3HegyzcpLlbDzhce/gtW07f+BnKXgAAAA=
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
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697180119; l=1890;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=u61Nkn59oFv60qAsEUE3QSod9li0eALta36qMzDsq10=;
 b=RNhOerwSICvq/FQVLw0UrMuZLrYtT+LhqucGaZp8F8/YvkIcdZe1mGBDPbiOrWkGyRbiV30U+
 E6EnKxfFG9ACHnBTFAg7/A8U2yUWLcJac+AS8FGf1gfppotTpe/earI
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I know that Smita has taken the initiative[1] on this but I had a
skeleton of using notifiers to allow the CXL code to process the CPER
records via the standard tracing code like Dan mentioned.[2]

So here is a slightly polished version of that code.  This is compile
tested with only.  Smita, feel free to use this any way you see fit.

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI (Common Platform Error Record) CPER
record.  If a device is configured for firmware first these CPER event
records can be processed instead of reading the CXL Event logs directly
from the device.

A number of alternatives were considered to match the memdev with the
CPER record.  For now a simple comparison with the serial number is used
to match a CPER record with a specific device.  Other fields in the CPER
record could be used as well.

[1] https://lore.kernel.org/all/20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com/
[2] https://lore.kernel.org/all/6528808cef2ba_780ef294c5@dwillia2-xfh.jf.intel.com.notmuch/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (2):
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         |  7 +++--
 drivers/cxl/cxlmem.h            |  5 +++
 drivers/cxl/pci.c               | 70 ++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/efi/cper.c     | 16 ++++++++++
 drivers/firmware/efi/cper_cxl.c | 39 +++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 29 +++++++++++++++++
 include/linux/efi.h             | 49 +++++++++++++++++++++++++++++
 7 files changed, 211 insertions(+), 4 deletions(-)
---
base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

