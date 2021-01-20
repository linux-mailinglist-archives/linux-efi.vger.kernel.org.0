Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C2FD968
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbhATSqu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387639AbhATRjo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZtUwFLGKmTk06Edz7BP1qawZG5Xl7GI1AIkrnSV6+8=;
        b=IbsvKK112hiMdhuwKjf4eSo24x9YHf2cMwNqvCDss+YYJkUuwBsL8f+c7EABtrBg2M4yz3
        dhWrk8MzdhbSnfbAsalQwfvKJDVNmCdhebFr5yQqopAC4TXsCrGdMFPeabSWJe6N+J/2Fj
        zRhF171Xsl5Rwovy85HV8FXNsPU9UI0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-PoKeTDBYPKCg4XOQKt15aw-1; Wed, 20 Jan 2021 12:38:14 -0500
X-MC-Unique: PoKeTDBYPKCg4XOQKt15aw-1
Received: by mail-wr1-f70.google.com with SMTP id l10so11562341wry.16
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZtUwFLGKmTk06Edz7BP1qawZG5Xl7GI1AIkrnSV6+8=;
        b=gPw5bLVGvhXqWYL0+sxp6ZyBh1OvqHap3GWnxOHZHuxArYhZPFWtTrvnH/PB+euS2G
         8Zz0dsokg6g0Nx1X2LzTvi2Zss39p0V10+Ru9c87v3zRQu8CJAmrrjI6NQCobOREd/F9
         eME98GL86OunHtgDJe/VgQlr59NtmVvmOjYeyy2GA+57CEwwBxcyLpgg5N34KwEVhDIp
         bccckRyGAD6UE/voQl6rxIf0hLvYeJRvMn3PODG7vGboohBEQyOvSb/47+HSqYF5nRK7
         PuxLkIUQBGalw+1JoKxu0LRspu7TVd7Af3kk3kN6vMjWcX66wG1TlcSR98wW+5BkYwaG
         DfZQ==
X-Gm-Message-State: AOAM530pQz9mWoiY/zLxdgmk5m4SpUyd+q2ayCGVUTTdQ9F05T/2KPiu
        VEyMDVEigRs9Y1k0wa9lGbVdc0bW43FJD3lxGA9w5Vjbl5hmAUxdXMWKehiIbfWXoiQ3f27M6aT
        CQCnLpK8/dnmPoVH9slif
X-Received: by 2002:adf:9e47:: with SMTP id v7mr10339900wre.185.1611164292796;
        Wed, 20 Jan 2021 09:38:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmMRPghUxsaTRcr7FJKWN0wZkptspY3JLpZpcYt8/LaAizFtPfNbXSDn+oQyq+nhU2NDK7sQ==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr10339890wre.185.1611164292653;
        Wed, 20 Jan 2021 09:38:12 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:12 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 04/17] objtool: arm64: Add base definition for arm64 backend
Date:   Wed, 20 Jan 2021 18:37:47 +0100
Message-Id: <20210120173800.1660730-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide needed definitions for a new architecture instruction decoder.
No proper decoding is done yet.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile                        |   5 +
 tools/objtool/arch/arm64/Build                |   8 ++
 tools/objtool/arch/arm64/decode.c             | 130 ++++++++++++++++++
 .../arch/arm64/include/arch/cfi_regs.h        |  14 ++
 tools/objtool/arch/arm64/include/arch/elf.h   |   6 +
 .../arch/arm64/include/arch/endianness.h      |   9 ++
 .../objtool/arch/arm64/include/arch/special.h |  21 +++
 tools/objtool/arch/arm64/special.c            |  21 +++
 tools/objtool/sync-check.sh                   |   5 +
 9 files changed, 219 insertions(+)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 92ce4fce7bc7..d5cfbec87c02 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -47,6 +47,11 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
