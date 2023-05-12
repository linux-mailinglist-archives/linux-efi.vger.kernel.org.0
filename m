Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1E700F69
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbjELTnP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjELTnO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 15:43:14 -0400
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B75D074
        for <linux-efi@vger.kernel.org>; Fri, 12 May 2023 12:43:05 -0700 (PDT)
Received: by mail-vk1-xa49.google.com with SMTP id 71dfb90a1353d-43fa9a00625so2208247e0c.2
        for <linux-efi@vger.kernel.org>; Fri, 12 May 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683920584; x=1686512584;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLH/bA+yhFKgRgD/PfBdmu3fiVXAEJ3yCxJiyJbAdz8=;
        b=HRpWvZHQhiD+sYYJ1K5rzdIiHd2Yle38oUBMZ4BHlDYoUtRsa69jA3USb7nZfgfV0S
         ydMxAtyjb7m5VN0Me0ArhPOxPrj0OAdH+fKA2gzeqKYjNy3drxmeSCOkRcU9iuM8eowx
         zS6DnMSxPBzwV/p8TnfWcrKVEKgst0vYDIi7OpdhVXkTs7dnPcGR6LYQiCDCObrVOXHC
         gpMAPBDWA0iMTdQxU4WDcIhbqmNSKwCTH0+5e5MJSK+4ek5ubEclbuzPb3Gc0RLJGRs5
         cRPG9cbKwMtOzyM5lV3j6NxYp08suB9JAAe69YHwa5E3NQni/K63Z/1h+9kn3HrsVLz4
         aYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920584; x=1686512584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLH/bA+yhFKgRgD/PfBdmu3fiVXAEJ3yCxJiyJbAdz8=;
        b=G/65INXbsI+jzzjh5SvTjFikHETyCcVTbOk0MafkJcZFW6caZM3fiDa0nBxac0vH0D
         w8G/q4lQcLxbg63ECqVohNx62Fn5kaVECwDUs1ExMoELTrVcLUD2maRBscYf9P8AkRO2
         UueGlMnYWLy1PbeRFZGJjZJTFfXNn4o0xjCyb5y0y5hslvFP5n9Onm/BOkdXPXfTPWCJ
         Q0mimYkSLPzt0nCCpa90bf8KGf1Hv0kq4v7J+H+QREsZBRNu2qFtc1AwZZfnK/1FRdG/
         ze06J5TNplGR0nEYoWyytav2ynRCB4OaY/cgUQIbbDycPMVnOIReNIAu6wtQpNAhstiE
         wjyw==
X-Gm-Message-State: AC+VfDy5qPQG+w3rq9Cct42oMO6yI4agvE5L19Ant/jyWf1uWgYKZ3aB
        dXrYKEcvU/l+61mtZD3AW27HY7ThliU9V5ZlD1xcFg==
X-Google-Smtp-Source: ACHHUZ7Fp1jAB8Erug5aU4TplWPM/WGhwnxeGeFU3SLJ9CkdxMdKQyNgUktT6VvojByoMdCi8ac8BldwJdkfp/D91LWepA==
X-Received: from admirable.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2888])
 (user=nicholasbishop job=sendgmr) by 2002:a1f:ac8d:0:b0:453:eb8:5fef with
 SMTP id v135-20020a1fac8d000000b004530eb85fefmr7913684vke.2.1683920584402;
 Fri, 12 May 2023 12:43:04 -0700 (PDT)
Date:   Fri, 12 May 2023 19:43:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512194302.1662230-1-nicholasbishop@google.com>
Subject: [PATCH] efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
From:   Nicholas Bishop <nicholasbishop@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Access to the files in /sys/firmware/efi/esrt has been restricted to
CAP_SYS_ADMIN since support for ESRT was added, but this seems overly
restrictive given that the files are read-only and just provide
information about UEFI firmware updates.

Remove the CAP_SYS_ADMIN restriction so that a non-root process can read
the files, provided a suitably-privileged process changes the file
ownership first. The files are still read-only and still owned by root by
default.

Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>
---
 drivers/firmware/efi/esrt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index d5915272141f..aab96ab64a1a 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -95,10 +95,6 @@ static ssize_t esre_attr_show(struct kobject *kobj,
 	struct esre_entry *entry = to_entry(kobj);
 	struct esre_attribute *attr = to_attr(_attr);
 
-	/* Don't tell normal users what firmware versions we've got... */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	return attr->show(entry, buf);
 }
 
-- 
2.40.1.606.ga4b1b128d6-goog

