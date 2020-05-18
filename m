Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50611D87DE
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERTH0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44591 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgERTHZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id d7so9026176qtn.11
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYpaku212VJjExSBlM2ZzYjE+6P3nlhBNBcdulIFhoU=;
        b=IzVyDNetVQgq9t49BsWRmwJJEZHOUy0iqAPEH0uU2vNkLy+/eX4M1A3QN16g3JQXnZ
         v3CFY/NkzpR+I/A3R5GjvM3scT8QmYkLaGnL0NlBAJq+Z3bEx1J1VXjulEWBWlaOgSoo
         qnwIiDBFN2PPuDcbbYkCF+uFj2Xif6yIhoHThXUyJiRnFBm3PkU1JOQr5xS9TjLAGHg0
         QT+tGxveRgr3jxKqGEemLA3z338H/j7nMDSCwC+10KkE95WE91vhgZoftV5bNQcG9SRb
         HnZ0fUVZ9S5o3jOg65kAlWLRETQlWGF3EN/acqG803lkot8HYeQM2N2EfGPu4Onbc9R1
         zTbA==
X-Gm-Message-State: AOAM532OsFRtu8aPJ3QPd4YEkk40Yl1OUZEks4cZW9iJiIX1dplSuV+u
        WC7Jbo1MMUDsNhAnLO5QGaniZ8H0asw=
X-Google-Smtp-Source: ABdhPJxtUgMDz7u+NgwooehJFh57dodV0S2cJdhogZbx3w6PfCwElUB2VHV1FKpOXdKrSNzPcjsZOg==
X-Received: by 2002:ac8:1e16:: with SMTP id n22mr18152585qtl.78.1589828844378;
        Mon, 18 May 2020 12:07:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 09/24] efi/printf: Fix minor bug in precision handling
Date:   Mon, 18 May 2020 15:07:01 -0400
Message-Id: <20200518190716.751506-10-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A negative precision should be ignored completely, and the presence of a
valid precision should turn off the 0 flag.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index b3ed4af77af5..d7938e44f067 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -278,9 +278,10 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 				++fmt;
 				/* it's the next argument */
 				precision = va_arg(args, int);
-			}
-			if (precision < 0)
+			} else
 				precision = 0;
+			if (precision >= 0)
+				flags &= ~ZEROPAD;
 		}
 
 		/* get the conversion qualifier */
-- 
2.26.2