+ifeq ($(SRCARCH),arm64)
+	SUBCMD_CHECK := y
+	CFLAGS  += -Wno-nested-externs
+endif
+
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
new file mode 100644
index 000000000000..f3de3a50d541
--- /dev/null
+++ b/tools/objtool/arch/arm64/Build
@@ -0,0 +1,8 @@
+objtool-y += special.o
+objtool-y += decode.o
+
+objtool-y += libhweight.o
+
+$(OUTPUT)arch/arm64/libhweight.o: ../lib/hweight.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
new file mode 100644
index 000000000000..8ae822f553ca
--- /dev/null
+++ b/tools/objtool/arch/arm64/decode.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+/* Hack needed to avoid depending on brk-imm.h */
+#define FAULT_BRK_IMM	0x100
+
+#include <asm/aarch64-insn.h>
+
+#include <objtool/check.h>
+#include <objtool/arch.h>
+#include <objtool/elf.h>
+#include <objtool/warn.h>
+
+#include <arch/cfi_regs.h>
+
+/* Hack needed to avoid depending on kprobes.h */
+#ifndef __kprobes
+#define __kprobes
+#endif
+
+#include "../../../arch/arm64/lib/aarch64-insn.c"
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case AARCH64_INSN_REG_19:
+	case AARCH64_INSN_REG_20:
+	case AARCH64_INSN_REG_21:
+	case AARCH64_INSN_REG_22:
+	case AARCH64_INSN_REG_23:
+	case AARCH64_INSN_REG_24:
+	case AARCH64_INSN_REG_25:
+	case AARCH64_INSN_REG_26:
+	case AARCH64_INSN_REG_27:
+	case AARCH64_INSN_REG_28:
+	case AARCH64_INSN_REG_FP:
+	case AARCH64_INSN_REG_LR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->immediate;
+}
+
+const char *arch_nop_insn(int len)
+{
+	static u32 nop = 0;
+
+	if (len != AARCH64_INSN_SIZE)
+		WARN("invalid NOP size: %d\n", len);
+
+	if (!nop)
+		nop = aarch64_insn_gen_nop();
+
+	return (const char*)&nop;
+}
+
+static int is_arm64(const struct elf *elf)
+{
+	switch (elf->ehdr.e_machine) {
+	case EM_AARCH64: //0xB7
+		return 1;
+	default:
+		WARN("unexpected ELF machine type %x",
+		     elf->ehdr.e_machine);
+		return 0;
+	}
+}
+
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+{
+	return -1;
+}
+
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	u32 insn;
+
+	if (!is_arm64(elf))
+		return -1;
+
+	if (maxlen < AARCH64_INSN_SIZE)
+		return 0;
+
+	*len = AARCH64_INSN_SIZE;
+	*immediate = 0;
+
+	insn = *(u32 *)(sec->data->d_buf + offset);
+
+	switch (aarch64_get_insn_class(insn)) {
+	case AARCH64_INSN_CLS_UNKNOWN:
+		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
+		return -1;
+	default:
+		*type = INSN_OTHER;
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/arch/cfi_regs.h b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..43ad56b6c3f9
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#include <asm/aarch64-insn.h>
+
+#define CFI_BP			AARCH64_INSN_REG_FP
+#define CFI_RA			AARCH64_INSN_REG_LR
+#define CFI_SP			AARCH64_INSN_REG_SP
+
+#define CFI_NUM_REGS		32
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/elf.h b/tools/objtool/arch/arm64/include/arch/elf.h
new file mode 100644
index 000000000000..a31a29b1a386
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/elf.h
@@ -0,0 +1,6 @@
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_AARCH64_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/arm64/include/arch/endianness.h b/tools/objtool/arch/arm64/include/arch/endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objtool/arch/arm64/include/arch/special.h
new file mode 100644
index 000000000000..a82a9b3e51df
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/special.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ARM64_ARCH_SPECIAL_H
+#define _ARM64_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		8
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
new file mode 100644
index 000000000000..45f283283091
--- /dev/null
+++ b/tools/objtool/arch/arm64/special.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <objtool/special.h>
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+}
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				     struct instruction *insn)
+{
+	return NULL;
+}
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5e929f..69e7ebe8911b 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -21,6 +21,11 @@ arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
 arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
 arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+elif [ "$SRCARCH" = "arm64" ]; then
+FILES="$FILES
+arch/arm64/include/asm/aarch64-insn.h -I '^#include [\"<]\(asm/\)*brk-imm.h[\">]'
+arch/arm64/lib/aarch64-insn.c         -I '^#include [\"<]\(asm/\)*kprobes.h[\">]'
+"
 fi
 
 check_2 () {
-- 
2.25.4

