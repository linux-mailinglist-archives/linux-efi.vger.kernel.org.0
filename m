Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7E4E1FB3
	for <lists+linux-efi@lfdr.de>; Mon, 21 Mar 2022 05:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbiCUFBJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Mar 2022 01:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiCUFBI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Mar 2022 01:01:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B161F1EAC9;
        Sun, 20 Mar 2022 21:59:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s72so6805417pgc.5;
        Sun, 20 Mar 2022 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIgHZDed9PIspLBbM5lPWdLUcFy0yV12Bw9ldjirghI=;
        b=ji8GCtCBicLxy3lk2fMdGpM+NyvXyi4eLh/3+FzN8mdLRW2+K/83g4Y3gX39C54ePX
         +P/jtU3rF3bq5XvEIWexsKogdpasdCaVqhuBU/Pgoc19lOE8cnJOPnGtwoEhGP81ez7X
         EdUgK8Bc5onPybzgllcMqxTn5LQ6lEnCx2B3A5IYby0/GUmbPHr8teE/xyUdm/4wZpiI
         b1owOSGQGUL7tA6SEpo7298XXFWvIdJshlPdqgjW/+aFY15rU391AH+Z/tYqWbysVPqc
         ntLoeoxNH0cnZ64iTbOVwpwixTe49CBHOSKsV3x1V+EuIc5VT+0pI8d67hmZP4Z95cvc
         kiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIgHZDed9PIspLBbM5lPWdLUcFy0yV12Bw9ldjirghI=;
        b=AekMtwb9qSkqGaB7H4hF/F9vMDu3gzdmSOjZ13AdoUT5FHii39SWfyBQFWI8hh8E0b
         abym9G4DdIagf7QeEU/9J8uBhRxBXO1IpKKYaXd0TJsPt58Oy0MBa2EfADv3l3b9CGjD
         utKaXgeFFr9FjeI8lj78BkNbY6EXSxzScJuPKK115ZWMUl45c9KK4tzEi2Pzr4dJ1trd
         TN2IEmVf9AA7rHMmqoUkh/nA0qHXtnVWze/DzpqcdQRkBozkCCHdSaGiEkXXtv1U1ukQ
         z6NfVIpgLpyjjWpydfiN36DHpXsfQDQHeuUdToXEe9eolb7Qz76p1NBBb3RsJ3g2WwJ4
         b0KQ==
X-Gm-Message-State: AOAM530w/47ByvEHrDZUwC6ahlPvarz2hE0oGlZzDe1sUw/iXopxFig5
        HCpGt5sJdUb/WhOIfM6/lI+25HK2A+M=
X-Google-Smtp-Source: ABdhPJw4qzO2fT/83eP9ukobw6P+/9PRsTwsNIyPlsfXAEYKwQOnOWENU9OVZAfuZL3HpOeET2Glgw==
X-Received: by 2002:a63:6942:0:b0:380:153e:63f9 with SMTP id e63-20020a636942000000b00380153e63f9mr17076839pgc.212.1647838782477;
        Sun, 20 Mar 2022 21:59:42 -0700 (PDT)
Received: from fedora-qemu.flets-east.jp (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id x23-20020a63fe57000000b0036490068f12sm12868770pgj.90.2022.03.20.21.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 21:59:41 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] x86/efi: Remove references of EFI earlyprintk from documentation
Date:   Mon, 21 Mar 2022 13:58:53 +0900
Message-Id: <20220321045853.3324-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

x86 EFI earlyprink was removed with commit 69c1f396f25b ("efi/x86:
Convert x86 EFI earlyprintk into generic earlycon implementation").

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..fb39337f4123 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1252,7 +1252,7 @@
 			Append ",keep" to not disable it when the real console
 			takes over.
 
-			Only one of vga, efi, serial, or usb debug port can
+			Only one of vga, serial, or usb debug port can
 			be used at a time.
 
 			Currently only ttyS0 and ttyS1 may be specified by
@@ -1267,7 +1267,7 @@
 			Interaction with the standard serial driver is not
 			very good.
 
-			The VGA and EFI output is eventually overwritten by
+			The VGA output is eventually overwritten by
 			the real console.
 
 			The xen option can only be used in Xen domains.
-- 
2.35.1

