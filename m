Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF87DE741
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKAVLu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 17:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjKAVLu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 17:11:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E6110;
        Wed,  1 Nov 2023 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873104; x=1730409104;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Z3OBKKkRMMaSem4VSOoq00VvInmdMq8Rf23oYoVlUe8=;
  b=iNfHGEnc3B5S6YsVQi2a7Z+5AClieTa5g150ZmVSEnNo81xZQP/E751h
   RCUaWeECl+VXXbkDNhZia7p/lEnbj3ch1aQYZLS24DBkYlJELlzOfJI3p
   7mXMHChu1SPZUOFq6nrB2Ujm/qKIxI9rVLrqelcFjMJg1dudDMg7ERQp5
   qLN1VQk+VwDQdRaq5g/HNxovvhIrfYT/Q3hmT3e9UA27i2nkK9hBx0l7j
   poKJDOpnKZbwmt7DsI8cvpFQ1JnUsE7oeFhNFS8B/MVHL9w4MvOZNJfvU
   P44NMdzx+nO0s5oFaYHSNvRadhUfOF59/QAmdC/p1J9FFAZBbbCqS2wrI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373625196"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="373625196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737533779"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="737533779"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.80.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:11:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Nov 2023 14:11:18 -0700
Subject: [PATCH RFC v3 1/6] cxl/trace: Remove uuid from event trace known
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-cxl-cper-v3-1-0189d61f7956@intel.com>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
In-Reply-To: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698873100; l=2689;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=Z3OBKKkRMMaSem4VSOoq00VvInmdMq8Rf23oYoVlUe8=;
 b=W6rZ4NV3L6dkTs5n/OYwXjiE6wLnRRDRiDv0PclR75UyqaRoS0MJ0Kj5RlXD/UllnT+Es7BeS
 oNQ2N+Zgke9DjTLNWbFObg5RX55vmrwceHbLgMsvOnVtxxj0qLF0sNa
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

The uuid printed in the well known events is redundant.  The uuid
defines what the event was.

Remove the uuid from the known events and only report it in the generic
event as it remains informative there.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..79ed03637604 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -189,7 +189,6 @@ TRACE_EVENT(cxl_overflow,
 	__string(memdev, dev_name(&cxlmd->dev))			\
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
-	__field_struct(uuid_t, hdr_uuid)			\
 	__field(u64, serial)					\
 	__field(u32, hdr_flags)					\
 	__field(u16, hdr_handle)				\
@@ -203,7 +202,6 @@ TRACE_EVENT(cxl_overflow,
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
@@ -212,12 +210,12 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_maint_op_class = (hdr).maint_op_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
+	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu "		\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
 		"maint_op_class=%u : " fmt,					\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
-		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
+		__entry->hdr_timestamp, __entry->hdr_length,			\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
 		##__VA_ARGS__)
@@ -231,15 +229,17 @@ TRACE_EVENT(cxl_generic_event,
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
+		__field_struct(uuid_t, hdr_uuid)
 		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
 	),
 
 	TP_fast_assign(
 		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		memcpy(&__entry->hdr_uuid, &rec->hdr.id, sizeof(uuid_t));
 		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
 	),
 
-	CXL_EVT_TP_printk("%s",
+	CXL_EVT_TP_printk("uuid=%pUb %s", &__entry->hdr_uuid,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 

-- 
2.41.0

