Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125CBFB37B
	for <lists+linux-efi@lfdr.de>; Wed, 13 Nov 2019 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKMPRG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Nov 2019 10:17:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727907AbfKMPRG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Nov 2019 10:17:06 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4A0C5C66BF1D55287BCA;
        Wed, 13 Nov 2019 23:17:03 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 23:16:54 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 3/6] efi / ras: CCIX Address Translation Cache error reporting
Date:   Wed, 13 Nov 2019 23:16:24 +0800
Message-ID: <20191113151627.7950-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
References: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CCIX devices tend to make heavy use of ATCs. The CCIX base
specification defines a protocol error message (PER) that
describes errors reported by such caches. The UEFI 2.8
specification includes a CCIX CPER record for firmware first
handling to report these errors to the operating system.

This patch is very similar to the support previously added
for CCIX Memory Errors and provides both logging and RAS
tracepoint for this error class.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c         |  4 ++
 drivers/firmware/efi/cper-ccix.c | 84 ++++++++++++++++++++++++++++++++
 include/linux/cper.h             | 39 +++++++++++++++
 include/ras/ras_event.h          | 66 +++++++++++++++++++++++++
 4 files changed, 193 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index c99a4216b67d..ba73d3a5d564 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -521,6 +521,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
 		trace_ccix_cache_error_event(payload, err_seq, sev,
 					     ccix_cache_err_ven_len_get(payload));
 		break;
+	case CCIX_ATC_ERROR:
+		trace_ccix_atc_error_event(payload, err_seq, sev,
+					   ccix_atc_err_ven_len_get(payload));
+		break;
 	default:
 		/* Unknown error type */
 		pr_info("CCIX error of unknown or vendor defined type\n");
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
index 14d3f5b8ceab..a33683d057e9 100644
--- a/drivers/firmware/efi/cper-ccix.c
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -394,6 +394,43 @@ static int cper_ccix_cache_err_details(const char *pfx,
 	return 0;
 }
 
+static int cper_ccix_atc_err_details(const char *pfx,
+				     struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_atc_error *full_atc_err;
+	struct cper_sec_ccix_atc_error *atc_err;
+	u16 vendor_data_len;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*full_atc_err))
+		return -ENOSPC;
+
+	full_atc_err = acpi_hest_get_payload(gdata);
+
+	atc_err = &full_atc_err->atc_record;
+
+	if (atc_err->validation_bits & CCIX_ATC_ERR_OP_VALID)
+		printk("%s""Operation: %s\n", pfx,
+		       cper_ccix_cache_err_op_str(atc_err->op_type));
+
+	if (atc_err->validation_bits & CCIX_ATC_ERR_INSTANCE_ID_VALID)
+		printk("%s""Instance ID: %d\n", pfx, atc_err->instance);
+
+	if (atc_err->validation_bits & CCIX_ATC_ERR_VENDOR_DATA_VALID) {
+		if (gdata->error_data_length < sizeof(*full_atc_err) + 4)
+			return -ENOSPC;
+		vendor_data_len = atc_err->vendor_data[0] & GENMASK(15, 0);
+		if (gdata->error_data_length < sizeof(*full_atc_err) + vendor_data_len)
+			return -ENOSPC;
+
+		for (i = 0; i < vendor_data_len / 4 - 1; i++)
+			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
+			       atc_err->vendor_data[i + 1]);
+	}
+
+	return 0;
+}
+
 int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 {
 	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
@@ -457,6 +494,8 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 		return cper_ccix_mem_err_details(pfx, gdata);
 	case CCIX_CACHE_ERROR:
 		return cper_ccix_cache_err_details(pfx, gdata);
+	case CCIX_ATC_ERROR:
+		return cper_ccix_atc_err_details(pfx, gdata);
 	default:
 		/* Vendor defined so no formatting be done */
 		break;
@@ -527,3 +566,48 @@ const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
 
 	return ret;
 }
