Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91403C8F50
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfJBREJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 13:04:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54041 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfJBREA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 13:04:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so8009390wmd.3
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2019 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsW+iaoQYKJ7b3/MuPdxHfRaGiLURHymN+VpSjfI8qI=;
        b=pBjzEJT/pAMDLNi4fwib+YBdEle7Um7YdLiPjsxp8lLWj3W/EumlxrLiEnNi+m9lJ/
         y4hYGKUVxgJAeq+WxhJ7KAtpcCAQIhRy7cdGFQV992aHW7hCw6UgJQlwdjAhTfwokdfe
         tKOD+XZ1N5vfe7R3XmUuGD/RHZ35oUhX/z2Al1xYD0uxC/CRjV9Wcm6tjNwjt0jSm7Oe
         MA4ynP1x/WnZvowG5iigM6r5rWs5o0oEJS6pTr/7ddRuXo5vwWJjpgr5MgOyP5TcQ2Bo
         G07cF+JzljkWTcXI+IP5i/wu1fCUGWA0teNMC17YXrZ+FrlBXNZ8BPRlEhYlwEh0F+k/
         0AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsW+iaoQYKJ7b3/MuPdxHfRaGiLURHymN+VpSjfI8qI=;
        b=BwbFDU2Nrxk5GDnhB7olE3kT0vj91s06KxnAeIpiwY5rkOf7gIvmB3zQ9wXEYFO4v3
         Ci4EfxUeD/zBbbOHUGM5KgO6FTQA1dv7H4oiVRA9MXfjo2c1XQePR4S0GYIA4/USiI81
         zJJESSJ18AU8WkoYD6TEDuht4Wq1luTS2CBaQdxftI0oT3u+lQom8caRgGeSlgnsvN4L
         XMLnpDvGtrQS7rqG8Bdh71/lgRgdNVDuIKBScljcHt++fnzzKgLic2937XSP7dxz9Rjl
         eGOYlnKIroeydQJXJgl70ikGOMwUy4qsTz+6D0mWFo+U5uU5FpFmvIHPPBBwZr2mECPx
         cL3w==
X-Gm-Message-State: APjAAAW9DCtkjZgXfngVYD+fHKC8Fsnt1Qw2SFwRxEMpeFl63ZYB1tHH
        diT/bpgDmLd2rLHm7Tys5kwqs9evEeWbcPly
X-Google-Smtp-Source: APXvYqwJ3kz36Q30WtobntEZViJpOjnqr+GgG/h+07yEPhf6coRuAhe9qphn79wUprkC4NYqvKfZhQ==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr3961388wmf.64.1570035837982;
        Wed, 02 Oct 2019 10:03:57 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:56 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 6/7] efi: make unexported efi_rci2_sysfs_init static
Date:   Wed,  2 Oct 2019 18:59:03 +0200
Message-Id: <20191002165904.8819-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The efi_rci2_sysfs_init() is not used outside of rci2-table.c so
make it static to silence the following sparse warning:

drivers/firmware/efi/rci2-table.c:79:12: warning: symbol 'efi_rci2_sysfs_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/rci2-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 3e290f96620a..76b0c354a027 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -76,7 +76,7 @@ static u16 checksum(void)
 	return chksum;
 }
 
-int __init efi_rci2_sysfs_init(void)
+static int __init efi_rci2_sysfs_init(void)
 {
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
-- 
2.20.1

