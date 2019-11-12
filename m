Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFEF9629
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKLQyN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 11:54:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbfKLQyD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 Nov 2019 11:54:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 899CAFA392912A55653C;
        Wed, 13 Nov 2019 00:53:38 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 00:53:27 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/6] efi / ras: CCIX Port error reporting
Date:   Wed, 13 Nov 2019 00:52:24 +0800
Message-ID: <20191112165226.106107-5-Jonathan.Cameron@huawei.com>
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

The CCIX 1.0 base specification defines a CCIX protocol layer port.
The specification provides a mechanism for detailed error logging
for these ports.  The UEFI 2.8 specification includes a CCIX CPER
record for firmware first handling to report these errors to the
operating system.

This patch is very similar to the support previously added for
for CCIX Memory Errors and provides both logging and RAS tracepoint
for this error class.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c         |   4 +
 drivers/firmware/efi/cper-ccix.c | 123 +++++++++++++++++++++++++++++++
 include/linux/cper.h             |  42 +++++++++++
 include/ras/ras_event.h          |  66 +++++++++++++++++
 4 files changed, 235 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ba73d3a5d564..7455db97319c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -525,6 +525,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
 		trace_ccix_atc_error_event(payload, err_seq, sev,
 					   ccix_atc_err_ven_len_get(payload));
 		break;
+	case CCIX_PORT_ERROR:
+		trace_ccix_port_error_event(payload, err_seq, sev,
+					    ccix_port_err_ven_len_get(payload));
+		break;
 	default:
 		/* Unknown error type */
 		pr_info("CCIX error of unknown or vendor defined type\n");
diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
index a33683d057e9..b936661b3db3 100644
--- a/drivers/firmware/efi/cper-ccix.c
+++ b/drivers/firmware/efi/cper-ccix.c
@@ -431,6 +431,81 @@ static int cper_ccix_atc_err_details(const char *pfx,
 	return 0;
 }
 
+static const char * const ccix_port_err_type_strs[] = {
+	"Generic Bus / Slave Error",
+	"Bus Parity / ECC Error",
+	"BDF Not Present",
+	"Invalid Address",
+	"Invalid AgentID",
+	"Bus Timeout",
+	"Hang",
+	"Egress Blocked",
+};
+
+static const char *cper_ccix_port_err_type_str(__u8 op)
+{
+	return op < ARRAY_SIZE(ccix_port_err_type_strs) ?
+		ccix_port_err_type_strs[op] : "Reserved";
+}
+
+static const char * const ccix_port_err_op_strs[] = {
+	"Command",
+	"Read",
+	"Write",
+};
+
+static const char *cper_ccix_port_err_op_str(__u8 op)
+{
+	return op < ARRAY_SIZE(ccix_port_err_op_strs) ?
+		ccix_port_err_op_strs[op] : "Reserved";
+}
+
+static int cper_ccix_port_err_details(const char *pfx,
+				     struct acpi_hest_generic_data *gdata)
+{
+	struct cper_ccix_port_error *full_port_err;
+	struct cper_sec_ccix_port_error *port_err;
+	u16 vendor_data_len;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*full_port_err))
+		return -ENOSPC;
+
+	full_port_err = acpi_hest_get_payload(gdata);
+
+	port_err = &full_port_err->port_record;
+
+	if (port_err->validation_bits & CCIX_PORT_ERR_TYPE_VALID)
+		printk("%s""Error Type: %s\n", pfx,
+		       cper_ccix_port_err_type_str(port_err->err_type));
+
+	if (port_err->validation_bits & CCIX_PORT_ERR_OP_VALID)
+		printk("%s""Operation: %s\n", pfx,
+		       cper_ccix_port_err_op_str(port_err->op_type));
+
+	/* CHECK THE AER EQUIVALENT */
+	if (port_err->validation_bits & CCIX_PORT_ERR_MESSAGE_VALID) {
+		for (i = 0; i < ARRAY_SIZE(port_err->message); i++)
+			printk("%s""Message%d: 0x%08x\n", pfx, i,
+			       port_err->message[i]);
+	}
+
+	if (port_err->validation_bits & CCIX_PORT_ERR_VENDOR_DATA_VALID) {
+		if (gdata->error_data_length < sizeof(*full_port_err) + 4)
+			return -ENOSPC;
+
+		vendor_data_len = port_err->vendor_data[0] & GENMASK(15, 0);
+		if (gdata->error_data_length < sizeof(*full_port_err) + vendor_data_len)
+			return -ENOSPC;
+
+		for (i = 0; i < vendor_data_len / 4 - 1; i++)
+			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
+			       port_err->vendor_data[i + 1]);
+	}
+
+	return 0;
+}
+
 int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 {
 	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
@@ -496,6 +571,8 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
 		return cper_ccix_cache_err_details(pfx, gdata);
 	case CCIX_ATC_ERROR:
 		return cper_ccix_atc_err_details(pfx, gdata);
+	case CCIX_PORT_ERROR:
+		return cper_ccix_port_err_details(pfx, gdata);
 	default:
 		/* Vendor defined so no formatting be done */
 		break;
@@ -611,3 +688,49 @@ const char *cper_ccix_atc_err_unpack(struct trace_seq *p,
 	return ret;
 }
 
+void cper_ccix_port_err_pack(const struct cper_sec_ccix_port_error *port_record,
+			     struct cper_ccix_port_err_compact *cport_err,
+			     const u16 vendor_data_len,
+			     u8 *vendor_data)
+{
+	cport_err->validation_bits = port_record->validation_bits;
+	cport_err->err_type = port_record->err_type;
+	cport_err->op_type = port_record->op_type;
+	memcpy(cport_err->message, port_record->message,
+	       sizeof(cport_err->message));
+	memcpy(vendor_data, &port_record->vendor_data[1], vendor_data_len);
+}
+
+static int cper_ccix_err_port_location(struct cper_ccix_port_err_compact *cport_err,
+				       char *msg)
+{
+	u32 len = CPER_REC_LEN - 1;
+	u32 n = 0;
+
+	if (!msg)
+		return 0;
+
+	if (cport_err->validation_bits & CCIX_PORT_ERR_TYPE_VALID)
+		n += snprintf(msg + n, len, "Error Type: %s ",
+			      cper_ccix_port_err_type_str(cport_err->err_type));
+
+
+	if (cport_err->validation_bits & CCIX_PORT_ERR_OP_VALID)
+		n += snprintf(msg + n, len, "Op: %s ",
+			     cper_ccix_port_err_op_str(cport_err->op_type));
+
+	return n;
+}
+
+const char *cper_ccix_port_err_unpack(struct trace_seq *p,
+				      struct cper_ccix_port_err_compact *cport_err)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (cper_ccix_err_port_location(cport_err, rcd_decode_str))
+		trace_seq_printf(p, "%s", rcd_decode_str);
+
+	trace_seq_putc(p, '\0');
+
+	return ret;
+}
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 6bb603e9a97a..5e315afc210e 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -707,6 +707,41 @@ struct cper_ccix_atc_err_compact {
 	__u8	instance;
 };
 