+
+void cper_ccix_atc_err_pack(const struct cper_sec_ccix_atc_error *atc_record,
+			    struct cper_ccix_atc_err_compact *catc_err,
+			    const u16 vendor_data_len,
+			    u8 *vendor_data)
+{
+	catc_err->validation_bits = atc_record->validation_bits;
+	catc_err->op_type = atc_record->op_type;
+	catc_err->instance = atc_record->instance;
+	memcpy(vendor_data, &atc_record->vendor_data[1], vendor_data_len);
+}
+
+static int cper_ccix_err_atc_location(struct cper_ccix_atc_err_compact *catc_err,
+				      char *msg)
+{
+	u32 len = CPER_REC_LEN - 1;
+	u32 n = 0;
+
+	if (!msg)
+		return 0;
+
+	if (catc_err->validation_bits & CCIX_ATC_ERR_OP_VALID)
+		n += snprintf(msg + n, len, "Op: %s ",
+			     cper_ccix_cache_err_op_str(catc_err->op_type));
+
+	if (catc_err->validation_bits & CCIX_ATC_ERR_INSTANCE_ID_VALID)
+		n += snprintf(msg + n, len, "Instance: %d ",
+			      catc_err->instance);
+
+	return n;
+}
+
+const char *cper_ccix_atc_err_unpack(struct trace_seq *p,
+				     struct cper_ccix_atc_err_compact *catc_err)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (cper_ccix_err_atc_location(catc_err, rcd_decode_str))
+		trace_seq_printf(p, "%s", rcd_decode_str);
+
+	trace_seq_putc(p, '\0');
+
+	return ret;
+}
+
diff --git a/include/linux/cper.h b/include/linux/cper.h
index eef254b8b8b7..6bb603e9a97a 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -675,6 +675,38 @@ struct cper_ccix_cache_err_compact {
 	__u8	instance;
 };
 
+struct cper_sec_ccix_atc_error {
+	__u32	validation_bits;
+#define CCIX_ATC_ERR_OP_VALID			BIT(0)
+#define CCIX_ATC_ERR_INSTANCE_ID_VALID		BIT(1)
+#define CCIX_ATC_ERR_VENDOR_DATA_VALID		BIT(2)
+	__u16	length; /* Includes vendor specific log info */
+	__u8	op_type;
+	__u8	instance;
+	__u32	reserved;
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_atc_error {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_atc_error atc_record;
+};
+
+static inline u16 ccix_atc_err_ven_len_get(struct cper_ccix_atc_error *atc_err)
+{
+	if (atc_err->atc_record.validation_bits & CCIX_ATC_ERR_VENDOR_DATA_VALID)
+		return atc_err->atc_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_atc_err_compact {
+	__u32	validation_bits;
+	__u8	op_type;
+	__u8	instance;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -706,6 +738,13 @@ const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
 				       struct cper_ccix_cache_err_compact *ccache_err);
 const char *cper_ccix_cache_err_type_str(__u8 error_type);
 
+void cper_ccix_atc_err_pack(const struct cper_sec_ccix_atc_error *atc_record,
+			    struct cper_ccix_atc_err_compact *catc_err,
+			    const u16 vendor_data_len,
+			    u8 *vendor_data);
+const char *cper_ccix_atc_err_unpack(struct trace_seq *p,
+				     struct cper_ccix_atc_err_compact *catc_err);
+
 struct acpi_hest_generic_data;
 int cper_print_ccix_per(const char *pfx,
 			struct acpi_hest_generic_data *gdata);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 4a158820074c..b0a08c6e7db4 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -482,6 +482,72 @@ TRACE_EVENT(ccix_cache_error_event,
 			    __entry->vendor_data_length)
 	)
 );
+
+TRACE_EVENT(ccix_atc_error_event,
+	TP_PROTO(struct cper_ccix_atc_error *err,
+		 u32 err_seq,
+		 u8 sev,
+		 u16 ven_len),
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
+		__field_struct(struct cper_ccix_atc_err_compact, data)
+		__field(u16, vendor_data_length)
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
+					       err->ccix_header[1]);
+		if (err->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
+			__entry->pa = (u64)err->ccix_header[2] << 32 |
+				(err->ccix_header[3] & 0xfffffffc);
+			__entry->pa_mask_lsb = err->ccix_header[4] & 0xff;
+		} else {
+			__entry->pa = ~0ull;
+			__entry->pa_mask_lsb = ~0;
+		}
+
+		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
+		cper_ccix_atc_err_pack(&err->atc_record, &__entry->data,
+				       __entry->vendor_data_length,
+				       __get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER ATC Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		__entry->sevdetail & BIT(0) ? 1 : 0,
+		__entry->sevdetail & BIT(1) ? 1 : 0,
+		__entry->sevdetail & BIT(2) ? 1 : 0,
+		__entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		cper_ccix_atc_err_unpack(p, &__entry->data),
+		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
+	)
+);
 #endif
 
 /*
-- 
2.20.1

