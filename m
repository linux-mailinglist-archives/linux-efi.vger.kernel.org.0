Return-Path: <linux-efi+bounces-669-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D41E86C1A9
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2677CB242D3
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59E446BA;
	Thu, 29 Feb 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiXLkR9C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB854446B4;
	Thu, 29 Feb 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190805; cv=none; b=Hd/dMr62089ajA/tZEfDC6xHXnsutdUWcw9JB2mu/aiI1HGUneuXdiV9DVx7ZdJ0XBJVVbgA/B3m1fIOn5761T/adcv2TTmpwXwXG5NF7o2mh9GewlwpeKjRgQvbXIGgMrVzSGuh7gCOgP5LagG8WFyiiF1IqC0adc4jWk7ZLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190805; c=relaxed/simple;
	bh=G2TxGFUdAAXJKdIfxQBleGyn2fBf9uj4lSj2hBlEcmE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ummvUjBVgKEGZID0/BLDaVrPqkoAjbxbrRZZ/S7K63D+5+qQJUgeLHsh4zTZUpBRgsizkt36VEvkmTgPfIM9IdnkWOvtkHzo3a/il8DC2+pyG2h5jD6ZsRXbQ0+wXeMfbHsbAAPMhndgvI3Wsamg+sXY8lYdqleAbXtYO6KZhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiXLkR9C; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190803; x=1740726803;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=G2TxGFUdAAXJKdIfxQBleGyn2fBf9uj4lSj2hBlEcmE=;
  b=UiXLkR9Cp4hO1eXJyqVSuXXFP1C0yilwDUhquHfzLVlas54+ScZF/j5l
   9ts2XZcgDIdWZzz5xdYIOs/JF4GIQxlVb9y25EAuc7WQ83QiQTz57cmL2
   NWk2aN+81tnemZfaUSMxbiUjntXDnNZi55V7OQPgLg+KJuJoSzxLhrFT9
   gSzYRoP6LpyuJvqPF7cHZ2ndbjI808qsPJnoKs49nYx931k2ZXaneNOOh
   hetnYpvuOmRhgufF8LMPZyck4KsPzwgXjuoKOaWxNap/j/T9Imx0EwRA5
   LZE+33TFOlMrbUy9TClGtbFUFDziNW6ykovZUTU7a1c8B6mkvRK4tCebM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3519845"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3519845"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8283933"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.166.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:21 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/4] efi/cxl-cper: Report CXL CPER events through tracing
Date: Wed, 28 Feb 2024 23:13:15 -0800
Message-Id: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsu4GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyMD3eSKHN3kgtQiY11jg1RTUyNzyzRLYzMloPqCotS0zAqwWdGxtbU
 AOfAb71sAAAA=
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709190800; l=2474;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=G2TxGFUdAAXJKdIfxQBleGyn2fBf9uj4lSj2hBlEcmE=;
 b=XjOlXZKAEwpqnuJEnFKvUjGnxXZSncPqvFrkssW+feQFDHoP54pVx2E9WtzvCDJALiGBFE8fl
 DhElZ3pqyWGAepI8DDWySgAgDpUCNjPWul3jVRxN5I8o2xhN5ZsGVsf
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI Common Platform Error Record (CPER)
record.  If a device is configured for firmware first CXL event records
are not sent directly to the host.

The CXL sub-system uniquely has DPA to HPA translation information.  It
also already has event decoding/tracing.  Such translations are very
useful for users to determine which system issues may correspond to
specific hardware events.

The restructuring of the event data structures in 6.8 made sharing the
data between CPER/event logs more efficient.  Now re-wire the sending of
CPER records to the CXL sub-system.

In addition provide a default RAS event should the CXL module not be
loaded [ie callback not registered].

Series status/background
========================

Smita and Jonathan have been a great help with this series.  Once again
thank you.

Unfortunately, with all the churn surrounding the bug which Dan
Carpenter found the maintainers were force to revert this work.

Therefore, this is a whole new series based on what is in 6.8.

Testing
=======

I've hacked up a quick debugfs patch to facilitate easier testing.[1]

With this I have verified that the bug Dan Carpenter found is fixed.
However, the tp_printk bug Jonathan found remains.  The taking of the
device lock in the callback is required and the tp_printk issue is
unlikely to be fixed.  Fortunately, tp_printk is not widely used so it
is anticipated this will not be an issue.

No other locking issues were found with this test and locking debug
turned on.

[1] https://github.com/weiny2/linux-kernel/commit/6c540a23cb1194d67a9dcfefb702774a99afc3b1

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (4):
      cxl/event: Add missing include files
      acpi/ghes: Process CXL Component Events
      cxl/pci: Register for and process CPER events
      ras/events: Trace CXL CPER events even without the CXL stack loaded

 drivers/acpi/apei/ghes.c  | 130 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c         |  69 +++++++++++++++++++++++-
 include/linux/cxl-event.h |  21 ++++++++
 include/ras/ras_event.h   |  90 ++++++++++++++++++++++++++++++++
 4 files changed, 309 insertions(+), 1 deletion(-)
---
base-commit: daeacfa75d08954e1a5b71c36a8fbfcdd0b3fec9
change-id: 20240220-cxl-cper3-30e55279f936

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


