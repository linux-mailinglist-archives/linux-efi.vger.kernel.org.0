Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC1F97B3
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKLRy0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 12:54:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLRyZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 12:54:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUaMW-0000ey-9v; Tue, 12 Nov 2019 18:53:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD54E1C0084;
        Tue, 12 Nov 2019 18:53:55 +0100 (CET)
Date:   Tue, 12 Nov 2019 17:53:55 -0000
From:   "tip-bot2 for Daniel Kiper" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Introduce setup_indirect
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Ross Philipson <ross.philipson@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@amacapital.net>,
        ard.biesheuvel@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        dave.hansen@linux.intel.com, eric.snowberg@oracle.com,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>, kanth.ghatraju@oracle.com,
        linux-doc@vger.kernel.org, "linux-efi" <linux-efi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rdunlap@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191112134640.16035-4-daniel.kiper@oracle.com>
References: <20191112134640.16035-4-daniel.kiper@oracle.com>
MIME-Version: 1.0
Message-ID: <157358123549.29376.9018722901282041797.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b3c72fc9a78e74161f9d05ef7191706060628f8c
Gitweb:        https://git.kernel.org/tip/b3c72fc9a78e74161f9d05ef7191706060628f8c
Author:        Daniel Kiper <daniel.kiper@oracle.com>
AuthorDate:    Tue, 12 Nov 2019 14:46:40 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Nov 2019 16:21:15 +01:00

x86/boot: Introduce setup_indirect

The setup_data is a bit awkward to use for extremely large data objects,
both because the setup_data header has to be adjacent to the data object
and because it has a 32-bit length field. However, it is important that
intermediate stages of the boot process have a way to identify which
chunks of memory are occupied by kernel data. Thus introduce an uniform
way to specify such indirect data as setup_indirect struct and
SETUP_INDIRECT type.

And finally bump setup_header version in arch/x86/boot/header.S.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: ard.biesheuvel@linaro.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: dave.hansen@linux.intel.com
Cc: eric.snowberg@oracle.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>
Cc: kanth.ghatraju@oracle.com
Cc: linux-doc@vger.kernel.org
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: rdunlap@infradead.org
Cc: ross.philipson@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191112134640.16035-4-daniel.kiper@oracle.com
---
 Documentation/x86/boot.rst             | 43 ++++++++++++++++++++++++-
 arch/x86/boot/compressed/kaslr.c       | 12 +++++++-
 arch/x86/boot/compressed/kernel_info.S |  2 +-
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 16 +++++++--
 arch/x86/kernel/e820.c                 | 11 ++++++-
 arch/x86/kernel/kdebugfs.c             | 21 +++++++++---
 arch/x86/kernel/ksysfs.c               | 31 +++++++++++++-----
 arch/x86/kernel/setup.c                |  6 +++-
 arch/x86/mm/ioremap.c                  | 11 ++++++-
 10 files changed, 138 insertions(+), 17 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 6cdd767..90bb8f5 100644
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
 Offset/size:	0x000c/4
 ============	==============
 
-  This field contains maximal allowed type for setup_data.
+  This field contains maximal allowed type for setup_data and setup_indirect structs.
 
 
 The Image Checksum
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c05..bb9bfef 100644
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
index 018dacb..f818ee8 100644
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
index 22dceca..97d9b6d 100644
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
index dbb4112..949066b 100644
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
index 7da2bcd..0bfe9a6 100644
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
index edaa30b..64b6da9 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -44,7 +44,12 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 	if (count > node->len - pos)
 		count = node->len - pos;
 
-	pa = node->paddr + sizeof(struct setup_data) + pos;
+	pa = node->paddr + pos;
+
+	/* Is it direct data or invalid indirect one? */
+	if (!(node->type & SETUP_INDIRECT) || node->type == SETUP_INDIRECT)
+		pa += sizeof(struct setup_data);
+
 	p = memremap(pa, count, MEMREMAP_WB);
 	if (!p)
 		return -ENOMEM;
@@ -108,9 +113,17 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			goto err_dir;
 		}
 
-		node->paddr = pa_data;
-		node->type = data->type;
-		node->len = data->len;
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			node->paddr = ((struct setup_indirect *)data->data)->addr;
+			node->type  = ((struct setup_indirect *)data->data)->type;
+			node->len   = ((struct setup_indirect *)data->data)->len;
+		} else {
+			node->paddr = pa_data;
+			node->type  = data->type;
+			node->len   = data->len;
+		}
+
 		create_setup_data_node(d, no, node);
 		pa_data = data->next;
 
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index 7969da9..d0a1912 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -100,7 +100,12 @@ static int __init get_setup_data_size(int nr, size_t *size)
 		if (!data)
 			return -ENOMEM;
 		if (nr == i) {
-			*size = data->len;
+			if (data->type == SETUP_INDIRECT &&
+			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+				*size = ((struct setup_indirect *)data->data)->len;
+			else
+				*size = data->len;
+
 			memunmap(data);
 			return 0;
 		}
@@ -130,7 +135,10 @@ static ssize_t type_show(struct kobject *kobj,
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
@@ -142,7 +150,7 @@ static ssize_t setup_data_data_read(struct file *fp,
 				    loff_t off, size_t count)
 {
 	int nr, ret = 0;
-	u64 paddr;
+	u64 paddr, len;
 	struct setup_data *data;
 	void *p;
 
@@ -157,19 +165,28 @@ static ssize_t setup_data_data_read(struct file *fp,
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
index 77ea96b..8f48bb8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -438,6 +438,12 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
+
+		if (data->type == SETUP_INDIRECT &&
+		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+			memblock_reserve(((struct setup_indirect *)data->data)->addr,
+					 ((struct setup_indirect *)data->data)->len);
+
 		pa_data = data->next;
 		early_memunmap(data, sizeof(*data));
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a39dcdb..1ff9c20 100644
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
