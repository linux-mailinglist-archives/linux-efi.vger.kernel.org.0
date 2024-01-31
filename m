Return-Path: <linux-efi+bounces-444-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D760F844D73
	for <lists+linux-efi@lfdr.de>; Thu,  1 Feb 2024 00:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C11F26C33
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C53B7A9;
	Wed, 31 Jan 2024 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnke1NOh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD83A8F6;
	Wed, 31 Jan 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745345; cv=none; b=IlUq0fDFnuHLVYnOFZmRB15ZXDo1AZxLj/essAH+p5SVsxeEXvGaXF1jdxMU78G0b6KdI9yFbD7CAt3d4uw8a9v6nF08RPzSpX4xXghmLEPIpRgZMheZ0WOASgCN/sYuEtI3+O28Qt64DY+Rut4jsfOT7Z4q1cuoifW3yuv4J6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745345; c=relaxed/simple;
	bh=jma4+rPiaW9wR5JtA9Pe7XnHL1MEBLBpNR+7EBnaMkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1Uxl2GTTqOMWUGd9NZPlzacND8Km++AhbzEfeGepnRG/XurG38+IvrXoYLc/+WwmPu1I4nAk0kNqa02pzFZqUesp8kqRgXyftuXB0dsQqY6bmVzBD0qI8xbK4rvGVD1v3ufjxfE+8/s8cnb1v3ZVFLHlDyFJAjoK0jR5zp9pCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnke1NOh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706745343; x=1738281343;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jma4+rPiaW9wR5JtA9Pe7XnHL1MEBLBpNR+7EBnaMkc=;
  b=mnke1NOhGib7ujA2s5vK+Y9AHT+gda7p55vJ3uVINXpGBBiwWQBildx+
   O3fDZrI1qEoaK0JiJKM1iMqDvfC0ZICWEOvPS9RNIHGwvrnt3Xt5HIVYf
   Qqp8DVyPMZQNOwTBVNs5lBX6QMOa+uto0WwT70MpwbZMukzcmZ0iCFxBk
   SOsBxueJAqs/Wx04boSvQ5bjR+B/ciZcSBncY/VJoTcc8AFYhRLNqKyBq
   h4FBrljyS/Az0ZiNbSwYzeL4LLGCrZC4clUeRqJDjUvzSC0srR67igXtJ
   z2fkmNUpEzweEsdXEoN9KQWP8hWB+u3lbUuTjlw7adRXfUVawMOgb96J+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3597926"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3597926"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822752099"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="822752099"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.174.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 15:55:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 31 Jan 2024 15:55:39 -0800
Subject: [PATCH 2/2] cxl/trace: Remove unnecessary memcpy's
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-cxl-cper-fixups-v1-2-335c85b1d77b@intel.com>
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
In-Reply-To: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706745338; l=1726;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=jma4+rPiaW9wR5JtA9Pe7XnHL1MEBLBpNR+7EBnaMkc=;
 b=W6LLI0gVTXZoBGCHgHOW/XO2pYFZyyUiJ7Jqk4FL5Lai23kFFacC+HMr2Cf6RVfHYidxhJzuU
 qIdQ06cb+J5CWj2nkNte691OWsalY4SBIzewirtxsKEQsfZRK99xRC1
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

CPER events don't have UUIDs.  Therefore UUIDs were removed from the
records passed to trace events and replaced with hard coded values.

As pointed out by Jonathan, the new defines for the UUIDs present a more
efficient way to assign UUID in trace records.[1]

Replace memcpy's with the use of static data.

[1] https://lore.kernel.org/all/20240108132325.00000e9c@Huawei.com/

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 89445435303a..bdf117a33744 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -338,7 +338,7 @@ TRACE_EVENT(cxl_general_media,
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
-		memcpy(&__entry->hdr_uuid, &CXL_EVENT_GEN_MEDIA_UUID, sizeof(uuid_t));
+		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 
 		/* General Media */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -425,7 +425,7 @@ TRACE_EVENT(cxl_dram,
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
-		memcpy(&__entry->hdr_uuid, &CXL_EVENT_DRAM_UUID, sizeof(uuid_t));
+		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
 
 		/* DRAM */
 		__entry->dpa = le64_to_cpu(rec->phys_addr);
@@ -573,7 +573,7 @@ TRACE_EVENT(cxl_memory_module,
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
-		memcpy(&__entry->hdr_uuid, &CXL_EVENT_MEM_MODULE_UUID, sizeof(uuid_t));
+		__entry->hdr_uuid = CXL_EVENT_MEM_MODULE_UUID;
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;

-- 
2.43.0


