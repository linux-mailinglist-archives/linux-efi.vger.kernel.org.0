Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016043CC5A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbfFKM7Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 08:59:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36740 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbfFKM7Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 08:59:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so7558395qkl.3
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0ZB3LW3l30Fq0eOwrGscIyWdot13e1MeQG3Y4BlhhY=;
        b=q0N6rI6xhARKRcW6Ya2FCtkBiYjzUAzFSTkEgxxIZAOslEZXdFIboouN8T2LC+fVqj
         p+OzCD0cG1I1C0Wv02OYas/jyrfCTmwB6F89Ko3PmpNyaRqth1NmE+f387L9J0EhlZ0r
         GL9pBM0QFB07INgVruPAtqOxK0I2S2tckSjeFJSH2zR/zAyBTFueShoopRrI3T95vAc0
         oVmB2vUppb69fgPNR2yaPytyfCRbNGU82poMJwNjWdfRr9yUYZNOlKLgDkUA97uIUCdj
         6aOrK7K8cBCyF6xr+ji0TGCLOW3LgorhOzpIIV4UuUOYR0UBr6CK6ZTMkSe4do/gvzcd
         6xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0ZB3LW3l30Fq0eOwrGscIyWdot13e1MeQG3Y4BlhhY=;
        b=uEzZ8Hq0rlpomH4n+n8GlTyen1tJbMz2OC0fvQiKQDAZRJMGHr7iGvK9w4KbRPVNRu
         DoeyFilNcThWqgX48dNIvZh4UBmX5Yjf3zzKxOp36DqnnkpDeZGjxYhvQGfrOEbq+VmZ
         724jDv9nAZ9NqnbDTySzG8yBOI41wLBw6IQFSVTMPhQz8GEgwpwmIyG1QLcKwNYX+KeF
         3W6dqwLDmx7zQho2rh2IySXMNutJvd3U/snrDHeaPD4Ephz9lU/frcXBRz+P8I+Ty47e
         ljfh214a8ftGDNsnG8Ml/DuvuZ1eK17ZNlSGJbTHAOEDOoKjbXrYKXZLzTR2BsOeJHOn
         tktA==
X-Gm-Message-State: APjAAAWSWSKT9I/FoEKbmpDSHC65GpfR6UfPeUD0UBvUsWSHURwI/JYt
        +8eR77jx2QKhabp2GtZXavOM2Q==
X-Google-Smtp-Source: APXvYqyxOhNnNCOs8XADBDrWeen6Tnrd9g5qOv0NJvTvU36OXp+4MZv4LtDtwKG4J3qnxgsJH23rfQ==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr21521259qkd.5.1560257955516;
        Tue, 11 Jun 2019 05:59:15 -0700 (PDT)
Received: from ovpn-122-116.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s35sm7784608qts.10.2019.06.11.05.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 05:59:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     mjg59@google.com, linux-efi@vger.kernel.org, bsz@semihalf.com,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] efi/tpm: fix a compilation warning
Date:   Tue, 11 Jun 2019 08:59:04 -0400
Message-Id: <20190611125904.1013-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The linux-next "tpm: Reserve the TPM final events table" [1] introduced
a compilation warning,

drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
drivers/firmware/efi/tpm.c:80:10: warning: passing argument 1 of
'tpm2_calc_event_log_size' makes pointer from integer without a cast
[-Wint-conversion]
  tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
drivers/firmware/efi/tpm.c:19:43: note: expected 'void *' but argument
is of type 'long unsigned int'

Fix it by making a necessary cast for the argument 1 of
tpm2_calc_event_log_size().

[1] https://lore.kernel.org/linux-efi/20190520205501.177637-3-matthewgarrett@google.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/firmware/efi/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 74d0cd1647b8..1d3f5ca3eaaf 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
+	tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
 					    + sizeof(final_tbl->version)
 					    + sizeof(final_tbl->nr_events),
 					    final_tbl->nr_events,
-- 
2.20.1 (Apple Git-117)

