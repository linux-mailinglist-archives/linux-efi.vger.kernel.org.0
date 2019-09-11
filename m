Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85F9B05E8
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2019 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfIKXc5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Sep 2019 19:32:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38206 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfIKXc4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Sep 2019 19:32:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so5429019wme.3
        for <linux-efi@vger.kernel.org>; Wed, 11 Sep 2019 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4JyiQhNZp69tVYahTTgOF5xpVVj7nM2maQxT9CgovkU=;
        b=VbxdGNtGsLH0P4TPj+YivKBSvK7ZjUqeGp3IaBhxViRoGlRBi1MnC/nOeg73oOQuPo
         T2hB4/PK4I/Uoymq3/betmUuvWG050fmOPBceBsbJtMJo79mF15TkoAbBQmZCJGlJCul
         J9w7bzKjucQF+O/FBPwFHlKiadbEroAtjy1OMizb/xnQr1Y7GIqtpMgAZNy8v21Zjom2
         nsWt3knEwEJDqRkeS0narvNwMEAur8vxIkWamr5YnEQn1bEY3r31qwjPfKSA7+7ckmoD
         dOsHOHIPc3OlBcQYvCN72GQMY5+pggohHD9iO6zXeb5g+UT7VMsK/hLFSTwxvw0XL2KD
         gPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4JyiQhNZp69tVYahTTgOF5xpVVj7nM2maQxT9CgovkU=;
        b=GpwblhCeTC7rYog3x7yqtmJYiQw6QguahYE+DisccZd/UIVrmL6Ixdl8rDDew5Rz/K
         TTUPe5Ui2Vk8F2rMkG7GDx/F+1IUSqsBwWx+Y3mrpTPXYt+eIL5cBgx2xLZPVBC5a7OC
         jCDuRu3YLDcvbYQ/1M72PQbNwfi8oAi7GID139XdIU3dQKo8Fy6IkE4x5t80x26UNYQf
         kk5CzAaaiBIYuv73Li//zloMhvm1OAlGaVrqMQ1hZ4WY1ue+yUBXPG3tg0e28KVXjjyr
         i314oTyXV+KzHhD1MTeAtO7Ais/2gVoYKCckQ6WAlBSbUKBHgibFgcBeGYEIxWybTxcz
         yjnA==
X-Gm-Message-State: APjAAAUlcojGuQ31zcyL+Or983WXFcvhChx+UbJhPX+aoRTPgR+FUFvI
        tPKRXjPmRpZk44d/cxUWeHCHU9xieOUMKIvT
X-Google-Smtp-Source: APXvYqyr78gojwJ4vt8u+Ku9MMdkErTo5DcvRAvs2xM/ySD7jAir0fC5JIlem+7kHGctLU8W+59J1g==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr5823762wma.44.1568244774955;
        Wed, 11 Sep 2019 16:32:54 -0700 (PDT)
Received: from e111045-lin.nice.arm.com ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id c3sm32131637wrh.55.2019.09.11.16.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 16:32:54 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Scott Talbert <swt@techie.net>
Subject: [PATCH] efi: don't iterate over EFI vars pointlessly if no SSDT override was specified
Date:   Thu, 12 Sep 2019 00:32:39 +0100
Message-Id: <20190911233239.5916-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kernel command line option efivar_ssdt= allows a EFI variable name
to be specified which contains an ACPI SSDT table that will be loaded
into memory by the OS.

Currently, that code will always iterate over the EFI variables and
compare each name with the provided name, even if the command line
option wasn't set to begin with.

So bail early when no variable name was provided.

Cc: Scott Talbert <swt@techie.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..8f020827cdd3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -282,6 +282,9 @@ static __init int efivar_ssdt_load(void)
 	void *data;
 	int ret;
 
+	if (!efivar_ssdt[0])
+		return 0;
+
 	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
 
 	list_for_each_entry_safe(entry, aux, &entries, list) {
-- 
2.17.1

