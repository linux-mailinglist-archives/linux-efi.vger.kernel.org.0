Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB15479853
	for <lists+linux-efi@lfdr.de>; Sat, 18 Dec 2021 04:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhLRDL0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 22:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhLRDL0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Dec 2021 22:11:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22455C061574;
        Fri, 17 Dec 2021 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=62FmL4o33C3xs2kZTlQ+wejDM0H9nh66m1ctzivTtUE=; b=eSd7P83jhUrAuGbLQ+RoODXHa/
        tkFjCFGCbqE/QQFwGyGlvF17x5YSM5C0KeN8bGVREpPNi3ygOpelT1xV0dRsVqmhaQLdeTgUOzizL
        ARfxFWsBWexrtfCYYDqtFV2wvRHtGUY+aG8XGchB6OVhkH37yOUVOGgnZiATfq2yGPyiFXYspiK3w
        R/fv148vOxnpav2l2deLRI73kDVSTJ5IGyFBspdXLB2kIRGGgOdqzDpUBKZI4tBGCwz+4RnRQnnP5
        EIPtXYisfxkseY4ZUXbqcfWN5anaKje7sK+Xc6aYC+Q2hlDHWSS7AR51oGH2iNuDD/8MCo+87FykI
        +ULYqqiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myQ83-00HHCH-MC; Sat, 18 Dec 2021 03:11:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kbuild@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, efi@lists.einval.com,
        debian-kernel@lists.debian.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] builddeb: Support signing kernels with the module signing key
Date:   Sat, 18 Dec 2021 03:11:22 +0000
Message-Id: <20211218031122.4117631-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the config file specifies a signing key, use it to sign
the kernel so that machines with SecureBoot enabled can boot.
See https://wiki.debian.org/SecureBoot

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2:
 - Handle private keys stored in the pem file as well as adjacent to the
   certificate
 - Handle certificate paths specified relative to both dsttree and srctree
   (as well as absolute)
 - Only try to sign the executable if EFI_STUB is enabled
 - Only try to execute sbsign if it's in $PATH

 scripts/package/builddeb | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 91a502bb97e8..9dd92fd02b12 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -147,7 +147,30 @@ else
 	cp System.map "$tmpdir/boot/System.map-$version"
 	cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
 fi
-cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
+
+vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
+key=
+if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
+	cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
+	if [ ! -f $cert ]; then
+		cert=$srctree/$cert
+	fi
+
+	key=${cert%pem}priv
+	if [ ! -f $key ]; then
+		key=$cert
+	fi
+
+	if ! command -v sbsign >/dev/null; then
+		key=
+	fi
+fi
+
+if [ -n "$key" ]; then
+	sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
+else
+	cp "$vmlinux" "$tmpdir/$installed_image_path"
+fi
 
 if is_enabled CONFIG_OF_EARLY_FLATTREE; then
 	# Only some architectures with OF support have this target
-- 
2.33.0

