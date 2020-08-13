Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26253243F12
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMS6Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 14:58:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42461 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMS6P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 14:58:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id b79so6116548qkg.9;
        Thu, 13 Aug 2020 11:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIy+fn9MiJZ5T8cf9c31cog88Zabm8xDN4P7tYVMCqY=;
        b=I8NhRCNaTgY84w1+AU82ikN5cYokwg+gzcWauwrABaljcCjA4Ri2TB6y9V9RUjckbO
         VsWsvgNEJuG+8VsbUWGwpyvbtjqSxPk5TswhB31XHgJP/v1dGJlVVCT/M9Rwg81HX4LP
         7ub3P6QQl9derlv6ISNMFJyJSv/OLwtmwrymBSdkmj6KKXtLRjCunPJgEH3CopDavJYF
         Lh/+PkARW94dfog4RP+OKCcvJBJ9paF2RISEwp1gLKgswCbS3eZQMm02t5wGYvhLrZQi
         06AQhg4M54Qq68Lyl7kchekkchMzWFP/BtsA757OKxryk82ELCHmBf5QeTKhRIlfK/Vx
         FzeQ==
X-Gm-Message-State: AOAM5328EetecWlV7ZA2FZRLqwh8PMdSDnniOb5JqkaM40oBPFQgKd6H
        +Fp+F17+eYuRinZRvTLwyRanvwGb
X-Google-Smtp-Source: ABdhPJxVEnZj+K9r/PfT2yKqyAg/Cz6hYhWqqmEY9Ma149I3IMYZEl8rPh5teneFURGTBBCOJxZ5uQ==
X-Received: by 2002:a37:a746:: with SMTP id q67mr6054586qke.93.1597345094460;
        Thu, 13 Aug 2020 11:58:14 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm5994563qkm.44.2020.08.13.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:58:13 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] efi/libstub: Handle unterminated cmdline
Date:   Thu, 13 Aug 2020 14:58:11 -0400
Message-Id: <20200813185811.554051-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813185811.554051-1-nivedita@alum.mit.edu>
References: <20200813185811.554051-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Make the command line parsing more robust, by handling the case it is
not NUL-terminated.

Use strnlen instead of strlen, and make sure that the temporary copy is
NUL-terminated before parsing.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f53652a3a106..fe5103086e27 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -194,12 +194,14 @@ efi_status_t efi_parse_options(char const *cmdline)
 	if (!cmdline)
 		return EFI_SUCCESS;
 
-	len = strlen(cmdline) + 1;
+	len = strnlen(cmdline, COMMAND_LINE_SIZE-1) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;
 
-	str = skip_spaces(memcpy(buf, cmdline, len));
+	memcpy(buf, cmdline, len-1);
+	buf[len-1] = '\0';
+	str = skip_spaces(buf);
 
 	while (*str) {
 		char *param, *val;
-- 
2.26.2

