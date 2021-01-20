Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413442FD96D
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbhATSrI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388711AbhATRj6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=bLssEi5fnN4xUMa1/lfSXAslVrhp3VFTatskxRi6mNlR3KiMxE3C/on9ovYWGB6KtrrZl0
        qnfN5BFcrSpDOGHIJa6ZVtCMP0XIpV94Aug1L5P2yFe0JD+fV5gdG81e32vlvNB2gdZvTw
        sPbz1ZzjvUrCvXIpXxx1KTYVkRmRpyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-6sEN8mhEPlCz24vWKAqUAw-1; Wed, 20 Jan 2021 12:38:30 -0500
X-MC-Unique: 6sEN8mhEPlCz24vWKAqUAw-1
Received: by mail-wr1-f71.google.com with SMTP id q18so11966435wrc.20
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=qEEiYMqNXaS8ZXN6yvYgJX+C+6bKHXoN7F0HabPIJkVQVIZZRWHaR5eAFvdXqn9mb0
         2p6Lj2aR0I5C4qivjZ14+Ppi7zrMPOLT1Ofv1mrFDdU5fEY8uV7N1aCn+nF2SrjDf28k
         R81GeeQ254jMvty6vXEUzttz0qNfcC3CSOmrA9A9m3+mhEGsO4nSLwlMbmBzg/FPiAUT
         LtlV2hiplE7fL6b+voGbZl+QShKoGcnGgzjqLa2+hg6sP4Ep7t8ueERsbHJm8Phx/ITj
         iwNptWd/QWo/O4Htjs/tGttptFD1yeqikmfDe9sIkLMnND6RPx6oiIACe4zpgoFhC+ax
         MDVw==
X-Gm-Message-State: AOAM530tO7eA0379CPDI//q5O7+I29ELmzRQpT2HJUVbU6uM6Zvdb+wD
        Lp8+IXwTw2MIlEo0Q3zxwyD89dzVk/UWsBeL/rY1fkL+/LZZJu8axFxUjfokWu/crjbsExU2PiB
        KRJOjC2h5S63gPfNAIE0p
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442917wme.21.1611164309133;
        Wed, 20 Jan 2021 09:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdkiqIhQMa9qAcvB3y1xPRPRu1ifQGBBsVjTbJnRN8ssR5UHer5yLxDQqnoMtLa25rFV9xTQ==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442896wme.21.1611164308963;
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 10/17] objtool: arm64: Accept padding in code sections
Date:   Wed, 20 Jan 2021 18:37:53 +0100
Message-Id: <20210120173800.1660730-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The compiler can introduce some '0' words in code sections to pad the
end of functions.
Similar to load literal functions, record these zero words to remove
the "struct instruction" created for them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index b4d4d5b051b0..ed5ef0b52bbe 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -362,8 +362,23 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	switch (aarch64_get_insn_class(insn)) {
 	case AARCH64_INSN_CLS_UNKNOWN:
-		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
-		return -1;
+	{
+		/*
+		 * There are a few reasons we might have non-valid opcodes in
+		 * code sections:
+		 * - For load literal, assembler can generate the data to be
+		 *   loaded in the code section
+		 * - Compiler/assembler can generate zeroes to pad function that
+		 *   do not end on 8-byte alignment
+		 */
+		/* Compiler might put zeroes as padding */
+		if (record_invalid_insn(sec, offset, insn == 0x0))
+			return -1;
+
+		*type = INSN_OTHER;
+
+		break;
+	}
 	case AARCH64_INSN_CLS_DP_IMM:
 		/* Mov register to and from SP are aliases of add_imm */
 		if (aarch64_insn_is_add_imm(insn) ||
-- 
2.25.4

