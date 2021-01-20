Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56CD2FD8B5
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbhATSqo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387459AbhATRjk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=eRFp/dslELn1Z1K8T71nM0v6M9sdr6YvkLoStbkmEJEkXd3ZD4OYVesbtGP+C71U/y8C9n
        RRgPs1DCiqpljKunWApaWRGpNVr/ZPjLRuru626s9yUsCWAMuRaNVsSp48P2pcks0/lo+5
        I7hBgjEZmLB6j5DIDxlvTggHejsaBVw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-H02AeYduP--NCI5z1ZIApw-1; Wed, 20 Jan 2021 12:38:11 -0500
X-MC-Unique: H02AeYduP--NCI5z1ZIApw-1
Received: by mail-wr1-f71.google.com with SMTP id r8so11922927wro.22
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=J8+Z9FoG1q0GJHVWzzzE2thXikP7PMpFEW0mEuKiFZc4d8J3L4k312jPsyScL43nhd
         Yy50uIMFQWIITxI2o9rfF0mbjuAa7Z29XcwxP1AA2VJ4laWB4VMzpvn1EVSMabCs2zKR
         S3p4hD54Xg1wJ0mUPZWshcWflegbim16Sb3IOTu3Fm90rJdxnsIRbM+Mqcpq1fFEKZju
         JJ2Bkx7LEvdrlihHCVSR/xfiHKgW5HrUmeHqyK4jKbPzHt8z1GkwzRuxtKJpFac6kfij
         rgithp9fJkWnuoLaISpQh24t5fyOJSZ2DD5hixV2HH1uvjeSldPdbPgKp0WdwyGbm11t
         fpig==
X-Gm-Message-State: AOAM531jhHGz4jG0POGPDYmXSz++ax65yftaGjB98jCgmLqR9SaunlAx
        xSFad/Ee5US/MlR8N5MHAb7Sra2ZCJTF6S9uAoddxmSGvNkjxufyNNNmhfYuNR69ERCmQXvwild
        mIXBVM3KVlsLVPOZXDoib
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316323wrh.414.1611164290573;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsXKBygCbH5ehSM3hv+i9wV2hjiG6FmiP83Wor2Wz+s8QTVOj8s3jD6nPK36EhOefk08Au5A==
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316310wrh.414.1611164290420;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:08 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 03/17] tools: bug: Remove duplicate definition
Date:   Wed, 20 Jan 2021 18:37:46 +0100
Message-Id: <20210120173800.1660730-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Under tools, bug.h only defines BUILD_BUG_ON_ZERO() which is already
defined in build_bug.h. This prevents a file to include both headers at
the same time.

Have bug.h include build_bug.h instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/linux/bug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
index 85f80258a15f..548be7cffa8e 100644
--- a/tools/include/linux/bug.h
+++ b/tools/include/linux/bug.h
@@ -2,10 +2,6 @@
 #ifndef _TOOLS_PERF_LINUX_BUG_H
 #define _TOOLS_PERF_LINUX_BUG_H
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#include <linux/build_bug.h>
 
 #endif	/* _TOOLS_PERF_LINUX_BUG_H */
-- 
2.25.4

