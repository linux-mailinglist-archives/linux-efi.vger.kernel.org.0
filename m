Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4C2FD8BD
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbhATSrc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390156AbhATRkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=eqojv05tKpkrWvVh6rF5Qcj8bp4JrIvQEj0sDladv/cTL8YKVZW2DgRq6dsiAXLTu5dlsb
        XjUY5tjFX7dUKXmRnEGYOQUVRYh0BXE5i0TPBzTQwYNoSfYxmPye98CY/rIr+BEXRZZvlU
        E4YlD/kBFFVLtc9K2CLbMIdzkZNEzow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-UDSbkgCIPr69vNnAO5LMcg-1; Wed, 20 Jan 2021 12:38:43 -0500
X-MC-Unique: UDSbkgCIPr69vNnAO5LMcg-1
Received: by mail-wm1-f69.google.com with SMTP id u67so1887403wmb.0
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=DW6Cjp/HRs0eMzBuW3F90OB0Nz6VgONbosDXoRAproz2J8T+dWufIiT3I0XF9IVfPA
         VXnFUde4/5zYi02B9BYq/HEMBd11rXMgGxq3qkEdHPJg9/RTeSVPxjaNRqzr8J3lFA/h
         /fsL78iu8IN03JEgWKN+ngYZ9t1dp5WKqkAy2DH9cObcWjoiLQNgjT3843xitfePayje
         gi2EEYNZYYtyJDvSWFl15vMp53Ku/3RREIBuodtCtl9T6mtD7UN6Xj0TNb59DshtQQXB
         oD/8yujMhIrLGginmWZouwsbGBYBzG3ovhVFbbcJnUE28zvgXsWkQ2wENYzC7lYf9zME
         49qA==
X-Gm-Message-State: AOAM530GgLWzr+V3HvzE8VQEVZNTscxqUr9jS+JgVKez13wLMwczRzlw
        j+tBi3nQpLm5g6fmBjNVvsO+ru85Wqomw8vc60qFmRCLMTLk7+1L7KfbSm1aJcVrWJEVrHsgyVC
        U4CSGvHRoN/t/dgm0ja//
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468150wri.373.1611164322333;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEuPLL/MUsHXrjcP2RWYCjypmma6HnlV61saf901CvvVF6JcK5tnGFyGuV8565mW/HkAJnQw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468144wri.373.1611164322230;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:41 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 15/17] objtool: arm64: Handle supported relocations in alternatives
Date:   Wed, 20 Jan 2021 18:37:58 +0100
Message-Id: <20210120173800.1660730-16-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Based on get_alt_insn() in arch/arm64/kernel/alternative.c, arm64
alternative code adapts offsets for static branches and adrp
instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index c9c3e0bfd581..d47e5590ed60 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -30,7 +30,11 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	return false;
+	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
+
+	return aarch64_insn_is_branch_imm(opcode) ||
+	       aarch64_insn_is_adrp(opcode) ||
+	       !aarch64_insn_uses_literal(opcode);
 }
 
 static struct section *get_switch_table_info_section(struct objtool_file *file)
-- 
2.25.4

