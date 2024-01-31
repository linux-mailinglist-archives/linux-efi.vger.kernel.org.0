Return-Path: <linux-efi+bounces-442-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB1844D6C
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689FC1F23F10
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098743A8EF;
	Wed, 31 Jan 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCbzGFNd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0733A8DA;
	Wed, 31 Jan 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745342; cv=none; b=mB+XKaybHVtOQ4/BYZStCsGJRD3+j7m5iSrlqoeYOL0jkjPKj2EJ/hVKRUtR8VnT57HO17PLiCJ8DORFMuPrPiz49g6sqd7De0iBBycXXiG309ed4bPNKO59yXwQcT8Sw+zqxW9wnitij++vyDui6Xijnm4cjCYIB9dZ+XIcn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745342; c=relaxed/simple;
	bh=sug+HF2SZlcMgcQiYI0lGI7pFw+I4QHWJGILvxgqdmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KEyJLaThJl9nw1KHLnx1p8hBg+IX/xZ3B5nzAsOujBFEImtMwd+YDLXaL7kiMPqp5oof2gMARJ6pQqSQC4qd58AqBc27jdbR6cSTAs6FqVI3GHxpC6FvoNYvMw5MtsIQ87C2/nGKJT+8KQyY7787O7oY92xxaHrPSE8Pow3dmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCbzGFNd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706745341; x=1738281341;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sug+HF2SZlcMgcQiYI0lGI7pFw+I4QHWJGILvxgqdmU=;
  b=QCbzGFNdwriPK+byGFiGxOoNysKl2zvnPli5BfSEdNdodJ98424IOuXx
   XprGacW2OPa0YRt1U6iPYbfuzgqZHUc43fq78Sepdstopv0gj+m/kYaMp
   SovUABlJrv4vIA8yd2Rx6OIHCmOzM524hysE5YdpVIArguLa60EuF4yvy
   A73x3cxcN9PzDRcTgchLj0A8dEo91LUcqUJh006Ap+Qyq3QOrwpUJ9j7I
   B7Agli2y0AjtFWEq0E2ZXF9v3G9WYoKEMWN+SLM62E1CB7Zi9G4hzzG9H
   r5BYZM0l3xHbXn7wOjSCbIoJYn7Lpyup7RIyQm56/L1eoU1FgNa55e5G8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3597891"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3597891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822752084"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="822752084"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.174.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:38 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2] cxl/cper: Fixes for CXL CPER event processing
Date: Wed, 31 Jan 2024 15:55:37 -0800
Message-Id: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPndumUC/x2MWwqAIBAArxL73YIr0usq0UfpVgthohRCdPekz
 2GYeSBxFE4wVA9EviXJ6QtQXYHdZ78xiisMWmmjiAhtPtAGjrhKvkJCt6wNtb1iYzsoVYhczH8
 cp/f9ACQ1BYBhAAAA
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706745337; l=823;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=sug+HF2SZlcMgcQiYI0lGI7pFw+I4QHWJGILvxgqdmU=;
 b=IzAYM+GBUu17z3rvbh7NGNKya/6wYgjx3Mhhroy4oNiSr9VC8VNdHIeOAUfIylSxXsAjbngkh
 JncpSEOZITrBGc9RZCR8nmeMAWSf28uuqxYSUzhZSn+9gahQNTEENoX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

A couple of fixes for the new CXL CPER processing code.

The first is a real bug which should land in rc.  The second could wait
until the next merge window but it small enough it should be ok to land
in rc.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (2):
      cxl/cper: Fix errant CPER prints for CXL events
      cxl/trace: Remove unnecessary memcpy's

 drivers/acpi/apei/ghes.c    | 26 --------------------------
 drivers/cxl/core/trace.h    |  6 +++---
 drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
 include/linux/cper.h        | 23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+), 29 deletions(-)
---
base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
change-id: 20240111-cxl-cper-fixups-dbf61790e4c8

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


