Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365567A96DE
	for <lists+linux-efi@lfdr.de>; Thu, 21 Sep 2023 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjIURBD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Sep 2023 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjIURAq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Sep 2023 13:00:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF42133
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 09:59:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1493901276.0
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315538; x=1695920338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8swn7HmC4uSQV3vzfL086oj2XFrz2A4bNyoHSHM5TA=;
        b=cdCVwiulppUWIAZFe3quU9XZfaxbHOpQy77t1TYLoJY2gwdebCZqYTqT+gKQCH2CQe
         2uv7TOV5JsrhCY6D4D6uextkReDotA3QxNisT5xqsjuJa769Pyz9cCsUcO1pQq5ZZFjv
         1HDHkTJphdXUYko8bmYSJnkRhBhVsukXqG9C5+rilijQg9bhu+eUnCQ3HYlW44ffe8sm
         M2mlk2aRhgbF1PxrXAIj5dr+fvdMfVGRrcgoXuD9Qbqyq6+14di8OuIYALdQ9IgmGh2V
         dRJ0NW3rlQwcaIti2yWza9b7k5gtTzR8NLWp+jeb3PFrULCtemKWbWVnTO9Jj45+dFEu
         h+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315538; x=1695920338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8swn7HmC4uSQV3vzfL086oj2XFrz2A4bNyoHSHM5TA=;
        b=LaCUDih0RExC3IjOt4Po1F9sRHKq9iLaPeHZaka3L58P2bptavPfNJbD62UHsI+rtr
         VYeNu0qH8msMSDQPQvR1HSB3DFWqSharYhcIbpmiSKP/FSBD8DuHJjayVbjpNcKX3Tpp
         WXOd8K1lm6T9+uMT7Djf+Ghfh0L3u0o+gRt1ceBTx0qGFa4C6sY+oYwBd0K2Hni2gdOE
         2ZvqnDRZb2dzT/9EViUqfdI58ldpAgPS1p5mpdlPRCMUV21vPL4spAQYMozoQga+Djqb
         YdpBEHJ34b5v5WR5wYBUWhrrCM1To29ZcBwDEK6cZyx3GNRZ2rIn1vSEDLlyJMuBzvPf
         y2vA==
X-Gm-Message-State: AOJu0YxOFd7BVqhAiX0tghPBKeC+zFKu0V7m1foWpb9oSMBLcRmWhJ0B
        gAqkF3suzutZd2so0thOwfS58fLTqgNe
X-Google-Smtp-Source: AGHT+IHcOZyXNwTzn1eSqLSYsQeU0FEqWAj2F9tL5lG2ChjxPYE8IDiLXGUX5rRRfibLUsqS4A7ejQ==
X-Received: by 2002:a05:6a00:311c:b0:691:da6:47a with SMTP id bi28-20020a056a00311c00b006910da6047amr1377959pfb.31.1695303451405;
        Thu, 21 Sep 2023 06:37:31 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:30 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <piliu@redhat.com>,
        "Jan Hendrik Farr" <kernel@jfarr.cc>,
        "Baoquan He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>,
        "Philipp Rudo" <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] arm64: Enable signing on the kernel image loaded by kexec file load
Date:   Thu, 21 Sep 2023 21:37:03 +0800
Message-Id: <20230921133703.39042-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Pingfan Liu <piliu@redhat.com>

Enable the signing on the kernel image if both KEXEC_SIG and EFI_ZBOOT
are configured.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org
---
 arch/arm64/Kconfig        |  2 ++
 kernel/Kconfig.kexec_sign | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 kernel/Kconfig.kexec_sign

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f6..e067864d7ea1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1493,6 +1493,8 @@ config KEXEC_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+source "kernel/Kconfig.kexec_sign"
+
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support"
 	default y
diff --git a/kernel/Kconfig.kexec_sign b/kernel/Kconfig.kexec_sign
new file mode 100644
index 000000000000..880aa9aed9a8
--- /dev/null
+++ b/kernel/Kconfig.kexec_sign
@@ -0,0 +1,54 @@
+
+menu "Sign the kernel Image"
+	depends on KEXEC_SIG && EFI_ZBOOT
+
+config KEXEC_ZBOOT_SIG_KEY
+	string "File name or PKCS#11 URI of Image signing key"
+	default "certs/signing_key.pem"
+	help
+         Provide the file name of a private key/certificate in PEM format,
+         or a PKCS#11 URI according to RFC7512. The file should contain, or
+         the URI should identify, both the certificate and its corresponding
+         private key.
+
+         If this option is unchanged from its default "certs/signing_key.pem",
+         then the kernel will automatically generate the private key and
+         certificate as described in Documentation/admin-guide/module-signing.rst
+
+
+choice
+	prompt "Which hash algorithm should Image be signed with?"
+	help
+	  This determines which sort of hashing algorithm will be used during
+	  signature generation.
+
+config IMAGE_SIG_SHA1
+	bool "Sign Image with SHA-1"
+	select CRYPTO_SHA1
+
+config IMAGE_SIG_SHA224
+	bool "Sign Image with SHA-224"
+	select CRYPTO_SHA256
+
+config IMAGE_SIG_SHA256
+	bool "Sign Image with SHA-256"
+	select CRYPTO_SHA256
+
+config IMAGE_SIG_SHA384
+	bool "Sign Image with SHA-384"
+	select CRYPTO_SHA512
+
+config IMAGE_SIG_SHA512
+	bool "Sign Image with SHA-512"
+	select CRYPTO_SHA512
+
+endchoice
+
+config IMAGE_SIG_HASH
+	string
+	default "sha1" if IMAGE_SIG_SHA1
+	default "sha224" if IMAGE_SIG_SHA224
+	default "sha256" if IMAGE_SIG_SHA256
+	default "sha384" if IMAGE_SIG_SHA384
+	default "sha512" if IMAGE_SIG_SHA512
+endmenu
-- 
2.31.1

