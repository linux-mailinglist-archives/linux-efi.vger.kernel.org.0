Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A973960C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfFGTmS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 15:42:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:36952 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbfFGTmS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 7 Jun 2019 15:42:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 12:42:17 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2019 12:42:17 -0700
Subject: [PATCH v3 09/10] acpi/numa/hmat: Register HMAT at device_initcall
 level
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-nvdimm@lists.01.org, x86@kernel.org,
        linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 12:28:01 -0700
Message-ID: <155993568120.3036719.6635543389090509374.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for registering device-dax instances for accessing EFI
specific-purpose memory, arrange for the HMAT registration to occur
later in the init process. Critically HMAT initialization needs to occur
after e820__reserve_resources_late() which is the point at which the
iomem resource tree is populated with "Application Reserved"
(IORES_DESC_APPLICATION_RESERVED). e820__reserve_resources_late()
happens at subsys_initcall time.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c220cb7b620..1d329c4af3bf 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -671,4 +671,4 @@ static __init int hmat_init(void)
 	acpi_put_table(tbl);
 	return 0;
 }
-subsys_initcall(hmat_init);
+device_initcall(hmat_init);

