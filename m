Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955CDEE356
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 16:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfKDPPu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 10:15:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPPu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 10:15:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FCP0v032260;
        Mon, 4 Nov 2019 15:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=85K7fC2AblLC2FOwgaSUFn+yoZ4NbAzwtxs7nqvsiEU=;
 b=pHnvkMlHIICf/ZFx5eq2Ya8tvOJZGaUne/n2aLj/2SkIj0yYG4TVVg5Az2Wjw6TTz4Rt
 48f5ClSW+FIjxnh/DjMAVKfRFqInqksN9QDBFCeGhYnWHASGbjYqTv5YsmBdFB8ZFail
 L1RK3ZrNDGdHcTWgqBpDMAiSFPDDeJ8MLKh0LFELSwGUTgIS1hlIbz6ZgsXhLnW09MCY
 N62KOTtecuzzyiuNR1oIrSlJMHNe4zXY/Z25ueeU4FnHI1eUANRKnF2BjQPktn3AKwcX
 SQ6OAMtRuQ3GlQjkidUW4cyo92ZyTQUk1Sj8V6RVPjVrb++m3R2HiWx4V8CIj3HJpUXi 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpr13u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FABIi020092;
        Mon, 4 Nov 2019 15:14:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w1kxmhhg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4FEUfo018320;
        Mon, 4 Nov 2019 15:14:30 GMT
Received: from tomti.i.net-space.pl (/10.175.168.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 07:14:29 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v5 3/3] x86/boot: Introduce the setup_indirect
Date:   Mon,  4 Nov 2019 16:13:54 +0100
Message-Id: <20191104151354.28145-4-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191104151354.28145-1-daniel.kiper@oracle.com>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040151
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The setup_data is a bit awkward to use for extremely large data objects,
both because the setup_data header has to be adjacent to the data object
and because it has a 32-bit length field. However, it is important that
intermediate stages of the boot process have a way to identify which
chunks of memory are occupied by kernel data. Thus we introduce an uniform
way to specify such indirect data as setup_indirect struct and
SETUP_INDIRECT type.

And finally bump setup_header version in arch/x86/boot/header.S.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
v5 - suggestions/fixes:
   - bump setup_header version in arch/x86/boot/header.S
     (suggested by H. Peter Anvin).

v4 - suggestions/fixes:
   - change "Note:" to ".. note::".

v3 - suggestions/fixes:
   - add setup_indirect mapping/KASLR avoidance/etc. code
     (suggested by H. Peter Anvin),
   - the SETUP_INDIRECT sets most significant bit right now;
     this way it is possible to differentiate regular setup_data
     and setup_indirect objects in the debugfs filesystem.

v2 - suggestions/fixes:
   - add setup_indirect usage example
     (suggested by Eric Snowberg and Ross Philipson).
---
 Documentation/x86/boot.rst             | 43 +++++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/kaslr.c       | 12 ++++++++++
 arch/x86/boot/compressed/kernel_info.S |  2 +-
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 16 ++++++++++---
 arch/x86/kernel/e820.c                 | 11 +++++++++
 arch/x86/kernel/kdebugfs.c             | 20 ++++++++++++----
 arch/x86/kernel/ksysfs.c               | 30 ++++++++++++++++++------
 arch/x86/kernel/setup.c                |  4 ++++
 arch/x86/mm/ioremap.c                  | 11 +++++++++
 10 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 1dad6eee8a5c..38155ba8740f 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -827,6 +827,47 @@ Protocol:	2.09+
   sure to consider the case where the linked list already contains
   entries.
 
