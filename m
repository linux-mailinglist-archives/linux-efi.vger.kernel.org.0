Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E12FD8B9
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbhATSrJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388426AbhATRj6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLYnG2np6zR1YTUi6SYwuFsGaDYy69xYRKMeP5onVfI=;
        b=BH+Mq+om61isFKXPAO6czL7qRnSkQdVUt14pQpV5xXjTjxGDjxmU9oMRBq+smfmUaIyP+j
        XFniDxP6gx482SzAKyGl85PXOBjai70d5ZPHeCWh0YERB69m+tyCLpM+t5l2yIPtA6vVfa
        HJGh9JMOI4b/a7rY1Y8LMfv21rVnHOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-0IETbB0pMOW8PMvX7qS_JQ-1; Wed, 20 Jan 2021 12:38:26 -0500
X-MC-Unique: 0IETbB0pMOW8PMvX7qS_JQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5so997778wmq.0
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLYnG2np6zR1YTUi6SYwuFsGaDYy69xYRKMeP5onVfI=;
        b=FSo+Dgzjpxlx79mbPiHyyEklHVcBVZriYFoOZIkqDiMu/KjG/pGjBM3JWO10CMGXfQ
         CIcqfaacbXr9OyLwRTHaIMgrAUedLxK3KPmCHooAlXS3kK5IBCgiJC1fGn1fAQ1fKVRY
         y2L74meu9OPEmNlZLprDe4r1dBeM3X0/9smmZ+o743/895pfTj2VPjpUYY3i6Za6eRKS
         Ttexb+j1uSCMoKDhb3u/QCb+zg1unwTY3uuEF+4wIJx4F9/ng5Oayv2L+TOHijfKK3Wj
         16gUwAezXGTic/8MfS2svqXxpl1HcKl+bqPAYeplr+VIVI9ScghD8SGteo2Qp96wCjzX
         GHWQ==
X-Gm-Message-State: AOAM5327YkY70sH8XGS/gEPBUvBUlt3CUoOYgGWFbFnCAwd9wOcYixb+
        Bc8KmqvGTr3/RelRb2mEeYLBod60ByTwp2TKw6fYJHOrq+xLPMxlOhMTgttLY3ks74qetJbykLZ
        Vg5n3n81MhhfkyF+O+Ruj
X-Received: by 2002:adf:d187:: with SMTP id v7mr10468647wrc.50.1611164305257;
        Wed, 20 Jan 2021 09:38:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXI5rY8SF1/vD1xUKEd0IWosD2vQICkqK1CgWZpdLBSm0Mws61ej9sdam8XkbTpo9ZQuIaXQ==
X-Received: by 2002:adf:d187:: with SMTP id v7mr10468627wrc.50.1611164305073;
        Wed, 20 Jan 2021 09:38:25 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:24 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 09/17] objtool: arm64: Decode LDR instructions
Date:   Wed, 20 Jan 2021 18:37:52 +0100
Message-Id: <20210120173800.1660730-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Load literal instructions can generate constants inside code sections.
Record the locations of the constants in order to be able to remove
their corresponding "struct instruction".

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c    | 86 ++++++++++++++++++++++++++++
 tools/objtool/arch/x86/decode.c      |  5 ++
 tools/objtool/check.c                |  3 +
 tools/objtool/include/objtool/arch.h |  3 +
 4 files changed, 97 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 1087ede67bcd..b4d4d5b051b0 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -30,6 +30,73 @@ static unsigned long sign_extend(unsigned long x, int nbits)
 	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
 }
 
+struct insn_loc {
+	const struct section *sec;
+	unsigned long offset;
+	struct hlist_node hnode;
+	bool ignorable;
+};
+
+DEFINE_HASHTABLE(invalid_insns, 16);
+
+static int record_invalid_insn(const struct section *sec,
+			       unsigned long offset,
+			       bool ignore)
+{
+	struct insn_loc *loc;
+	struct hlist_head *l;
+
+	l = &invalid_insns[hash_min(offset, HASH_BITS(invalid_insns))];
+	if (!hlist_empty(l)) {
+		loc = hlist_entry(l->first, struct insn_loc, hnode);
+		loc->ignorable |= ignore;
+		return 0;
+	}
+
+	loc = malloc(sizeof(*loc));
+	if (!loc) {
+		WARN("malloc failed");
+		return -1;
+	}
+
+	loc->sec = sec;
+	loc->offset = offset;
+	loc->ignorable = ignore;
+
+	hash_add(invalid_insns, &loc->hnode, loc->offset);
+
+	return 0;
+}
+
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	struct hlist_node *tmp;
+	struct insn_loc *loc;
+	unsigned int bkt;
+	int res = 0;
+
+	hash_for_each_safe(invalid_insns, bkt, tmp, loc, hnode) {
+		struct instruction *insn;
+
+		insn = find_insn(file, (struct section *) loc->sec, loc->offset);
+		if (insn) {
+			if (loc->ignorable) {
+				list_del(&insn->list);
+				hash_del(&insn->hash);
+				free(insn);
+			} else {
+				WARN_FUNC("can't decode instruction", insn->sec, insn->offset);
+				return -1;
+			}
+		}
+
+		hash_del(&loc->hnode);
+		free(loc);
+	}
+
+	return res;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -359,6 +426,25 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	case AARCH64_INSN_CLS_LDST:
 		if (arm_decode_load_store(insn, type, immediate, ops_list))
 			break;
+		if (aarch64_insn_is_ldr_lit(insn)) {
+			long pc_offset;
+
+			pc_offset = insn & GENMASK(23, 5);
+			/* Sign extend and multiply by 4 */
+			pc_offset = (pc_offset << (64 - 23));
+			pc_offset = ((pc_offset >> (64 - 23)) >> 5) << 2;
+
+			if (record_invalid_insn(sec, offset + pc_offset, true))
+				return -1;
+
+			/* 64-bit literal */
+			if (insn & BIT(30)) {
+				if (record_invalid_insn(sec,
+							offset + pc_offset + 4,
+							true))
+					return -1;
+			}
+		}
 		*type = INSN_OTHER;
 		break;
 	default:
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 6baa22732ca6..e76d987ce3c7 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -549,6 +549,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	return 0;
 }
 
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	return 0;
+}
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 270b507e7098..d902697a388e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -319,6 +319,9 @@ static int decode_instructions(struct objtool_file *file)
 	if (stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
+	if (arch_post_process_instructions(file))
+		return -1;
+
 	return 0;
 
 err:
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6ff0685f5cc5..456d0465b676 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -66,6 +66,7 @@ struct stack_op {
 	struct list_head list;
 };
 
+struct objtool_file;
 struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
@@ -76,6 +77,8 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
+int arch_post_process_instructions(struct objtool_file *file);
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
-- 
2.25.4

