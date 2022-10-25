Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED960CEA1
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiJYOOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiJYOOH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:14:07 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F19DD83;
        Tue, 25 Oct 2022 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8023B40737B8;
        Tue, 25 Oct 2022 14:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8023B40737B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707244;
        bh=BGZ61LjohLBjygE9oVNsVrWMCWDIov1gXSSQiqeLX90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SymMFRIRU95Ul0iB2hpJ9bBIvRReWZh/5COfFoqPBngR8KXd+CachZ1l/QtlZ9HNP
         RHebtnBSiojalue+V6u6RF1XMm7iBPrBeTFX/dMEP1B92ftA0Eunjwy3sof/Z1eLMj
         TpHBPDaU7vIdiaptdvyFrHvnCeaqFKML7F7OKIlY=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 18/23] tools/include: Add simplified version of pe.h
Date:   Tue, 25 Oct 2022 17:12:56 +0300
Message-Id: <c6436f1a185d510e7f44bc72f8b387c4837fa357.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is needed to remove magic numbers from x86 bzImage building tool
(arch/x86/boot/tools/build.c).

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 tools/include/linux/pe.h | 150 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 tools/include/linux/pe.h

diff --git a/tools/include/linux/pe.h b/tools/include/linux/pe.h
new file mode 100644
index 000000000000..41c09ec371d8
--- /dev/null
+++ b/tools/include/linux/pe.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Simplified version of include/linux/pe.h:
+ *  Copyright 2011 Red Hat, Inc. All rights reserved.
+ *  Author(s): Peter Jones <pjones@redhat.com>
+ */
+#ifndef __LINUX_PE_H
+#define __LINUX_PE_H
+
+#include <linux/types.h>
+
+#define	IMAGE_FILE_MACHINE_I386		0x014c
+
+#define IMAGE_SCN_CNT_CODE	0x00000020 /* .text */
+#define IMAGE_SCN_CNT_INITIALIZED_DATA 0x00000040 /* .data */
+#define IMAGE_SCN_ALIGN_4096BYTES 0x00d00000
+#define IMAGE_SCN_MEM_DISCARDABLE 0x02000000 /* scn can be discarded */
+#define IMAGE_SCN_MEM_EXECUTE	0x20000000 /* can be executed as code */
+#define IMAGE_SCN_MEM_READ	0x40000000 /* readable */
+#define IMAGE_SCN_MEM_WRITE	0x80000000 /* writeable */
+
+#define MZ_HEADER_PEADDR_OFFSET 0x3c
+
+struct pe_hdr {
+	uint32_t magic;		/* PE magic */
+	uint16_t machine;	/* machine type */
+	uint16_t sections;	/* number of sections */
+	uint32_t timestamp;	/* time_t */
+	uint32_t symbol_table;	/* symbol table offset */
+	uint32_t symbols;	/* number of symbols */
+	uint16_t opt_hdr_size;	/* size of optional header */
+	uint16_t flags;		/* flags */
+};
+
+/* the fact that pe32 isn't padded where pe32+ is 64-bit means union won't
+ * work right.  vomit. */
+struct pe32_opt_hdr {
+	/* "standard" header */
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	uint32_t data_base;	/* relative data addr in ram */
+	/* "windows" header */
+	uint32_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint32_t stack_size_req;/* amt of stack requested */
+	uint32_t stack_size;	/* amt of stack required */
+	uint32_t heap_size_req;	/* amt of heap requested */
+	uint32_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct pe32plus_opt_hdr {
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	/* "windows" header */
+	uint64_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint64_t stack_size_req;/* amt of stack requested */
+	uint64_t stack_size;	/* amt of stack required */
+	uint64_t heap_size_req;	/* amt of heap requested */
+	uint64_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct data_dirent {
+	uint32_t virtual_address;	/* relative to load address */
+	uint32_t size;
+};
+
+struct data_directory {
+	struct data_dirent exports;		/* .edata */
+	struct data_dirent imports;		/* .idata */
+	struct data_dirent resources;		/* .rsrc */
+	struct data_dirent exceptions;		/* .pdata */
+	struct data_dirent certs;		/* certs */
+	struct data_dirent base_relocations;	/* .reloc */
+	struct data_dirent debug;		/* .debug */
+	struct data_dirent arch;		/* reservered */
+	struct data_dirent global_ptr;		/* global pointer reg. Size=0 */
+	struct data_dirent tls;			/* .tls */
+	struct data_dirent load_config;		/* load configuration structure */
+	struct data_dirent bound_imports;	/* no idea */
+	struct data_dirent import_addrs;	/* import address table */
+	struct data_dirent delay_imports;	/* delay-load import table */
+	struct data_dirent clr_runtime_hdr;	/* .cor (object only) */
+	struct data_dirent reserved;
+};
+
+struct section_header {
+	char name[8];			/* name or "/12\0" string tbl offset */
+	uint32_t virtual_size;		/* size of loaded section in ram */
+	uint32_t virtual_address;	/* relative virtual address */
+	uint32_t raw_data_size;		/* size of the section */
+	uint32_t data_addr;		/* file pointer to first page of sec */
+	uint32_t relocs;		/* file pointer to relocation entries */
+	uint32_t line_numbers;		/* line numbers! */
+	uint16_t num_relocs;		/* number of relocations */
+	uint16_t num_lin_numbers;	/* srsly. */
+	uint32_t flags;
+};
+
+struct coff_reloc {
+	uint32_t virtual_address;
+	uint32_t symbol_table_index;
+	uint16_t data;
+};
+
+#endif /* __LINUX_PE_H */
-- 
2.37.4