+  The setup_data is a bit awkward to use for extremely large data objects,
+  both because the setup_data header has to be adjacent to the data object
+  and because it has a 32-bit length field. However, it is important that
+  intermediate stages of the boot process have a way to identify which
+  chunks of memory are occupied by kernel data.
+
+  Thus setup_indirect struct and SETUP_INDIRECT type were introduced in
+  protocol 2.15.
+
+  struct setup_indirect {
+    __u32 type;
+    __u32 reserved;  /* Reserved, must be set to zero. */
+    __u64 len;
+    __u64 addr;
+  };
+
+  The type member is a SETUP_INDIRECT | SETUP_* type. However, it cannot be
+  SETUP_INDIRECT itself since making the setup_indirect a tree structure
+  could require a lot of stack space in something that needs to parse it
+  and stack space can be limited in boot contexts.
+
+  Let's give an example how to point to SETUP_E820_EXT data using setup_indirect.
+  In this case setup_data and setup_indirect will look like this:
+
+  struct setup_data {
+    __u64 next = 0 or <addr_of_next_setup_data_struct>;
+    __u32 type = SETUP_INDIRECT;
+    __u32 len = sizeof(setup_data);
+    __u8 data[sizeof(setup_indirect)] = struct setup_indirect {
+      __u32 type = SETUP_INDIRECT | SETUP_E820_EXT;
+      __u32 reserved = 0;
+      __u64 len = <len_of_SETUP_E820_EXT_data>;
+      __u64 addr = <addr_of_SETUP_E820_EXT_data>;
+    }
+  }
+
+.. note::
+     SETUP_INDIRECT | SETUP_NONE objects cannot be properly distinguished
+     from SETUP_INDIRECT itself. So, this kind of objects cannot be provided
+     by the bootloaders.
+
 ============	============
 Field name:	pref_address
 Type:		read (reloc)
@@ -986,7 +1027,7 @@ Field name:	setup_type_max
 Offset/size:	0x0008/4
 ============	==============
 
-  This field contains maximal allowed type for setup_data.
+  This field contains maximal allowed type for setup_data and setup_indirect structs.
 
 
 The Image Checksum
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c056ba20..bb9bfef174ae 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -459,6 +459,18 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 			is_overlapping = true;
 		}
 
+		if (ptr->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)ptr->data)->type != SETUP_INDIRECT) {
+			avoid.start = ((struct setup_indirect *)ptr->data)->addr;
+			avoid.size = ((struct setup_indirect *)ptr->data)->len;
+
+			if (mem_overlaps(img, &avoid) && (avoid.start < earliest)) {
+				*overlap = avoid;
+				earliest = overlap->start;
+				is_overlapping = true;
+			}
+		}
+
 		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}
 
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index 018dacbd753e..f818ee8fba38 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -14,7 +14,7 @@ kernel_info:
 	/* Size total. */
 	.long	kernel_info_end - kernel_info
 
-	/* Maximal allowed type for setup_data. */
+	/* Maximal allowed type for setup_data and setup_indirect structs. */
 	.long	SETUP_TYPE_MAX
 
 kernel_info_var_len_data:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 22dcecaaa898..97d9b6d6c1af 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020d		# header version number (>= 0x0105)
+		.word	0x020f		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index dbb41128e5a0..949066b5398a 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data types */
+/* setup_data/setup_indirect types */
 #define SETUP_NONE			0
 #define SETUP_E820_EXT			1
 #define SETUP_DTB			2
@@ -11,8 +11,10 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 
-/* max(SETUP_*) */
-#define SETUP_TYPE_MAX			SETUP_JAILHOUSE
+#define SETUP_INDIRECT			(1<<31)
+
+/* SETUP_INDIRECT | max(SETUP_*) */
+#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_JAILHOUSE)
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
@@ -52,6 +54,14 @@ struct setup_data {
 	__u8 data[0];
 };
 
