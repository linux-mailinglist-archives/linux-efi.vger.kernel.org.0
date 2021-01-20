Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09C02FD8BC
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbhATSrM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390159AbhATRkO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=D3qNyoZVcvH8C0V2VVeWeUCOpamLcnYtoxeqHM4csD5Ul+uhJD07H9Ep/K+ziBElpjZDdp
        C8hfmdy9wmXUZFJz80GrkVHSUkVzOCb4UNijqSEb2mGDz4c85OdnAa3DWu6UeU86KZFlPc
        0y840ETW9Yxp9W8L5+oDauA8Y3TQEcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-N92naAeXMVy1f0CzKoWd9w-1; Wed, 20 Jan 2021 12:38:43 -0500
X-MC-Unique: N92naAeXMVy1f0CzKoWd9w-1
Received: by mail-wm1-f69.google.com with SMTP id s24so1831824wmj.3
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=aLqOLdAMUYesM3osgNtqeBnt9wk2sRvW8trhOVWyECw22u7cWkmq+NYYxP0R6RQDko
         xSXa7tr49x+lQAQ4Kfu+ZvPEMwbt/O15fKQHefG1RJ59ul9ocg1W0WXMzxG68XLWPWHd
         OcXTD3wITSwLVZHpzuSllRMH30X96cn2tFZn7MSfQHtwJoGf0QeffLkPKrmKo8q1g5oL
         286DfBACeRsAQW0ow2qoV2xiGzbFydgkz+1YC4wkjqM1xdLEAyjvbsXAyA85+3c+UnYB
         kczyecCyM6ji4fDgscR4UP4bZ+Ncvaa3LH4jTJUDEQfgXpkgHoEj4GuwT77jLWYsSZsm
         NmCQ==
X-Gm-Message-State: AOAM533aC9Q49jbbX7s0zUFSimsKVV32WQaLzi1j8yT5/3fhE68OHfJ8
        H69MnP1OFsDShPCaEbQQMVcYhv2a+epO6e5A7m3t2zVi4uB9CddiRUp/P3EzRzwRrW9ie6SOEPB
        Kl+kFc4XFcVaqh+ZSRIU3
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344309wrr.142.1611164320484;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDeWheflvYEpolU09LBJTJ+72qBUJL1UqdbbjxQT7QJExRg0tyCLTSK2CpCQqblVViiEwsaA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344296wrr.142.1611164320375;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 14/17] objtool: arm64: Cache section with switch table information
Date:   Wed, 20 Jan 2021 18:37:57 +0100
Message-Id: <20210120173800.1660730-15-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Section ".discard.switch_table_info", created by the gcc plugin will
be looked up for every dynamic jump in the object file while the section
might not even exist.

Cache the result of the first lookup.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 396b9c5feebd..c9c3e0bfd581 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -33,6 +33,19 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+static struct section *get_switch_table_info_section(struct objtool_file *file)
+{
+	static bool first = true;
+	static struct section *info_section = NULL;
+
+	if (first) {
+		first = false;
+		info_section = find_section_by_name(file->elf,
+						    ".discard.switch_table_info");
+	}
+
+	return info_section;
+}
 
 /*
  * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
@@ -64,8 +77,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	void *sti_sec_start;
 	struct reloc *text_reloc;
 
-	table_info_sec = find_section_by_name(file->elf,
-					      ".discard.switch_table_info");
+	table_info_sec = get_switch_table_info_section(file);
 	if (!table_info_sec)
 		goto try_c_jmptbl;
 
-- 
2.25.4

