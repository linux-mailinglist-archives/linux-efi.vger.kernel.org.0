Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C925B962DC
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfHTOsY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 10:48:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729900AbfHTOsY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Aug 2019 10:48:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5184CF1B9576C63E22E;
        Tue, 20 Aug 2019 22:48:18 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 22:48:08 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        <jcm@redhat.com>, <linux-kernel@vger.kernel.org>,
        <peter.maydell@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/6 V2] efi / ras: CCIX Cache error reporting
Date:   Tue, 20 Aug 2019 22:47:28 +0800
Message-ID: <20190820144732.2370-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820144732.2370-1-Jonathan.Cameron@huawei.com>
References: <20190820144732.2370-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As CCIX Request Agents have fully cache coherent caches,
the CCIX 1.0 Base Specification defines detailed error
reporting for these caches.

A CCIX cache error is reported via a CPER record as defined in the
UEFI 2.8 specification. The PER log section is defined in the
CCIX 1.0 Base Specification.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Changes since v1.
	Drop printing of vendor data to kernel log.
	
 drivers/acpi/apei/ghes.c         |   4 +
 drivers/firmware/efi/cper-ccix.c | 156 +++++++++++++++++++++++++++++++
 include/linux/cper.h             |  57 +++++++++++
 include/ras/ras_event.h          |  66 +++++++++++++
 4 files changed, 283 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1ae36d836a77..5bda94e48b1b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -504,6 +504,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
 		trace_ccix_memory_error_event(payload, err_seq, sev,
 					      ccix_mem_err_ven_len_get(payload));
 		break;
+	case CCIX_CACHE_ERROR:
+		trace_ccix_cache_error_event(payload, err_seq, sev,
+					     ccix_cache_err_ven_len_get(payload));
+		break;
 	default:
 		/* Unknown error type */
 		pr_info("CCIX error of unknown or vendor defined type\n");
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
index 0be2630b2712..fa3fafac402b 100644
--- a/drivers/firmware/efi/cper-ccix.c
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -273,6 +273,96 @@ static int cper_ccix_mem_err_details(const char *pfx,
 	return 0;
 }
 
+static const char * const ccix_cache_type_strs[] = {
+	"Instruction Cache",
+	"Data Cache",
+	"Generic / Unified Cache",
+	"Snoop Filter Directory",
+};
+
+static const char *cper_ccix_cache_type_str(__u8 type)
+{
+	return type < ARRAY_SIZE(ccix_cache_type_strs) ?
+		ccix_cache_type_strs[type] : "Reserved";
+}
+
+static const char * const ccix_cache_err_type_strs[] = {
+	"Data",
+	"Tag",
+	"Timeout",
+	"Hang",
+	"Data Lost",
+	"Invalid Address",
+};
+
+const char *cper_ccix_cache_err_type_str(__u8 error_type)
+{
+	return error_type < ARRAY_SIZE(ccix_cache_err_type_strs) ?
+		ccix_cache_err_type_strs[error_type] : "Reserved";
+}
+
+static const char * const ccix_cache_err_op_strs[] = {
+	"Generic",
+	"Generic Read",
+	"Generic Write",
+	"Data Read",
+	"Data Write",
+	"Instruction Fetch",
+	"Prefetch",
+	"Eviction",
+	"Snooping",
+	"Snooped",
+	"Management / Command Error",
+};
+
+static const char *cper_ccix_cache_err_op_str(__u8 op)
+{
+	return op < ARRAY_SIZE(ccix_cache_err_op_strs) ?
+		ccix_cache_err_op_strs[op] : "Reserved";
+}
+
+static int cper_ccix_cache_err_details(const char *pfx,
+				     struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_cache_error *full_cache_err;
+	struct cper_sec_ccix_cache_error *cache_err;
+
+	if (gdata->error_data_length < sizeof(*full_cache_err))
+		return -ENOSPC;
+
+	full_cache_err = acpi_hest_get_payload(gdata);
+
+	cache_err = &full_cache_err->cache_record;
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
+		printk("%s""Cache Type: %s\n", pfx,
+		       cper_ccix_cache_type_str(cache_err->cache_type));
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_OP_VALID)
+		printk("%s""Operation: %s\n", pfx,
+		       cper_ccix_cache_err_op_str(cache_err->op_type));
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
+		printk("%s""Cache Error Type: %s\n", pfx,
+		       cper_ccix_cache_err_type_str(cache_err->cache_error_type));
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
+		printk("%s""Level: %d\n", pfx, cache_err->cache_level);
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_SET_VALID)
+		printk("%s""Set: %d\n", pfx, cache_err->set);
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
+		printk("%s""Way: %d\n", pfx, cache_err->way);
+
+	if (cache_err->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
+		printk("%s""Instance ID: %d\n", pfx, cache_err->instance);
+
+	/* Vendor data is not printed to the kernel log */
+
+	return 0;
+}
+
 int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 {
 	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
@@ -334,9 +424,75 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 	switch (per_type) {
 	case CCIX_MEMORY_ERROR:
 		return cper_ccix_mem_err_details(pfx, gdata);
+	case CCIX_CACHE_ERROR:
+		return cper_ccix_cache_err_details(pfx, gdata);
 	default:
 		/* Vendor defined so no formatting be done */
 		break;
 	}
 	return 0;
 }
