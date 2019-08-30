Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E31A2CA4
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2019 04:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfH3CHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Aug 2019 22:07:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:37590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfH3CHZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 29 Aug 2019 22:07:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="381856349"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:07:23 -0700
Subject: [PATCH v5 09/10] acpi/numa/hmat: Register HMAT at device_initcall
 level
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de, rafael.j.wysocki@intel.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org
Date:   Thu, 29 Aug 2019 18:53:05 -0700
Message-ID: <156712998584.1616117.13919866316173530436.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8f9a28a870b0..4707eb9dd07b 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -748,4 +748,4 @@ static __init int hmat_init(void)
 	acpi_put_table(tbl);
 	return 0;
 }
-subsys_initcall(hmat_init);
+device_initcall(hmat_init);

