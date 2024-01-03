Return-Path: <linux-efi+bounces-306-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F682353C
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4DE1F22F05
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF61CA8D;
	Wed,  3 Jan 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="i6R47X4u"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878C1CA89;
	Wed,  3 Jan 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vMknRd2IeAkhytegZh++FkiNzCsbQVcssck3V7umEBM=; b=i6R47X4utC8GiDtInju3x5Qy4/
	M7a+qp7J0+4yapChPdXFiYvMnjKO+6Ag+qM8MElwzN3XYQ6dHNHj2DkFlbPYENi/YFOLdcCrpWTTH
	zBx0ErhvwYqIPp0p9tTvn2MRv803XYlDuVXH/JYyGr1bDI3e61FOiV+eBMDK7ysrwufi2QKkFp3Zo
	3fhLk59maOy5mJynXf3HfcyEU6QDgvzSnJwsRbnIJhA9f6hocsESYCwmTUGHFFKHRLxuU0RvWGwDq
	yCKHgf4AsEHQkVYL3oO+A+exdvUfwGLDOp1DXvZKfNAF633oTEp6GpiMz5T8WVOdomS8vjye8fBDA
	z/wChw8w==;
Received: from [191.193.161.120] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rL6Ar-002o6C-Sm; Wed, 03 Jan 2024 19:41:06 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: ardb@kernel.org,
	linux-efi@vger.kernel.org
Cc: keescook@chromium.org,
	tony.luck@intel.com,
	linux-hardening@vger.kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] efi: pstore: Allow dynamic initialization based on module parameter
Date: Wed,  3 Jan 2024 15:40:32 -0300
Message-ID: <20240103184053.226203-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efi-pstore module parameter "pstore_disable" warrants that users
are able to deactivate such backend. There is also a Kconfig option
for the default value of this parameter. It was originally added due
to some bad UEFI FW implementations that could break with many variables
written.

Some distros (such as Arch Linux) set this in their config file still
nowadays. And once it is set, even being a writable module parameter,
there is effectively no way to make use of efi-pstore anymore.
If "pstore_disable" is set to true, the init function of the module exits
early and is never called again after the initcall processing.

Let's switch this module parameter to have a callback and perform the
pstore backend registration again each time it's set from Y->N (and
vice-versa). With this, the writable nature of the parameter starts to
make sense, given that users now can switch back to using efi-pstore
or not during runtime by writing into it.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c | 43 +++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index e7b9ec6f8a86..833cbb995dd3 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -14,16 +14,43 @@ static unsigned int record_size = 1024;
 module_param(record_size, uint, 0444);
 MODULE_PARM_DESC(record_size, "size of each pstore UEFI var (in bytes, min/default=1024)");
 
-static bool efivars_pstore_disable =
-	IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
-
-module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
-
 #define PSTORE_EFI_ATTRIBUTES \
 	(EFI_VARIABLE_NON_VOLATILE | \
 	 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
+static bool pstore_disable = IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
+
+static int efivars_pstore_init(void);
+static void efivars_pstore_exit(void);
+
+static int efi_pstore_disable_set(const char *val, const struct kernel_param *kp)
+{
+	int err;
+	bool old_pstore_disable = pstore_disable;
+
+	err = param_set_bool(val, kp);
+	if (err)
+		return err;
+
+	if (old_pstore_disable != pstore_disable) {
+		if (pstore_disable)
+			efivars_pstore_exit();
+		else
+			efivars_pstore_init();
+	}
+
+	return 0;
+}
+
+static const struct kernel_param_ops pstore_disable_ops = {
+	.set	= efi_pstore_disable_set,
+	.get	= param_get_bool,
+};
+
+module_param_cb(pstore_disable, &pstore_disable_ops, &pstore_disable, 0644);
+__MODULE_PARM_TYPE(pstore_disable, "bool");
+
 static int efi_pstore_open(struct pstore_info *psi)
 {
 	int err;
@@ -218,12 +245,12 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
-static __init int efivars_pstore_init(void)
+static int efivars_pstore_init(void)
 {
 	if (!efivar_supports_writes())
 		return 0;
 
-	if (efivars_pstore_disable)
+	if (pstore_disable)
 		return 0;
 
 	/*
@@ -250,7 +277,7 @@ static __init int efivars_pstore_init(void)
 	return 0;
 }
 
-static __exit void efivars_pstore_exit(void)
+static void efivars_pstore_exit(void)
 {
 	if (!efi_pstore_info.bufsize)
 		return;
-- 
2.43.0