+
+void cper_ccix_cache_err_pack(const struct cper_sec_ccix_cache_error *cache_record,
+			      struct cper_ccix_cache_err_compact *ccache_err,
+			      const u16 vendor_data_len,
+			      u8 *vendor_data)
+{
+	ccache_err->validation_bits = cache_record->validation_bits;
+	ccache_err->set = cache_record->set;
+	ccache_err->way = cache_record->way;
+	ccache_err->cache_type = cache_record->cache_type;
+	ccache_err->op_type = cache_record->op_type;
+	ccache_err->cache_error_type = cache_record->cache_error_type;
+	ccache_err->cache_level = cache_record->cache_level;
+	ccache_err->instance = cache_record->instance;
+	memcpy(vendor_data, &cache_record->vendor_data[1], vendor_data_len);
+}
+
+static int cper_ccix_err_cache_location(struct cper_ccix_cache_err_compact *ccache_err,
+					char *msg)
+{
+	u32 len = CPER_REC_LEN - 1;
+	u32 n = 0;
+
+	if (!msg)
+		return 0;
+
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
+		n += snprintf(msg + n, len, "Error: %s ",
+			     cper_ccix_cache_err_type_str(ccache_err->cache_error_type));
+
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
+		n += snprintf(msg + n, len, "Type: %s ",
+			     cper_ccix_cache_type_str(ccache_err->cache_type));
+
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_OP_VALID)
+		n += snprintf(msg + n, len, "Op: %s ",
+			      cper_ccix_cache_err_op_str(ccache_err->op_type));
+
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
+		n += snprintf(msg + n, len, "Level: %d ",
+			      ccache_err->cache_level);
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_SET_VALID)
+		n += snprintf(msg + n, len, "Set: %d ", ccache_err->set);
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
+		n += snprintf(msg + n, len, "Way: %d ", ccache_err->way);
+	if (ccache_err->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
+		n += snprintf(msg + n, len, "Instance: %d ",
+			      ccache_err->instance);
+
+	return n;
+}
+
+const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
+				       struct cper_ccix_cache_err_compact *ccache_err)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (cper_ccix_err_cache_location(ccache_err, rcd_decode_str))
+		trace_seq_printf(p, "%s", rcd_decode_str);
+
+	trace_seq_putc(p, '\0');
+
+	return ret;
+}
diff --git a/include/linux/cper.h b/include/linux/cper.h
index df7a34c3ba4f..eef254b8b8b7 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -627,6 +627,54 @@ struct cper_ccix_mem_err_compact {
 	__u8	fru;
 };
 
+struct cper_sec_ccix_cache_error {
+	__u32	validation_bits;
+#define CCIX_CACHE_ERR_TYPE_VALID		BIT(0)
+#define CCIX_CACHE_ERR_OP_VALID			BIT(1)
+#define CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID	BIT(2)
+#define CCIX_CACHE_ERR_LEVEL_VALID		BIT(3)
+#define CCIX_CACHE_ERR_SET_VALID		BIT(4)
+#define CCIX_CACHE_ERR_WAY_VALID		BIT(5)
+#define CCIX_CACHE_ERR_INSTANCE_ID_VALID	BIT(6)
+#define CCIX_CACHE_ERR_VENDOR_DATA_VALID	BIT(7)
+	__u16	length; /* Includes vendor specific log info */
+	__u8	cache_type;
+	__u8	op_type;
+	__u8	cache_error_type;
+	__u8	cache_level;
+	__u32	set;
+	__u32	way;
+	__u8	instance;
+	__u8	reserved;
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_cache_error {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_cache_error cache_record;
+};
+
+static inline u16 ccix_cache_err_ven_len_get(struct cper_ccix_cache_error *cache_err)
+{
+	if (cache_err->cache_record.validation_bits &
+	    CCIX_CACHE_ERR_VENDOR_DATA_VALID)
+		return cache_err->cache_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_cache_err_compact {
+	__u32	validation_bits;
+	__u32	set;
+	__u32	way;
+	__u8	cache_type;
+	__u8	op_type;
+	__u8	cache_error_type;
+	__u8	cache_level;
+	__u8	instance;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -649,6 +697,15 @@ const char *cper_ccix_mem_err_unpack(struct trace_seq *p,
 				     struct cper_ccix_mem_err_compact *cmem_err);
 const char *cper_ccix_mem_err_type_str(unsigned int error_type);
 const char *cper_ccix_comp_type_str(u8 comp_type);
+
+void cper_ccix_cache_err_pack(const struct cper_sec_ccix_cache_error *cache_record,
+			      struct cper_ccix_cache_err_compact *ccache_err,
+			      const u16 vendor_data_len,
+			      u8 *vendor_data);
+const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
+				       struct cper_ccix_cache_err_compact *ccache_err);
+const char *cper_ccix_cache_err_type_str(__u8 error_type);
+
 struct acpi_hest_generic_data;
 int cper_print_ccix_per(const char *pfx,
 			struct acpi_hest_generic_data *gdata);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 128728eaeef4..55f2c1900c54 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -415,6 +415,72 @@ TRACE_EVENT(ccix_memory_error_event,
 	)
 );
 
+TRACE_EVENT(ccix_cache_error_event,
+	TP_PROTO(struct cper_ccix_cache_error *err,
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
+		__field_struct(struct cper_ccix_cache_err_compact, data)
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
+		cper_ccix_cache_err_pack(&err->cache_record, &__entry->data,
+					 __entry->vendor_data_length,
+					 __get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER Cache Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		__entry->sevdetail & BIT(0) ? 1 : 0,
+		__entry->sevdetail & BIT(1) ? 1 : 0,
+		__entry->sevdetail & BIT(2) ? 1 : 0,
+		__entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		cper_ccix_cache_err_unpack(p, &__entry->data),
+		__print_hex(__get_dynamic_array(vendor_data),
+			    __entry->vendor_data_length)
+	)
+);
 /*
  * memory-failure recovery action result event
  *
-- 
2.20.1

