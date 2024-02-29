Return-Path: <linux-efi+bounces-670-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6586C1AA
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 08:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992B91C2197D
	for <lists+linux-efi@lfdr.de>; Thu, 29 Feb 2024 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3E44C71;
	Thu, 29 Feb 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xko1Zge6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7891446B6;
	Thu, 29 Feb 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190805; cv=none; b=uyzU6SFgBPuStMc9ulH5wkfKpaoq/UzrA/YrNip/2dNsZZvkrpDSpCJ5w8MkaOZGYyxlxDd+3lpinj5Oc68asBaxCNpp1PDNBF7n6ED9cSlfg2POW/QurOvYe82g7WhnXM6SzII1TLL8d2B8P7YO8Lo/5iS/rWC+HqqGk0JJfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190805; c=relaxed/simple;
	bh=tyzJnjQ8r78M9dJ56ewIMb+ho6PqTtHsXYNzlsBHLqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5cNAp2DHnp8nhmN+peibbgtbN6GO07ZRwx5yNBTvXSc6h0vkA6+xKEdicX2GSUxen2xpcJeSO6DNzdns0ZKMmUTaGDm1K/3Ek6EzghoXgnc1VWgPaK+2SVy423KRxcANRtUGhWlppfd5hc8CBAmbZorenSIs8hWcuAb58hccTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xko1Zge6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190804; x=1740726804;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tyzJnjQ8r78M9dJ56ewIMb+ho6PqTtHsXYNzlsBHLqQ=;
  b=Xko1Zge6QMn1eDwWUsahfr82pB+yxChclDdeodAdEGyLoGjmItBKzXuD
   ztQJEWqSvCz627hyioQAQ3KYhqZDeS1L5NQ+y8c23FOTplwamne6sm4Hc
   Om0SvZH1JSVUjHjyrvOFNI8eSTH10UTgNIDKrfSI+ZK11i3Bp0VloBX12
   PEmSxcQi5P6r9quriHfTqs/qIiNL3jeJT49pz99MnUeGWuWtz1hYmDp8Q
   bC7kS+IGhNz23/8oNe1ClekEyuatQg2GqqNUI3uiGCQoiCPcKc3VsvQOx
   0I7JGtscs3KlW561IBEe++Z2lM+I/Gz4ifYPTt6UxFkyz1eGM6SL4Uzkj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3519853"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3519853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8283945"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.166.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:13:22 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 28 Feb 2024 23:13:16 -0800
Subject: [PATCH 1/4] cxl/event: Add missing include files
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-cxl-cper3-v1-1-6aa3f1343c6c@intel.com>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
In-Reply-To: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
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
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709190800; l=932;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=tyzJnjQ8r78M9dJ56ewIMb+ho6PqTtHsXYNzlsBHLqQ=;
 b=aVJn1c1YctwcOn+6/FjTVDtOQD+bGI+t0/QiVekrpKTZX4YnK16qBReM6jWtAab8dwuINloJs
 KuCLIe4VS7BCimoINRmT58TzbdnJ23ABGgWCYGNbqACI1H/+fAsCMXv
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Additional event testing using the cxl-event.h header revealed that it
did not include the correct headers for the types used.  Compile errors
such as:

	include/linux/cxl-event.h|11 col 9| error: unknown type name ‘u8’

... were seen.

Add the correct pre-requisite headers.

Omit the fixes tag because this does not cause any issues until the
header is used again in other code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/cxl-event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..812ed16ffc2f 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -3,6 +3,9 @@
 #ifndef _LINUX_CXL_EVENT_H
 #define _LINUX_CXL_EVENT_H
 
+#include <linux/types.h>
+#include <linux/uuid.h>
+
 /*
  * Common Event Record Format
  * CXL rev 3.0 section 8.2.9.2.1; Table 8-42

-- 
2.43.0


