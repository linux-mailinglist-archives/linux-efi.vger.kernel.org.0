Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8D2FD96B
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbhATSrG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387744AbhATRjv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=gUFlrtaEr7qsAtT1h1dRYUW3jycPC8WQ4rOwmnolbIFHWNmPUoEhd6J++ryIQ0s/4aMX4U
        +XKqAMBV2pEgXfgpI1fPA8ZOlCv7uyZBsetDiK01L6ScObo2dYZ3GzBRCT7EWQQeUILb0c
        Ow4KS0HV9M9C3pA6pW0OnT9vzBflld8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-cun7JWzdMV64Uq3rRnKJgg-1; Wed, 20 Jan 2021 12:38:22 -0500
X-MC-Unique: cun7JWzdMV64Uq3rRnKJgg-1
Received: by mail-wr1-f69.google.com with SMTP id d7so2797307wri.23
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=MAvxrf708ViZ9jnXrGWKsiEDgKqnikbnkiiKyb47zNQBE0NPdryi11TFWUFt6R0EOo
         QG6SVgTbma0XW6S+clPLZgWciod2vhG7oWM61DX19ETtPqvJZ6joc9iz7T6tM3rBBMdV
         HT52pcRxAWu1/ysm0H/9uyuPGw2aIh0GBTeCYEd6cONG+vQ9Zx1pRov2DxLy1/qB8Oi7
         gd5UiktMKukt9JZ48tcgjGFn7Nqpa04ivFtoWuDNMXubS4prFibHBij+Uh+4k0rQLGzL
         9MueD2Vz3TqtyGVWi9aZ5XXi4uFNDw+lwlwXnbB0ZexnNUcH+olr+firAe8XG0lX5FzP
         dBEA==
X-Gm-Message-State: AOAM532fa/vDtqbUWTZM4TLRp0MIA9zoe5dJwKVtxAefMFCHqzh9fqht
        W6hb/eKcEniWHUXVpIOSVJY0dK5w8BVWMtTbnWDslzwqgQy2P7rgoBteln7TN7gRfxcbl25JIbe
        XpXcJM98/hH4k1s2TFTpY
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531780wru.291.1611164300887;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5Gt3Pu1qW2EdggZtB7MguFp/4lDK5HfkXjM4AsXdknZgXR2j5+4eIlyKpZr1CO2oaPexByA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531762wru.291.1611164300731;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 07/17] objtool: arm64: Decode other system instructions
Date:   Wed, 20 Jan 2021 18:37:50 +0100
Message-Id: <20210120173800.1660730-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Decode ERET, BRK and NOPs

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 924121b4b466..a4a587c400a1 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -223,6 +223,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* Remaining branch opcodes are conditional */
 			*type = INSN_JUMP_CONDITIONAL;
 			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_eret(insn)) {
+			*type = INSN_CONTEXT_SWITCH;
+		} else if (aarch64_insn_is_steppable_hint(insn)) {
+			*type = INSN_NOP;
+		} else if (aarch64_insn_is_brk(insn)) {
+			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
+			*type = INSN_BUG;
 		} else {
 			*type = INSN_OTHER;
 		}
-- 
2.25.4

