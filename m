Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0777295F8
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jun 2023 11:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbjFIJyW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jun 2023 05:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbjFIJyD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jun 2023 05:54:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C30C4497
        for <linux-efi@vger.kernel.org>; Fri,  9 Jun 2023 02:45:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1897863e87.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jun 2023 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686303936; x=1688895936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyPIqlqxRuU6hxzq8gXMRlVGGSvpxZkTFPb66tJ1Xqo=;
        b=UNrpvbXBRfqltDS+kyA10cskn9M8NCS7FsnSwGxZy67LMqdSrc6i2wpL8V+g37r/WH
         yH2bDzKD6yQHyFzREFL2ofIrxpRrJZr5gjiYmbMF0Z0RDTs4FgKRHdL1LKTEfZkD36AA
         cZGMcC2gFDRFPEvJqWJ8ABcU8PGw71MpJtaIKfEGgRpujg0TiHUORrbmVtqS2iL6lRv1
         sAG+uC1y4BuPNFXDYSc3wEr1selX9uamV/3O1VtfBULIChPCm0tr7VW2brL8sSgOWyJU
         VCjCwjFr7bu2frRGQ/abg0ZyLhsUN9w1HkwVaVZGgo3anTZ9hyDtKvDyGlQ5xnT/2jAU
         o+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303936; x=1688895936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyPIqlqxRuU6hxzq8gXMRlVGGSvpxZkTFPb66tJ1Xqo=;
        b=bxmqMVuXvULv4ZRU/8byyxwQj461Aj9BilQ4Zpd1OjlZWA1leOxP2kcISqW7HhxBW/
         RWafc3uwFpkdCaTu28ckVGDrad8MAO8+1mw8pbD7Phpt1aeOZiQyCZ86ognT+34DIKWw
         M933GQCJzIrvcpBeulmyQKT9OvvAoN8rdnGn2+gyMoZsalaOFC4/SDJtK27WGE9Wq645
         neuucWOLhYaecAckD7ObfbdKdjTXcMJDlBpYkelMURy8s66eHICdQ9OVtP/UyyEeqfyf
         x/IJzBIehgALAWw5b5g1Jc6B1ciGpZSKbRN1bhQIpP+kyxghCZg0JqJjynnmI99rUJFj
         0w2g==
X-Gm-Message-State: AC+VfDxKxIK3uwa2OdyXphQy6qvhpeoXQcIhrJfAUaOm9ZgrBFQOATG9
        myV9XK/CYmU9J8O3eFpMWoCeptmqTMYnXmsUePgH7A==
X-Google-Smtp-Source: ACHHUZ6jqJz6Av9WC5URKovNOaKHk2nHULDzFC8UZ9uWQe8LC3rchhQ2xb4qu/K7ekAKldta5+nb2g==
X-Received: by 2002:a19:6402:0:b0:4f6:5068:3c11 with SMTP id y2-20020a196402000000b004f650683c11mr493536lfb.40.1686303935819;
        Fri, 09 Jun 2023 02:45:35 -0700 (PDT)
Received: from hades.. ([2a02:85f:fc18:36c8:3efd:feff:fe6b:c5ca])
        by smtp.gmail.com with ESMTPSA id cs6-20020a056000088600b0030ae849c70csm3954693wrb.37.2023.06.09.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:45:35 -0700 (PDT)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     ardb@kernel.org
Cc:     jan.kiszka@siemens.com, masahisa.kojima@linaro.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efivarfs: force RO when remounting if SetVariable is not supported
Date:   Fri,  9 Jun 2023 12:45:32 +0300
Message-Id: <20230609094532.562934-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If SetVariable at runtime is not supported by the firmware we never assign
a callback for that function. At the same time mount the efivarfs as
RO so no one can call that.  However, we never check the permission flags
when someone remounts the filesystem as RW. As a result this leads to a
crash looking like this:

