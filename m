Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DBD243F0D
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMS6N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 14:58:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45324 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMS6N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 14:58:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id s23so5155026qtq.12;
        Thu, 13 Aug 2020 11:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMGEOs38oJF3yC1EryMyVjgRpVr9wn9qQ6Mpuxbj1sw=;
        b=nNBR+GTRdFgpOsKjmydrkqdNYfIImCxxj9YoqQtGtSpVRLEKvhZZKiMEi0Gt0ojqDK
         0f91QTR7qnaZPNMh/FYycBnAq/glDfl2d4Xrl3iVzl5A3gSQIBG/V0MyK+D58SUus43+
         3Za+IrpsLYFEotXxqeIMHfDVHgJS2qN22/Co3/MN5xpCrg9Tk5eqvAdw2+bRKMdtw1tF
         KtFpEvjvyfs+LpZXjCpXC4JpKjJYWm5bfTi3anFSSzq+fbOFHwaKoyZ+nXFQp7P5xe3y
         0PmH3Lq0U4huXIMZcL26pTgxodZTTZVkh2k8kzROdpb94QMAKlorMnugIJyb/KFr6EtS
         GD0g==
X-Gm-Message-State: AOAM531hUNEQ5NpM4jfipx4d/FrcZeG8JraT5YafIlM8ulwjSn6a24b5
        UZlX4u1s6aHkl08gUkO61fG4DUpv
X-Google-Smtp-Source: ABdhPJyNRm6fmf11/k0P3n8jfBZGdQifveMIIj5ftrD4gHUbc+PGfg+WGVZlI2UlpmfxJVtFes6czg==
X-Received: by 2002:ac8:754e:: with SMTP id b14mr6671942qtr.282.1597345092695;
        Thu, 13 Aug 2020 11:58:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm5994563qkm.44.2020.08.13.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:58:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] efi/libstub: Stop parsing arguments at "--"
Date:   Thu, 13 Aug 2020 14:58:09 -0400
Message-Id: <20200813185811.554051-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813185811.554051-1-nivedita@alum.mit.edu>
References: <20200813185811.554051-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Arguments after "--" are arguments for init, not for the kernel.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6bca70bbb43d..37ff34e7b85e 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -201,6 +201,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 		char *param, *val;
 
 		str = next_arg(str, &param, &val);
+		if (!val && !strcmp(param, "--"))
+			break;
 
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;
-- 
2.26.2

