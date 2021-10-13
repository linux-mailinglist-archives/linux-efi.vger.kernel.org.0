Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C742CAAE
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhJMUJh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 16:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhJMUJg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Oct 2021 16:09:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9102C061570;
        Wed, 13 Oct 2021 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RXVnMLzX0n92WenFQsNXvxZfnumwQy6spJ6FkB8/pLo=; b=n+Ps40O18Scs0fFFiCjsG5RddG
        L2h5n411+IZlaZPnon3TgZNCz2kx5vWiWsuVXQPy4kgzVnCbsLLbmvUnzF7+J7iQp9uHRruUyWnof
        e8Wo8oNWTJQ1boA+tzSvIgoJ4U2nqO9Kn4kPmjgjCG4tgFpUjVeOeB49EoqleT1iUZfpzNrVjCURU
        lZ8SYwoqU+xd1yYPgJ6seMYYzU2bcnpIRW0ESYLVJl2Ah4ENaQFDlbr3xF3fGAeO9jylhlq9XcTsN
        niyKlGK0qHsiuX1YhcFT65Fs6gLyl6NcLrnCVRmDmXumDutE336gLYahXFyVdcrWGRkCB7TB7qxtu
        VHmi3OJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1makVR-007lZ6-EL; Wed, 13 Oct 2021 20:06:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        efi@lists.einval.com, debian-kernel@lists.debian.org,
        linux-efi@vger.kernel.org
Subject: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
Date:   Wed, 13 Oct 2021 21:05:36 +0100
Message-Id: <20211013200536.1851070-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the config file specifies a signing key, use it to sign
the kernel so that machines with SecureBoot enabled can boot.
See https://wiki.debian.org/SecureBoot

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 scripts/package/builddeb | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 91a502bb97e8..4fa6ff2b5cac 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -147,7 +147,15 @@ else
 	cp System.map "$tmpdir/boot/System.map-$version"
 	cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
 fi
-cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
+
+vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
+if is_enabled CONFIG_MODULE_SIG; then
+	cert=$srctree/$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
+	key=${cert%pem}priv
+	sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
+else
+	cp "$vmlinux" "$tmpdir/$installed_image_path"
+fi
 
 if is_enabled CONFIG_OF_EARLY_FLATTREE; then
 	# Only some architectures with OF support have this target
-- 
2.32.0

