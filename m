Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88226FB6F
	for <lists+linux-efi@lfdr.de>; Fri, 18 Sep 2020 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIRLZt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Sep 2020 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRLZp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Sep 2020 07:25:45 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C9C061756
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 04:25:35 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 23so1361567wmk.8
        for <linux-efi@vger.kernel.org>; Fri, 18 Sep 2020 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=MY3i44yKq0Q24PaD5n8EanwCf2JmOR1H8DRTTFWUHr0=;
        b=It0pkiRmu495R60Y2vKHX+kUpiz6SA4dN5Dp++AaGwowg4m57GbV0kw7LMC4vHY3Q4
         1tr0C2hq5TfQEUNFqCrkIV9kIFDQ0N632EkDGg9L01cUxPo2MFAyWXl+iFyemUZQFgux
         D2OdMevISdXe1b8cgtT8TSKNmdPzU08UywjxaEVqwlVCw5cK5JiIlcjWRmS1eE+CsuOt
         Kmys1Tpw/ON68W1lZNAC0kc+iEWeoCLqA2W53erU069VcSNVsj5W/d+ydFebHjsmlUG6
         sP1LAHH4E+mthVm0KuXAdwKP0EKQ9a+xD70+ELG2GDonP73qtd4GGTF5/PK59m0s56Et
         jJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=MY3i44yKq0Q24PaD5n8EanwCf2JmOR1H8DRTTFWUHr0=;
        b=Rj3sT2HZ0FSFHaJceM77+haOk5V/3RU+PvUhIIbS4530ArkGHugmCpBU4J63Nrvh0v
         uUz4iDAU0DeoFsKD70+jYOgFqueAiJrU09xGqopluDf4ztmmsNc48cyMyB+5iXNIWlPl
         jl74y5hXZrav7JHcgSW5Y8c3YcpbJJC1XZklwMoBy4QfmTKcRs0ciqlbCqdMepaOr0sH
         oFSAHyNj2MfcXUR2a4lRXBP4T8bEiPgrcLR3e1bVdVXc7JOlOLOL+zlo09k6+elNxaVN
         w7JUPnneeq7oC7t9dRfO3jLw2GTSmUjqX+nc/9CUCwgeL3IlmYWU3xYJ7VF3dHq/fBN2
         mxAA==
X-Gm-Message-State: AOAM533e1ApIiaNG8aZRtuKqaegU16aWA/85MK6VFLk6IlkRqeIwO0R8
        uwiwGyW884oGPB5I43TA0eYC3Rqj3g==
X-Google-Smtp-Source: ABdhPJw866apNRLHdHyAEgyAZKtvFR8LlhowbDXSsLQNFyXGdKao4DoF9LQxNidwdG/nijywAWPn04Tymg==
X-Received: from katla.muc.corp.google.com ([2a00:79e0:15:10:7220:84ff:fe0d:f6a2])
 (user=misch job=sendgmr) by 2002:a05:600c:4103:: with SMTP id
 j3mr14926391wmi.130.1600428333317; Fri, 18 Sep 2020 04:25:33 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:24:59 +0200
Message-Id: <20200918112459.918328-1-misch@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] efivarfs: Replace invalid slashes with exclamation marks in dentries.
From:   Michael Schaller <misch@google.com>
Cc:     michael@5challer.de, Michael Schaller <misch@google.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Without this patch efivarfs_alloc_dentry creates dentries with slashes in
their name if the respective EFI variable has slashes in its name. This in
turn causes EIO on getdents64, which prevents a complete directory listing
of /sys/firmware/efi/efivars/.

This patch replaces the invalid shlashes with exclamation marks like
kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 28bb5689333a..15880a68faad 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
 
+	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
+	strreplace(name, '/', '!');
+
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
 	if (!inode)
-- 
2.28.0.681.g6f77f65b4e-goog

