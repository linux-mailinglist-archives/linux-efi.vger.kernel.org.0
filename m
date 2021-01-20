Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D492FD8C1
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 19:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbhATSrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390320AbhATRkR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=OYOW84UWpt+8SUrCbZAXXaai1E8SVi2esOyGtPEoAUgM7Ykdk5Hpeb+9DLL21tqsH6r2c2
        WHoxF3GgSNVb+Bp6M4i2GrHcIBBfXJjDRhcG7mp62wSQ0mUAkReXWpz5vehfRIHKxKGlQY
        zuMEMbZD9XgFe7fuOSGjQ9k4W4vUJgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-svp07V-tOqOl1PmP0_VJlA-1; Wed, 20 Jan 2021 12:38:47 -0500
X-MC-Unique: svp07V-tOqOl1PmP0_VJlA-1
Received: by mail-wm1-f70.google.com with SMTP id f16so1819356wmq.7
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=A2OHoZSgODa1ImkGqbgpFXTisvYUbCegR4CphhLKci02K6m3Stw/Um8w9/5w2v/1O6
         G2IMcVv9K2l3Ublt+AX/JHfobjkAPupp5d7/hvWnPi31xd2tRozLbA+w9a+qxVrH/+x/
         GekVTFkhohfu6UL8ad61qJ8MosrQDxiPYrt/rDsac+5NHCuE6YA7VJv5HaMGOVUsnrWE
         RyFqB3P/WeTEBxXiKBDHD3RpW9eU20gdfBpiQnx4XFSEOU0YIctY9GVyQkoC5VOdobsr
         r0n64KqKNiwUXAkB4qYvwP9GiIeeNPLf9KzUXMsEEC17mYDyvsUCLxIX0wOPhZwCdt+s
         WKXA==
X-Gm-Message-State: AOAM531xpVm+L4PvXD7i9HTQObiC1MtUcj6icwt0Z8+P3XUlsISvFpWo
        V6BV1klabviI172hG/R4MCIzyF9TgUyNHd/zsXLVqJdm0efI8o8ts9uxdGmCmwT5G5dfPbRNsqS
        VKPnmfaYBYV47P4UTJdeg
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387434wme.37.1611164326104;
        Wed, 20 Jan 2021 09:38:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTEEAVF5Wb5DvfyKAa6iIpcJZxKaj/uKR/NeIqD5Cr6bWjyZklj7zuAijYtvvTiqRBg2VXRA==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387418wme.37.1611164325951;
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 17/17] objtool: arm64: Enable stack validation for arm64
Date:   Wed, 20 Jan 2021 18:38:00 +0100
Message-Id: <20210120173800.1660730-18-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add build option to run stack validation at compile time.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93a320cc8e03..3f297d61b56b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -185,6 +185,7 @@ config ARM64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STACK_VALIDATION if CC_IS_GCC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-- 
2.25.4