+
+struct cper_sec_ccix_port_error {
+	__u32	validation_bits;
+#define CCIX_PORT_ERR_OP_VALID			BIT(0)
+#define CCIX_PORT_ERR_TYPE_VALID		BIT(1)
+#define CCIX_PORT_ERR_MESSAGE_VALID		BIT(2)
+#define CCIX_PORT_ERR_VENDOR_DATA_VALID		BIT(3)
+	__u16	length; /* Includes vendor specific log info */
+	__u8	op_type;
+	__u8	err_type;
+	__u32	message[8];
+	__u32	vendor_data[];
+};
+
+struct cper_ccix_port_error {
+	struct cper_sec_ccix_header header;
+	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
+	struct cper_sec_ccix_port_error port_record;
+};
+
+static inline u16 ccix_port_err_ven_len_get(struct cper_ccix_port_error *port_err)
+{
+	if (port_err->port_record.validation_bits & CCIX_PORT_ERR_VENDOR_DATA_VALID)
+		return port_err->port_record.vendor_data[0] & 0xFFFF;
+	else
+		return 0;
+}
+
+struct cper_ccix_port_err_compact {
+	__u32	validation_bits;
+	__u32	message[8];
+	__u8	err_type;
+	__u8	op_type;
+};
+
 /* Reset to default packing */
 #pragma pack()
 
@@ -745,6 +780,13 @@ void cper_ccix_atc_err_pack(const struct cper_sec_ccix_atc_error *atc_record,
 const char *cper_ccix_atc_err_unpack(struct trace_seq *p,
 				     struct cper_ccix_atc_err_compact *catc_err);
 
+void cper_ccix_port_err_pack(const struct cper_sec_ccix_port_error *port_record,
+			     struct cper_ccix_port_err_compact *cport_err,
+			     const u16 vendor_data_len,
+			     u8 *vendor_data);
+const char *cper_ccix_port_err_unpack(struct trace_seq *p,
+				      struct cper_ccix_port_err_compact *cport_err);
+
 struct acpi_hest_generic_data;
 int cper_print_ccix_per(const char *pfx,
 			struct acpi_hest_generic_data *gdata);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index bab49e297551..52ac3f2d4c11 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -548,6 +548,72 @@ TRACE_EVENT(ccix_atc_error_event,
 	)
 );
 
+TRACE_EVENT(ccix_port_error_event,
+	TP_PROTO(struct cper_ccix_port_error *err,
+		 u32 err_seq,
+		 u8 sev,
+		 u16 ven_len),
+
+	TP_ARGS(err, err_seq, sev, ven_len),
+	TP_STRUCT__entry(
+		__field(u32, err_seq)
+		__field(u8, sev)
+		__field(u8, sevdetail)
+		__field(u8, source)
+		__field(u8, component)
+		__field(u64, pa)
+		__field(u8, pa_mask_lsb)
+		__field_struct(struct cper_ccix_port_err_compact, data)
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
+
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
+		cper_ccix_port_err_pack(&err->port_record, &__entry->data,
+					__entry->vendor_data_length,
+					__get_dynamic_array(vendor_data));
+	),
+
+	TP_printk("{%d} %s CCIX PER Port Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
+		__entry->err_seq,
+		cper_severity_str(__entry->sev),
+		cper_ccix_comp_type_str(__entry->component),
+		__entry->sevdetail & BIT(0) ? 1 : 0,
+		__entry->sevdetail & BIT(1) ? 1 : 0,
+		__entry->sevdetail & BIT(2) ? 1 : 0,
+		__entry->sevdetail & BIT(3) ? 1 : 0,
+		__entry->pa,
+		__entry->pa_mask_lsb,
+		cper_ccix_port_err_unpack(p, &__entry->data),
+		__print_hex(__get_dynamic_array(vendor_data), __entry->vendor_data_length)
+	)
+);
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.20.1

