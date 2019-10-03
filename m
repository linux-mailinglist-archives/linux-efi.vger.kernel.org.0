Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF9C9BBB
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2019 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJCKHe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Oct 2019 06:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfJCKHe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Oct 2019 06:07:34 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17E6E3C93D
        for <linux-efi@vger.kernel.org>; Thu,  3 Oct 2019 10:07:33 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q9so914114wmj.9
        for <linux-efi@vger.kernel.org>; Thu, 03 Oct 2019 03:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5d9O4LoTQ3VNanjYlvKG9HY1oRDE8Vmjt7UY1ZS+X20=;
        b=YlH2JNBUM+gzVIQJ7u2vwmJ8+chJxR9EWMc+yrAgecJ1JF0ayMMHFcf8nwqZAnljiz
         M7WRbAzPakMzP2kCmNDe6vzv+MQo33qSHwsIyVrYqUYLaRtxAMDOIAEZ4JQnjCN7vTej
         C+H+YRIP+Vw/JwL9r3QyDSa4jQ8SIVuiP3W9m8MDaoF9mSf+CImOXTgoXDyFBH9v9mH+
         x+5Clt+TalXr+OfRxyEViuhCUPE6uORqDJtSULx4A1qJVqKwcz7MiLbluE0nLiQtZFnJ
         DildO5sqPdgnStB0SRKRVIIE/+T4a/Udb7hc7DCiIZV4WOxTixhrk4oABjhNeY/qupBT
         plWg==
X-Gm-Message-State: APjAAAXgpELaptt2ldz2FeDnN4B28xKRnTnHF1ry97SQgMZ40fZ1o3D8
        zrJ/jE2GdFPPq+ZamffvgEF7Xmo40iNmc9yY0FuR/zycqqqy8tHy28gq3YM7kPJL3sjenhodX5T
        i3M9SRsi2byooziuZPdbW
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr6434310wro.147.1570097251811;
        Thu, 03 Oct 2019 03:07:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy46FajQ6RH+bkNlP2jtpMp+fUyzseehfvtwI3P6jr8sZxYZ9HXjJGs4NIMnX+0k/TvD9gVwQ==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr6434286wro.147.1570097251554;
        Thu, 03 Oct 2019 03:07:31 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id v7sm2435254wrr.4.2019.10.03.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:07:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] efi/efi_test: require CAP_SYS_ADMIN to open the chardev
Date:   Thu,  3 Oct 2019 12:07:12 +0200
Message-Id: <20191003100712.31045-1-javierm@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The driver exposes EFI runtime services to user-space through an IOCTL
interface, calling the EFI services function pointers directly without
using the efivar API.

Among other things the driver allows to read and write EFI variables and
doesn't require CAP_SYS_ADMIN as is the case for the efivar sysfs driver.

To make sure that unprivileged users won't be able to access the exposed
EFI runtime services require CAP_SYS_ADMIN to open the character device,
instead of just relying on the chardev file mode bits to prevent this.

The main user of this driver is the fwts [0] tool, that already checks if
the effective user ID is 0 and fails otherwise. So adding the requirement
won't cause any regression to this tool.

[0]: https://wiki.ubuntu.com/FirmwareTestSuite/Reference/uefivarinfo

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>


---

Hello,

We want to enable this driver in the Fedora kernel for testing purposes.

Currently the GetVariable() UEFI runtime service is used (through the
efivar sysfs interface) to test that OVMF is able to enter into SMM.

But there's a proposal to add a UEFI variable cache outside of SMM, to
speedup GetVariable() calls. So the plan is to call QueryVariableInfo()
instead that's also read-only and sufficiently infrequently called that
is not planned to be cached anytime soon.

Building the efi_test module will allow us to call this EFI service by
using the fwts uefivarinfo test. But we are worried that enabling this
driver could open a new attack vector and lead to unprivileged users
accessing the exposed EFI services.

This is also consistent with the efivar driver since it also requires
the CAP_SYS_ADMIN capability.

Best regards,
Javier

 drivers/firmware/efi/test/efi_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 877745c3aaf..81de7374c42 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -717,6 +717,8 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 static int efi_test_open(struct inode *inode, struct file *file)
 {
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	/*
 	 * nothing special to do here
 	 * We do accept multiple open files at the same time as we
-- 
2.21.0