+/* extensible setup indirect data node */
+struct setup_indirect {
+	__u32 type;
+	__u32 reserved;  /* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
+};
+
 struct setup_header {
 	__u8	setup_sects;
 	__u16	root_flags;
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7da2bcd2b8eb..0bfe9a685b3b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -999,6 +999,17 @@ void __init e820__reserve_setup_data(void)
 		data = early_memremap(pa_data, sizeof(*data));
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 		e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			e820__range_update(((struct setup_indirect *)data->data)->addr,
+					   ((struct setup_indirect *)data->data)->len,
+					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
+						 ((struct setup_indirect *)data->data)->len,
+						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		}
+
 		pa_data = data->next;
 		early_memunmap(data, sizeof(*data));
 	}
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index edaa30b20841..701a98300f86 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -44,7 +44,11 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 	if (count > node->len - pos)
 		count = node->len - pos;
 
-	pa = node->paddr + sizeof(struct setup_data) + pos;
+	pa = node->paddr + pos;
+
+	if (!(node->type & SETUP_INDIRECT) || node->type == SETUP_INDIRECT)
+		pa += sizeof(struct setup_data);
+
 	p = memremap(pa, count, MEMREMAP_WB);
 	if (!p)
 		return -ENOMEM;
@@ -108,9 +112,17 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			goto err_dir;
 		}
 
-		node->paddr = pa_data;
-		node->type = data->type;
-		node->len = data->len;
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			node->paddr = ((struct setup_indirect *)data->data)->addr;
+			node->type = ((struct setup_indirect *)data->data)->type;
+			node->len = ((struct setup_indirect *)data->data)->len;
+		} else {
+			node->paddr = pa_data;
+			node->type = data->type;
+			node->len = data->len;
+		}
+
 		create_setup_data_node(d, no, node);
 		pa_data = data->next;
 
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index 7969da939213..14ef8121aa53 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -100,7 +100,11 @@ static int __init get_setup_data_size(int nr, size_t *size)
 		if (!data)
 			return -ENOMEM;
 		if (nr == i) {
-			*size = data->len;
+			if (data->type == SETUP_INDIRECT &&
+			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+				*size = ((struct setup_indirect *)data->data)->len;
+			else
+				*size = data->len;
 			memunmap(data);
 			return 0;
 		}
@@ -130,7 +134,10 @@ static ssize_t type_show(struct kobject *kobj,
 	if (!data)
 		return -ENOMEM;
 
-	ret = sprintf(buf, "0x%x\n", data->type);
+	if (data->type == SETUP_INDIRECT)
+		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
+	else
+		ret = sprintf(buf, "0x%x\n", data->type);
 	memunmap(data);
 	return ret;
 }
@@ -142,7 +149,7 @@ static ssize_t setup_data_data_read(struct file *fp,
 				    loff_t off, size_t count)
 {
 	int nr, ret = 0;
-	u64 paddr;
+	u64 paddr, len;
 	struct setup_data *data;
 	void *p;
 
@@ -157,19 +164,28 @@ static ssize_t setup_data_data_read(struct file *fp,
 	if (!data)
 		return -ENOMEM;
 
-	if (off > data->len) {
+	if (data->type == SETUP_INDIRECT &&
+	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+		paddr = ((struct setup_indirect *)data->data)->addr;
+		len = ((struct setup_indirect *)data->data)->len;
+	} else {
+		paddr += sizeof(*data);
+		len = data->len;
+	}
+
+	if (off > len) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (count > data->len - off)
-		count = data->len - off;
+	if (count > len - off)
+		count = len - off;
 
 	if (!count)
 		goto out;
 
 	ret = count;
-	p = memremap(paddr + sizeof(*data), data->len, MEMREMAP_WB);
+	p = memremap(paddr, len, MEMREMAP_WB);
 	if (!p) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..4603702dbfc1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -438,6 +438,10 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+			memblock_reserve(((struct setup_indirect *)data->data)->addr,
+					 ((struct setup_indirect *)data->data)->len);
 		pa_data = data->next;
 		early_memunmap(data, sizeof(*data));
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a39dcdb5ae34..1ff9c2030b4f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -626,6 +626,17 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 		paddr_next = data->next;
 		len = data->len;
 
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+			memunmap(data);
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			paddr = ((struct setup_indirect *)data->data)->addr;
+			len = ((struct setup_indirect *)data->data)->len;
+		}
+
 		memunmap(data);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
-- 
2.11.0

