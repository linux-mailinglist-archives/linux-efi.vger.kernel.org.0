Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0346E0E
	for <lists+linux-efi@lfdr.de>; Sat, 15 Jun 2019 06:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFOECQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 15 Jun 2019 00:02:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42448 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfFOECQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 15 Jun 2019 00:02:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so2608497pgh.9;
        Fri, 14 Jun 2019 21:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=u1ZcG1Sp0JvhKEi3rEpRDEedkqqLBcdvyquQGonVQRw=;
        b=GzCnkIla8t/CAZwgluyHn46xdqBub+xym2+1pTfmLv7K5C5y691nCtPwbWqiAGwSwK
         WDyrJVMv+CaURgfh0yM31SgMFDZ0mxU9kzcLlrX4Ap5YdQPDtAynNZPh06brqIWlQUr3
         1FpXmpo/LbmuU+c5Z0WWjfMzFk2xQ8osf9Zzih9oBdY9MTjv/BHJw+YufUEQb2W9Moeu
         M+BbcjPTjbu5SM80EnekimCviunjNUJ3c5pjJTQORg2Cvhw9W8Cpv+FUQw2VdqKxW3zD
         yu2qoZGp+x6xOk7uV+N6rp0VvGC3i+Gl7HDcfWMX7aIWRMForIlRH2Taj06y3vqyCBnh
         BV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=u1ZcG1Sp0JvhKEi3rEpRDEedkqqLBcdvyquQGonVQRw=;
        b=Lh/up5ZsrUwbJwTFTS0tAe1P0DIx+4dnWcVZpPUgVKPPgBvTnh7rLqkpfyADyjNqoN
         vWgJpR9N2XJqpZkQFH+4LQ7/KU8OnX3TBFnjuxhcJleckYMSiw43zCkiaTwEFXTyCTub
         AJYnQPCU0wrLvVL2alzDSWo7ZoXfg83F8+DHK5Dsax1N9HmvIfkRFBQdQYgD4ykViyUI
         YNVnS1BPXYb/1yiyEIRwKuoEas1BAukspK8Irr5u5XH8B1sCO9DNjhVlk52Bwfb7fXkX
         suS31bEfwvliDFi6qPyFomLBAVpeE8VJ6Fm1qnsEitpALjUGFYA+S4ZO+5v7k1bd/G/e
         Myfg==
X-Gm-Message-State: APjAAAX1Et3JYpktUPy/2aNckBELHqs8aNAi0/h9SXRJcZVV7ZyEYLye
        Zmx5f/lVMe9j3HmYJ6FrbNo=
X-Google-Smtp-Source: APXvYqwudYW3SlUwNYhcsJjD2f8LUUTsZK63ADPGAZf93vIUia8LG6mRDg88vi/jG9tXTki6OS1H0Q==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr34349227pfr.199.1560571335596;
        Fri, 14 Jun 2019 21:02:15 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id m1sm3857242pjv.22.2019.06.14.21.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 21:02:14 -0700 (PDT)
Date:   Sat, 15 Jun 2019 09:32:10 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
Message-ID: <20190615040210.GA9112@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch fixes below warning

drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
‘tpm2_calc_event_log_size’ makes pointer from integer without a cast
[-Wint-conversion]

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/firmware/efi/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 74d0cd1..1d3f5ca 100644
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
2.7.4

