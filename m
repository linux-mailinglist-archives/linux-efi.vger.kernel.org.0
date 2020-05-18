Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FCD1D87E3
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgERTHb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33921 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgERTHa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id 190so11494963qki.1
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttCAmBJ68DhCprgyk/CtTxRgX3jyD48zCH+0wlNA1Hk=;
        b=VsUydedj7/tqJkIdKWRmqbjLyhFhWEAWmf+eu0i6xdqMAcJ5dOHxQ2mAYRyIhPhK6y
         qgHnWH1gDpNYc6klUI7Kg1A8OnMiF093yw7XFn02+vq/L8MtQvIPjioN+ElVK1IQvglg
         542W0HQ0g88WQcOvO4A2dT31xowPLQx/6jgZn8RHah/mxGjcwzku18e45TDBEm7bUqMv
         CMcbC0ZTT8aieAFKsVYnMB3vUC0yWi9M/0Cf+xZlaswB1y7rV3OATg1k81eqqnHmGKvj
         Fnmnc9gAhXzmObzGjpwQ6SsrG5cekJcMumKlcnSywt5nDBcDqqaQqSaZwg11NIYB0Mbf
         m4CQ==
X-Gm-Message-State: AOAM530PbT3BPUj2UVyVaAlAAaYXHn8pmuPhE0fX0Hw5Ice+pwS3gvt7
        9hQho1cTmNqZXyKF66zuahQ=
X-Google-Smtp-Source: ABdhPJwrBxtD/1BUNrAyDsScadBVR6z8JZcP/lGg/i/OKF+V5wyf37xTaSFKc6353jqBeBmAI0rcgA==
X-Received: by 2002:a37:a7c8:: with SMTP id q191mr17265472qke.214.1589828849415;
        Mon, 18 May 2020 12:07:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 15/24] efi/printf: Abort on invalid format
Date:   Mon, 18 May 2020 15:07:07 -0400
Message-Id: <20200518190716.751506-16-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If we get an invalid conversion specifier, bail out instead of trying to
fix it up. The format string likely has a typo or assumed we support
something that we don't, in either case the remaining arguments won't
match up with the remaining format string.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/vsprintf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index 3352ba394797..7dcbc04498e7 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -359,12 +359,13 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 			break;
 
 		default:
-			*str++ = '%';
-			if (*fmt)
-				*str++ = *fmt;
-			else
-				--fmt;
-			continue;
+			/*
+			 * Bail out if the conversion specifier is invalid.
+			 * There's probably a typo in the format string and the
+			 * remaining specifiers are unlikely to match up with
+			 * the arguments.
+			 */
+			goto fail;
 		}
 		if (*fmt == 'p')
 			num = (unsigned long)va_arg(args, void *);
@@ -433,6 +434,7 @@ int vsprintf(char *buf, const char *fmt, va_list ap)
 		while (field_width-- > 0)
 			*str++ = ' ';
 	}
+fail:
 	*str = '\0';
 
 	va_end(args);
-- 
2.26.2

