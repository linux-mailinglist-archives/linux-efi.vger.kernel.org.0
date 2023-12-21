Return-Path: <linux-efi+bounces-277-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24D81ABB1
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 01:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913751C22695
	for <lists+linux-efi@lfdr.de>; Thu, 21 Dec 2023 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D99467;
	Thu, 21 Dec 2023 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuqVsEUg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A83442B;
	Thu, 21 Dec 2023 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118287; x=1734654287;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RPmpaq8tUGGqY/AKMcuGmB+uL67p84i3x9/05w492V0=;
  b=nuqVsEUgiQVhmmDaqtvHAKplNgsid8+RitWk3oULJIU0QGWja+8koSuM
   rHqaTaMNGnw10PKaBZ90B3oGNP/S6JhiWRuma4h7ie2TGX1CzAokQYoJU
   LnWeRswYAYeHn4dH/RDNiaprmq33sXL1RRZxMUmXWFwoRxe5k/fTZxjWg
   tNGtX210cU62ubtn2NxRsF6TmxdK+6V2UcIAhN4wxjGorKbnWDwq4qGDC
   pxmOIl0x+2pt5Q8Ev+iuRpQ5+0Di/gRkSnc05VZ8ppe/KqeA0f3/JeaB/
   tCMvblbgyAQqz+L/juA7C9g19/zJVcraWvpEjK9kkxnrD/khvilMc8HIC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2730078"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2730078"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023661635"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1023661635"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.30.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:24:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 20 Dec 2023 16:17:35 -0800
Subject: [PATCH v5 8/9] PCI: Define scoped based management functions
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
In-Reply-To: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703118276; l=1564;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=RPmpaq8tUGGqY/AKMcuGmB+uL67p84i3x9/05w492V0=;
 b=Srja/FCUYTCW9Czcc53kQ249GiyaFeap2Dx4HNSKsRcceRnwHd19NKsiDzGBdP6ah2fKAWWwp
 cD3I3UFa4VXCyJmINC9tZygnrl0NIQ8ggPshYpZ5U/YB5fu4lbXKc51
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Users of pci_dev_get() can benefit from a scoped based put.  Also,
locking a PCI device is often done within a single scope.

Define a pci_dev_put() free function and a PCI device lock guard.  These
will initially be used in new CXL event processing code but is defined
in a separate patch for others to pickup and use/backport easier.

Cc: Bjorn Helgaas      <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v5:
[Jonathan: New patch]
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..290d0a2651b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
@@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),

-- 
2.43.0


