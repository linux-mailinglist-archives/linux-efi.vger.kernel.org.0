Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF8F9647
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKLQxr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 11:53:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfKLQxr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:47 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 987EC7319E5F574EC2EB;
        Wed, 13 Nov 2019 00:53:43 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 00:53:34 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 6/6] efi / ras: CCIX Agent internal error reporting
Date:   Wed, 13 Nov 2019 00:52:26 +0800
Message-ID: <20191112165226.106107-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112165226.106107-1-Jonathan.Cameron@huawei.com>
References: <20191112165226.106107-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CCIX 1.0 Base specification defines an internal agent error,
for which the specific data present afte the header is vendor
defined.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c         |  4 ++
 drivers/firmware/efi/cper-ccix.c | 43 +++++++++++++++++++++
 include/linux/cper.h             | 29 +++++++++++++++
 include/ras/ras_event.h          | 64 ++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 22df8c14ec13..5a75fb0374dd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -533,6 +533,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
 		trace_ccix_link_error_event(payload, err_seq, sev,
 					    ccix_link_err_ven_len_get(payload));
 		break;
+	case CCIX_AGENT_INTERNAL_ERROR:
+		trace_ccix_agent_error_event(payload, err_seq, sev,
+					     ccix_agent_err_ven_len_get(payload));
+		break;
 	default:
 		/* Unknown error type */
 		pr_info("CCIX error of unknown or vendor defined type\n");
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
index 03630f4abaab..250857146077 100644
--- a/drivers/firmware/efi/cper-ccix.c
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -586,6 +586,38 @@ static int cper_ccix_link_err_details(const char *pfx,
 	return 0;
 }
 
+static int cper_ccix_agent_err_details(const char *pfx,
+				       struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_agent_err *full_agent_err;
+	struct cper_sec_ccix_agent_err *agent_err;
+	u16 vendor_data_len;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*full_agent_err))
+		return -ENOSPC;
+
+	full_agent_err = acpi_hest_get_payload(gdata);
+
+	agent_err = &full_agent_err->agent_record;
+
+	if (agent_err->validation_bits & CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID) {
+		if (gdata->error_data_length < sizeof(*full_agent_err) + 4)
+			return -ENOSPC;
+
+		vendor_data_len = agent_err->vendor_data[0] & GENMASK(15, 0);
+		if (gdata->error_data_length <
+		    sizeof(*full_agent_err) + vendor_data_len)
+			return -ENOSPC;
+
+		for (i = 0; i < vendor_data_len/4 - 1; i++)
+			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
+			       agent_err->vendor_data[i + 1]);
+	}
+
+	return 0;
+}
+
 int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 {
 	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
@@ -655,6 +687,8 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 		return cper_ccix_port_err_details(pfx, gdata);
 	case CCIX_LINK_ERROR:
 		return cper_ccix_link_err_details(pfx, gdata);
+	case CCIX_AGENT_INTERNAL_ERROR:
+		return cper_ccix_agent_err_details(pfx, gdata);
 	default:
 		/* Vendor defined so no formatting be done */
 		break;
@@ -874,3 +908,12 @@ const char *cper_ccix_link_err_unpack(struct trace_seq *p,
 
 	return ret;
 }
+
+void cper_ccix_agent_err_pack(const struct cper_sec_ccix_agent_err *agent_record,
+			      struct cper_ccix_agent_err_compact *cagent_err,
+			      const u16 vendor_data_len,
+			      u8 *vendor_data)
+{
+	cagent_err->validation_bits = agent_record->validation_bits;
+	memcpy(vendor_data, &agent_record->vendor_data[1], vendor_data_len);
+}
diff --git a/include/linux/cper.h b/include/linux/cper.h
index d35be55351e3..373c1d387a70 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -783,6 +783,30 @@ struct cper_ccix_link_err_compact {
 	__u8	credit_type;
 };
 
+struct cper_sec_ccix_agent_err {
+	__u32	validation_bits;
+#define CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID	BIT(0)
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_agent_err {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_agent_err agent_record;
+};
+
+static inline u16 ccix_agent_err_ven_len_get(struct cper_ccix_agent_err *agent_err)
+{
+	if (agent_err->agent_record.validation_bits & CCIX_AGENT_INTERNAL_ERR_VENDOR_DATA_VALID)
+		return agent_err->agent_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_agent_err_compact {
+	__u32	validation_bits;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -835,6 +859,11 @@ void cper_ccix_link_err_pack(const struct cper_sec_ccix_link_error *link_record,
 const char *cper_ccix_link_err_unpack(struct trace_seq *p,
 				      struct cper_ccix_link_err_compact *clink_err);
 
+void cper_ccix_agent_err_pack(const struct cper_sec_ccix_agent_err *agent_record,
+			      struct cper_ccix_agent_err_compact *cagent_err,
+			      const u16 vendor_data_len,
+			      u8 *vendor_data);
+
 struct acpi_hest_generic_data;
 int cper_print_ccix_per(const char *pfx,
 			struct acpi_hest_generic_data *gdata);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index bfe1c64b9db0..d09e5389a1e6 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -679,6 +679,70 @@ TRACE_EVENT(ccix_link_error_event,
 	)
 );
 
+TRACE_EVENT(ccix_agent_error_event,
+	TP_PROTO(struct cper_ccix_agent_err *err,
+		 u32 err_seq,
+		 u8 sev, u16 ven_len),
+
+	TP_ARGS(err, err_seq, sev, ven_len),
+
+	TP_STRUCT__entry(
+		__field(u32, err_seq)
+		__field(u8, sev)
+		__field(u8, sevdetail)
+		__field(u8, source)
+		__field(u8, component)
+		__field(u64, pa)
+		__field(u8, pa_mask_lsb)
+		__field(u16, vendor_data_length)
+		__field_struct(struct cper_ccix_agent_err_compact, data)
+		__dynamic_array(u8, vendor_data, ven_len)
+	),
+
+	TP_fast_assign(
+		__entry->err_seq = err_seq;
+
+		__entry->sev = sev;
+		__entry->sevdetail = FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M |
+			CCIX_PER_LOG_DW1_SEV_NO_COMM_M |
+			CCIX_PER_LOG_DW1_SEV_DEGRADED_M |
+			CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M,
+			err->ccix_header[1]);
+		if (err->header.validation_bits & 0x1)
+			__entry->source = err->header.source_id;
+		else
+			__entry->source = ~0;
+		__entry->component = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M,
+						   err->ccix_header[1]);
+		if (err->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
+			__entry->pa = (u64)err->ccix_header[2] << 32 |
+				(err->ccix_header[3] & 0xfffffffc);
+			__entry->pa_mask_lsb = err->ccix_header[4] & 0xff;
+		} else {
+			__entry->pa = ~0ull;
+			__entry->pa_mask_lsb = ~0;
+		}
+		/* Do not store the vendor data header length */
+		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
+		cper_ccix_agent_err_pack(&err->agent_record, &__entry->data,
+					__entry->vendor_data_length,
+					__get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER Agent Internal Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		__entry->sevdetail & BIT(0) ? 1 : 0,
+		__entry->sevdetail & BIT(1) ? 1 : 0,
+		__entry->sevdetail & BIT(2) ? 1 : 0,
+		__entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
+	)
+);
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.20.1

