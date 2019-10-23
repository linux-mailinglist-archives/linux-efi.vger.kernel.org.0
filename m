Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7358EE21C7
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 19:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfJWRcG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 13:32:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41484 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfJWRcF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 13:32:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so23019856wrm.8
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkSWabqYVL066Xoh2VEh6KAZRi4MksvH/vrykc5mNu8=;
        b=CgvSGucEXePDgb8HdjupEKmoCsfnrmGoc0SxZhaKnsPQEzyPYUcSQFwcJnbR0krN8q
         VX72j5JlYGgnGcQm/oQQJ/ljNtlO6cDakEe+QRyytOLgpzuq66qzM+4QvHSzgodKPxwn
         vVGkk/HhJXGSojQj5WKh3I8K6mofh1N3nPF8TbIIazVdOWWFCjGFBq2MAEwDI7VX52TG
         N2IiLk5LnzGwvso2360v8V3/W8mMJdOErj2q7OQSLoluHuypaUfiwBhkB02iR8Ipb1Zc
         hrEcPwSM+UGTS54oreMCu45yPBRz6RpSGxjSJcGrqv3XGl71gi1jOfU76YejZT6qNZO+
         z8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkSWabqYVL066Xoh2VEh6KAZRi4MksvH/vrykc5mNu8=;
        b=gSSf7k6n6OXcI91SQ18cuOjcxELItQJa4AbQxeKAtekZmjbitSad0L5g0Oqalnrt63
         6U9mxczJ5sI5jbLQkyvvjmV8JDFJ9xyScawfGPXWl90yqFMOEXiV5Ls9DhgOcmD0UorV
         lP8MMoRES9Nxksc13eyAKxvT5ub5Y9UyGdg7hVgfbVrdyPNr4wWiuwKY+1QnkhibNvkQ
         1pDD1VPkqgxY2v6ZeWqS65nVXK5CK4n1l8wFA0jr8pU0WAnnLBpzEEbfm5WEKNUzu08d
         VFLdMaIo9R7fZOKz9bmiCYdgvhAQ/BHAu9Z+FCiP1dxcQHL6/P0u5R+fX+/gXEsdgB5i
         f6UA==
X-Gm-Message-State: APjAAAUGxyGANkqASuVasKk4k+gokXHyJ4g8jpL8bDK6ooenJtlqNeb7
        ts4wm1m9YgBle019uitWjhgkzIIFQYqkyZPb
X-Google-Smtp-Source: APXvYqy08L9FIbY2r412z5v6+7nNGPipvOr2gI9T5+G9vq3J5rQy7aJf6LEJ1eQbJxDAegBfh7tChQ==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr9429013wrn.67.1571851923689;
        Wed, 23 Oct 2019 10:32:03 -0700 (PDT)
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr. [90.118.215.104])
        by smtp.gmail.com with ESMTPSA id f7sm14900374wre.68.2019.10.23.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:32:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] efi/tpm: return -EINVAL when determining tpm final events log size fails
Date:   Wed, 23 Oct 2019 19:31:58 +0200
Message-Id: <20191023173201.6607-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
References: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
X-ARM-No-Footer: FoSSMail
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

Currently nothing checks the return value of efi_tpm_eventlog_init,
but in case that changes in the future make sure an error is
returned when it fails to determine the tpm final events log
size.

Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after ...")
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/tpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index ebd7977653a8..31f9f0e369b9 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -88,6 +88,7 @@ int __init efi_tpm_eventlog_init(void)
 
 	if (tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		ret = -EINVAL;
 		goto out_calc;
 	}
 
-- 
2.17.1

