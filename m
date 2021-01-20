Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5F2FD96F
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbhATSrQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390201AbhATRkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GqcdDd08Zk15EP4JDTkI5z15oNQedvKunbBtce3hNY=;
        b=WJRLkgvbY5DXeyGg+gO6NxUuotjuuSXTKqmR+EzbiByNmPyy9A0XUX3cUXqp+iPbdaZMwC
        E4kVaGCgwG+3lJigD7ZLcSjMxBoTI4nJF/2iob2zGpgatyzgUQah0pH+/Rr8hETzZZdnkm
        NX0iONWzYds7ufii7etU1I1c+gayre0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-lu62xhX5P1-FwCTqbKUMIQ-1; Wed, 20 Jan 2021 12:38:45 -0500
X-MC-Unique: lu62xhX5P1-FwCTqbKUMIQ-1
Received: by mail-wr1-f71.google.com with SMTP id q2so11966073wrp.4
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GqcdDd08Zk15EP4JDTkI5z15oNQedvKunbBtce3hNY=;
        b=IEDWjfoIGlFl2p0+yE0czt8sOJ6hnOAAOcghrFfwJ4DrSseqAtx9BxPYbW/GOKqK3y
         yjzpXYuti0z6yMiY3P9wKron+kUIj8MN/Q1ZOlPLa9queX0+7rXttQUaxfBiXFyo0rZR
         EDF95lo5FdL1M+ZlGfvSt6p+kkE2rk2gDXSQ8Ro2dlXIDQxQKeMgTwyW8SmPVobgC13R
         iCZSuEMtjr9AznpG6o+oti+K5UrbAt7hmTAxFVQS1FyMdiy57g925DsKwg9xaYkI0TVt
         LYIXsWZsekurBmCW60GC3yTsP65tKRCKFkNmcjpm8McPTfzMFMSxGuZxXW5rwsdiwa6t
         BK/w==
X-Gm-Message-State: AOAM532jIWwwOzrJdrsb0U6ceVNOgEqwAP6y0zEYtS0y8hgzY8s2vVeQ
        90Sj+8vZIZigYa4SFAiVi9k0JQAQlb5v8hiXTgEdcBd8ZyPg9Y8XKiG02/Kxm4EaEPMwJUh9olQ
        JRs2WDBMQkIWXRn7TrrEa
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr5525600wmc.36.1611164323970;
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3m5zpvqhoSgn4NA796inwCeJU9v3FtPD1K/BYY6WVb/FI0tRzJHQ322lTzH3clEsPdXWdpg==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr5525587wmc.36.1611164323845;
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 16/17] objtool: arm64: Ignore replacement section for alternative callback
Date:   Wed, 20 Jan 2021 18:37:59 +0100
Message-Id: <20210120173800.1660730-17-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

ARM64_CB_PATCH doesn't have static replacement instructions. Skip
trying to validate the alternative section.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 12 ++++++++++++
 tools/objtool/check.c              |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index d47e5590ed60..aff8577e71e9 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -24,6 +24,18 @@ struct switch_table_info {
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	if (alt->orig_len && !alt->new_len) {
+		/*
+		 * ARM64_CB_PATCH has no alternative instruction.
+		 * a callback is called at alternative replacement time
+		 * to dynamically change the original instructions.
+		 *
+		 * ARM64_CB_PATCH is the last ARM64 feature, it's value changes
+		 * every time a new feature is added. So the orig/alt region
+		 * length are used to detect those alternatives
+		 */
+		alt->skip_alt = true;
+	}
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d902697a388e..8840af09f843 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1182,6 +1182,9 @@ static int add_special_section_alts(struct objtool_file *file)
 				continue;
 			}
 
+			if (special_alt->skip_alt && !special_alt->new_len)
+				continue;
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.25.4

