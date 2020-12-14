Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E752D9D27
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 18:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440390AbgLNRCI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 12:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395515AbgLNRCI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Dec 2020 12:02:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B00C0613D6
        for <linux-efi@vger.kernel.org>; Mon, 14 Dec 2020 09:01:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c133so2396044wme.4
        for <linux-efi@vger.kernel.org>; Mon, 14 Dec 2020 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rKc3k/8U8hxAEjZzV49Vk7VDE1v7E2xpMe/kBCJFBI=;
        b=wKsQfqJrynPmzpMMsxKjboxVpD/1N3zg/vJtI3Z08Rl6LpbK95nV5zwitVjQYd/BE/
         mbp6GpyyjcdkOo219WP3HREnwM00uz90+hi5dpQR9C5A7tgDijD9ghAmpwGg3qU3eoQT
         79gd97G+9QlhjApL09Hu8WX8ovUGGq8zv780dIa1ptvz0Tj2UCFtHKaK071sPk7I1KGf
         L/P8HoU1b8LmSdMEVlqAdrHO1zaTpvMkTCpLx3jkqMB2FrkNgLLFsDknlsgxmh5w2+Im
         lIic/BNHnqGBd0JmDWnmwLGrLOGiFD5u65uXlJ1LHF3iMwgmca1dxxwwhVgdyvXzMzgL
         Wb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rKc3k/8U8hxAEjZzV49Vk7VDE1v7E2xpMe/kBCJFBI=;
        b=lq4LoEfBQDKrZSd9Fz8YK4IXb3NdlGqYNvE5u0MZIN1Cyw8NERPhntzeKxELCqbgW8
         SkfYwPVZBsjAtJCcGOvZTPzA3JSVSJlz89nhrpakQfl+uAlokH+2QRHEeSvV8BgBAaNR
         xcymTxyeTyv8pwlNxpab/hTYJfkDNCTtWb0aZs7qs9WcykIwWNW5Smr473UaERvtYjTc
         Inb/EGg/Ej9dEEbAua6MmwriLuJGezhiqNeUTRvIg7i0CFSn9ypAqryUmZQKZVzcQE7u
         JybRWVtD2AX/bJT3nx/4fa8XgRpJF8EunQzEahRUgYII8Zih8Y5Z0xvNd9ukV5p4Onan
         mf6w==
X-Gm-Message-State: AOAM531b9VmT6HK8LwY0ff0y/Q0EjG9WstRG81EgY2sb2+QDnUwdShJ9
        jOtkPrUM7zo9FFSVbXl2f2eE6BW/hkokXdHT
X-Google-Smtp-Source: ABdhPJxEmH6X6neOFnVOnJy4jllk08QSxvJGaeVXxFqODHv1zPpW5JmDKL36UZaw0CJfr19My9sigA==
X-Received: by 2002:a1c:9609:: with SMTP id y9mr13748496wmd.75.1607965286547;
        Mon, 14 Dec 2020 09:01:26 -0800 (PST)
Received: from apalos.home ([2a02:587:4664:2be3:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id m18sm18081725wrw.43.2020.12.14.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:01:25 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     ard.biesheuvel@arm.com
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: Allow EFI_NOT_FOUND on LOAD_FILE2_PROTOCOL calls for initrd
Date:   Mon, 14 Dec 2020 19:01:21 +0200
Message-Id: <20201214170122.4569-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

At the moment the EFI stub tries to load an initrd from the
cmdline provided option only if the LoadFile2 protocol does not exist
on the initrd device path.

This might prove problematic for EFI installers that need their own
version of initrd to start the installation process and the firmware
installs the protocol but doesn't have a file to back it up (yet).
Although some firmware implementations return EFI_NOT_FOUND, we
currently return EFI_LOAD_ERROR in efi_load_initrd_dev_path() which
stops the cmdline provided initrd to load.

So let's change the behavior slightly here and explicitly respect the
firmware in case it returns EFI_NOT_FOUND. This way we can load the
cmdline provided initrd.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..391aae2f0cde 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -560,6 +560,7 @@ static const struct {
  * * %EFI_SUCCESS if the initrd was loaded successfully, in which
  *   case @load_addr and @load_size are assigned accordingly
  * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
+ *   or if the firmware provides LoadFile2 but can't find a file to load
  * * %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
  * * %EFI_OUT_OF_RESOURCES if memory allocation failed
  * * %EFI_LOAD_ERROR in all other cases
@@ -599,7 +600,14 @@ efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
 				(void *)initrd_addr);
 	if (status != EFI_SUCCESS) {
 		efi_free(initrd_size, initrd_addr);
-		return EFI_LOAD_ERROR;
+		/*
+		 * Some firmware implementations might install the EFI
+		 * protocol without checking the file is present and return
+		 * EFI_NOT_FOUND when trying to load the file.
+		 * If that's the case, allow the cmdline defined initrd to
+		 * load.
+		 */
+		return status == EFI_NOT_FOUND ? status : EFI_LOAD_ERROR;
 	}
 
 	*load_addr = initrd_addr;
-- 
2.29.2