$ mount -o remount,rw /sys/firmware/efi/efivars
$ efi-updatevar -f PK.auth PK

[  303.279166] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  303.280482] Mem abort info:
[  303.280854]   ESR = 0x0000000086000004
[  303.281338]   EC = 0x21: IABT (current EL), IL = 32 bits
[  303.282016]   SET = 0, FnV = 0
[  303.282414]   EA = 0, S1PTW = 0
[  303.282821]   FSC = 0x04: level 0 translation fault
[  303.283771] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004258c000
[  303.284913] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  303.286076] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
[  303.286936] Modules linked in: qrtr tpm_tis tpm_tis_core crct10dif_ce arm_smccc_trng rng_core drm fuse ip_tables x_tables ipv6
[  303.288586] CPU: 1 PID: 755 Comm: efi-updatevar Not tainted 6.3.0-rc1-00108-gc7d0c4695c68 #1
[  303.289748] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04-00627-g88336918701d 04/01/2023
[  303.291150] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  303.292123] pc : 0x0
[  303.292443] lr : efivar_set_variable_locked+0x74/0xec
[  303.293156] sp : ffff800008673c10
[  303.293619] x29: ffff800008673c10 x28: ffff0000037e8000 x27: 0000000000000000
[  303.294592] x26: 0000000000000800 x25: ffff000002467400 x24: 0000000000000027
[  303.295572] x23: ffffd49ea9832000 x22: ffff0000020c9800 x21: ffff000002467000
[  303.296566] x20: 0000000000000001 x19: 00000000000007fc x18: 0000000000000000
[  303.297531] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaac807ab54
[  303.298495] x14: ed37489f673633c0 x13: 71c45c606de13f80 x12: 47464259e219acf4
[  303.299453] x11: ffff000002af7b01 x10: 0000000000000003 x9 : 0000000000000002
[  303.300431] x8 : 0000000000000010 x7 : ffffd49ea8973230 x6 : 0000000000a85201
[  303.301412] x5 : 0000000000000000 x4 : ffff0000020c9800 x3 : 00000000000007fc
[  303.302370] x2 : 0000000000000027 x1 : ffff000002467400 x0 : ffff000002467000
[  303.303341] Call trace:
[  303.303679]  0x0
[  303.303938]  efivar_entry_set_get_size+0x98/0x16c
[  303.304585]  efivarfs_file_write+0xd0/0x1a4
[  303.305148]  vfs_write+0xc4/0x2e4
[  303.305601]  ksys_write+0x70/0x104
[  303.306073]  __arm64_sys_write+0x1c/0x28
[  303.306622]  invoke_syscall+0x48/0x114
[  303.307156]  el0_svc_common.constprop.0+0x44/0xec
[  303.307803]  do_el0_svc+0x38/0x98
[  303.308268]  el0_svc+0x2c/0x84
[  303.308702]  el0t_64_sync_handler+0xf4/0x120
[  303.309293]  el0t_64_sync+0x190/0x194
[  303.309794] Code: ???????? ???????? ???????? ???????? (????????)
[  303.310612] ---[ end trace 0000000000000000 ]---

Fix this by adding a .reconfigure() function to the fs operations which
we can use to check the requested flags and deny anything that's not RO
if the firmware doesn't implement SetVariable at runtime.

Fixes: f88814cc2578 ("efi/efivars: Expose RT service availability via efivars abstraction")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/efivarfs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..2a55e5bc9ac1 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/statfs.h>
+#include <linux/printk.h>
 
 #include "internal.h"
 
@@ -269,8 +270,19 @@ static int efivarfs_get_tree(struct fs_context *fc)
 	return get_tree_single(fc, efivarfs_fill_super);
 }
 
+static int efivarfs_reconfigure(struct fs_context *fc)
+{
+	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
+		pr_err("Firmware does not support SetVariableRT. Can not remount with rw\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
+	.reconfigure	= efivarfs_reconfigure,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
-- 
2.37.2

