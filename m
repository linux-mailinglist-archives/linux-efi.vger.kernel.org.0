Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104AB11D89E
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfLLVer (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 16:34:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39980 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731086AbfLLVer (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 16:34:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so35789qkg.7
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 13:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzhDclgt4wr1Bn7jb+ojQoXbYLOpj5Ctg783GxIkMtA=;
        b=JKB09/hpoDn6R85wyS6undDxf9sTFe95KPWvR8OWLwJIIpBBwcR+32edwfqQyDG84d
         C7ib1HvYOGLW8jESP5+9mSD2O2qci4Te6D/4f9TzhS27wPen/Wz/5V0LZAQS6GnRXaW4
         f0Yjdz5vd57Jl1IKXsxO6KgjpKjorDmwS2zoyweSB5YhY1uduBv6IrfPSdgucvWM4p66
         F3niAm58nj0fY6VqNOkesSEKgAWNEdbtz/cp696/00p9thblB2Ztxk4TTpMyJi9VZZZy
         2+LbwpHhFQcjswY29cuNC0JxE/TxvCVtwpm/Gv+o38iwtz2JiTyo8lkC+hwupL8pLZ+1
         I45Q==
X-Gm-Message-State: APjAAAX/BZTeFUTfUBTs5PoRPHOhvsFytlth7acwhWDC73k2sDq0qMjt
        tu3/6fISnE8b3eE0bxjDlE8=
X-Google-Smtp-Source: APXvYqymvvg64QgHa7L8gUXUsy/3iy4o7d3Lqy2NZ6jmYgSHANFy/Qw0LYaLK84224smBRmhkcEeiA==
X-Received: by 2002:a05:620a:1307:: with SMTP id o7mr10282161qkj.312.1576186486492;
        Thu, 12 Dec 2019 13:34:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm2116467qkf.44.2019.12.12.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:34:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 2/5] efi/gop: Remove unused typedef
Date:   Thu, 12 Dec 2019 16:34:40 -0500
Message-Id: <20191212213443.24128-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212213443.24128-1-nivedita@alum.mit.edu>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We have stopped using gop->query_mode(), so remove the unused typedef
for the function prototype.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/efi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index bffe6e0a9b53..8be59ec77dee 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1479,10 +1479,6 @@ struct efi_graphics_output_protocol {
 	struct efi_graphics_output_protocol_mode *mode;
 };
 
-typedef efi_status_t (*efi_graphics_output_protocol_query_mode)(
-	struct efi_graphics_output_protocol *, u32, unsigned long *,
-	struct efi_graphics_output_mode_info **);
-
 extern struct list_head efivar_sysfs_list;
 
 static inline void
-- 
2.23.0

