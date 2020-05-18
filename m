Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F891D87D2
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgERTHU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:20 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36726 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgERTHT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:19 -0400
Received: by mail-qv1-f68.google.com with SMTP id a4so5282501qvj.3
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTfX7FMnAEHXPLMZO7UqEZul4KGH8VsTd//SDkdkJUQ=;
        b=f1O+qjWj3xUZHMAdKY1l7N9f44iGaDCKCaCMyHqJAC3tiMamKuJxzY+EXq3uFajAve
         4gBJrw83TohxIaJ/GzqtVjAU4+o3TNXjt8pzkxORv6rb20A2p47+3NFGSNqkGc3p1JHc
         04ytxEV5ntVq6rpQU4j93EY64oR9kY7XDF3XgRiViISDMgHMDcDNIkQxiS0qMyXgmnW4
         GV4Dk/cwxFuol4mRuBLX3LUr3mxKjKB+ppKdmi4ZCG6SsV2r4Lg3BTLxVYWlYR0jwGBh
         LEAQPKN2AbMLr+LFiU/C/mcQlx5bHyyuLddPM8VUTOHWM9qvxmT92XACFZPoFTdcqqJp
         m5AA==
X-Gm-Message-State: AOAM531La0zrJEmf+lOHT10G4ozvr2FggKXr2bh/eOnTXPHF2BMQHlYV
        L5m0MdD+j0vBaPOrXEnTJmg=
X-Google-Smtp-Source: ABdhPJwdbBQtjMPz5o0qL7OkMH78XMNvXVY8sYfMx4mhBF39R8yjgibBH38mLGhkcxzQ0/R13QdGTg==
X-Received: by 2002:a05:6214:1c2:: with SMTP id c2mr17933734qvt.185.1589828838181;
        Mon, 18 May 2020 12:07:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 01/24] efi/libstub: Include dependencies of efistub.h
Date:   Mon, 18 May 2020 15:06:53 -0400
Message-Id: <20200518190716.751506-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add #include directives for include files that efistub.h depends on,
instead of relying on them having been included by the C source files
prior to efistub.h.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efistub.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 15d0b6f3f6c6..998924916b03 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -3,6 +3,11 @@
 #ifndef _DRIVERS_FIRMWARE_EFI_EFISTUB_H
 #define _DRIVERS_FIRMWARE_EFI_EFISTUB_H
 
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/efi.h>
+
 /* error code which can't be mistaken for valid address */
 #define EFI_ERROR	(~0UL)
 
-- 
2.26.2

