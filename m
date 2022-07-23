Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EE57F1E8
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 00:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiGWWuU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 Jul 2022 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiGWWuT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 Jul 2022 18:50:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A66B48F;
        Sat, 23 Jul 2022 15:50:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id id17so4699179wmb.1;
        Sat, 23 Jul 2022 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7i/+oBNbSPv6gyy7QeeMBbEct3Rg3KruCw1B1KBTfI=;
        b=FcEvCC0ARhH9A0KdcmZWP+DoEFl0js2I1MM/7X4zMmzI3JEx5aBl0xEwkyy+oeaWiS
         BhAXCTOrabOBj7MI+gNPuACIZaUYSnEfk54mKw7r4P6UyKU81CIIWcc6pcowiP7f4BJx
         5va4TD/MNdP/aY3cwPW7VZjfEKQDNdBI66GIB6933VP5eAYAph9n7u3xMjcov+cpf3+D
         5oAnB3pPjJkp2TXVCeiu9GkD8lNLWYDuEJHIR6ELGiuDq6dqAuHa7b6/Bb4MOU412d7J
         SUd5N283+PEi2PKm10JKVV/fiEL/rg46VegJFgsBKSbuHUfNc47ZH237d6dJokaDy2qu
         r1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7i/+oBNbSPv6gyy7QeeMBbEct3Rg3KruCw1B1KBTfI=;
        b=Vm8Bqi2225v/TltIAAdyOId3jwgnSlqYWDYVUSLyDV9w3F+amOBp9EW1SUQnQHKmkJ
         E+ZIHO7PmfDvxrfjSvU1rKLT7XQsxsYvUFLIHTLFH+dACXj8ZCNa5Qh+ukQNoknXDtxN
         uT59HY13qEApFsThKnC3L5cVLGTT43fbD0PmvrxCtyXkd0vY3D5AWgJWr7bSFB0fXQR8
         3i3DjH7zyzAT+O+8k4J4Dqs6xCtLqyNpZ/OyXQfQOn6mLXLt+Yr/MwEcUNV/s5G0OhXC
         Ij0s9U/oZPrftYEnrT4DZomy257gXOAJbbR+G52ojOCTZWHVZ1/Y8LQRHc21EYg1Mog+
         OelQ==
X-Gm-Message-State: AJIora/qk5x94QomfndsGw2IrEGy9tY/O0iRiNVdDlTFIJxYAvz3GStk
        a4jUstJCWazprFtA6yW6T54=
X-Google-Smtp-Source: AGRyM1sB4sXvt7whocsz+NY9+R5M8exddy5s9t/KZsUuqIQp5kmQdYAO5rlynep9wjLUuDz0zoThCA==
X-Received: by 2002:a05:600c:148:b0:3a3:2753:e551 with SMTP id w8-20020a05600c014800b003a32753e551mr16617042wmm.131.1658616615704;
        Sat, 23 Jul 2022 15:50:15 -0700 (PDT)
Received: from xws.localdomain (pd9ea3743.dip0.t-ipconnect.de. [217.234.55.67])
        by smtp.gmail.com with ESMTPSA id x3-20020adff0c3000000b0021deba99142sm7799284wro.40.2022.07.23.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 15:50:15 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/4] firmware: qcom_scm: Export SCM call functions
Date:   Sun, 24 Jul 2022 00:49:46 +0200
Message-Id: <20220723224949.1089973-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723224949.1089973-1-luzmaximilian@gmail.com>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Make qcom_scm_call, qcom_scm_call_atomic and associated types accessible
to other modules.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/firmware/qcom_scm.c | 118 ++++++++++++++++++++++++------------
 drivers/firmware/qcom_scm.h |  47 --------------
 include/linux/qcom_scm.h    |  49 +++++++++++++++
 3 files changed, 128 insertions(+), 86 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54c8146..1dd330ffbb9f 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -205,16 +205,17 @@ static enum qcom_scm_convention __get_convention(void)
 }
 
 /**
- * qcom_scm_call() - Invoke a syscall in the secure world
- * @dev:	device
+ * __qcom_scm_call() - Invoke a syscall in the secure world
+ * @dev:	Device. Depending on the command and number of arguments, this
+ *		is optional.
  * @desc:	Descriptor structure containing arguments and return values
  * @res:        Structure containing results from SMC/HVC call
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
  */
-static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
+static int __qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+			   struct qcom_scm_res *res)
 {
 	might_sleep();
 	switch (__get_convention()) {
@@ -229,18 +230,39 @@ static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
 	}
 }
 
+/**
+ * qcom_scm_call() - Invoke a syscall in the secure world
+ * @desc:	Descriptor structure containing arguments and return values
+ * @res:        Structure containing results from SMC/HVC call
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This should *only* be called in pre-emptible context.
+ *
+ * Returns zero on success, -ENODEV if the SCM device has not been set up yet,
+ * or other non-zero status codes on failure.
+ */
+int qcom_scm_call(const struct qcom_scm_desc *desc, struct qcom_scm_res *res)
+{
+	if (!__scm)
+		return -ENODEV;
+
+	return __qcom_scm_call(__scm->dev, desc, res);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_call);
+
 /**
  * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
- * @dev:	device
+ * @dev:	Device. Depending on the command and number of arguments, this
+ *		is optional.
  * @desc:	Descriptor structure containing arguments and return values
  * @res:	Structure containing results from SMC/HVC call
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This can be called in atomic context.
  */
-static int qcom_scm_call_atomic(struct device *dev,
-				const struct qcom_scm_desc *desc,
-				struct qcom_scm_res *res)
+static int __qcom_scm_call_atomic(struct device *dev,
+				  const struct qcom_scm_desc *desc,
+				  struct qcom_scm_res *res)
 {
 	switch (__get_convention()) {
 	case SMC_CONVENTION_ARM_32:
@@ -254,6 +276,26 @@ static int qcom_scm_call_atomic(struct device *dev,
 	}
 }
 
+/**
+ * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
+ * @desc:	Descriptor structure containing arguments and return values
+ * @res:	Structure containing results from SMC/HVC call
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This can be called in atomic context.
+ *
+ * Returns zero on success, -ENODEV if the SCM device has not been set up yet,
+ * or other non-zero status codes on failure.
+ */
+int qcom_scm_call_atomic(const struct qcom_scm_desc *desc, struct qcom_scm_res *res)
+{
+	if (!__scm)
+		return -ENODEV;
+
+	return __qcom_scm_call_atomic(__scm->dev, desc, res);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_call_atomic);
+
 static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 					 u32 cmd_id)
 {
@@ -280,7 +322,7 @@ static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 		return false;
 	}
 
-	ret = qcom_scm_call(dev, &desc, &res);
+	ret = __qcom_scm_call(dev, &desc, &res);
 
 	return ret ? false : !!res.result[0];
 }
@@ -305,7 +347,7 @@ static int qcom_scm_set_boot_addr(void *entry, const u8 *cpu_bits)
 	desc.args[0] = flags;
 	desc.args[1] = virt_to_phys(entry);
 
-	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+	return __qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 
 static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
@@ -327,7 +369,7 @@ static int qcom_scm_set_boot_addr_mc(void *entry, unsigned int flags)
 	if (!__scm || __get_convention() == SMC_CONVENTION_LEGACY)
 		return -EOPNOTSUPP;
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return __qcom_scm_call(__scm->dev, &desc, NULL);
 }
 
 /**
@@ -377,7 +419,7 @@ void qcom_scm_cpu_power_down(u32 flags)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
+	__qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_cpu_power_down);
 
@@ -394,7 +436,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -412,7 +454,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 
 	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
 
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 
 static void qcom_scm_set_download_mode(bool enable)
@@ -492,7 +534,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	desc.args[1] = mdata_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = __qcom_scm_call(__scm->dev, &desc, &res);
 
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
@@ -558,7 +600,7 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
@@ -593,7 +635,7 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
@@ -627,7 +669,7 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
@@ -659,7 +701,7 @@ bool qcom_scm_pas_supported(u32 peripheral)
 					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
 		return false;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = __qcom_scm_call(__scm->dev, &desc, &res);
 
 	return ret ? false : !!res.result[0];
 }
@@ -678,7 +720,7 @@ static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -718,8 +760,7 @@ int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 	struct qcom_scm_res res;
 	int ret;
 
-
-	ret = qcom_scm_call_atomic(__scm->dev, &desc, &res);
+	ret = qcom_scm_call_atomic(&desc, &res);
 	if (ret >= 0)
 		*val = res.result[0];
 
@@ -738,7 +779,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_io_writel);
 
@@ -768,7 +809,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -786,7 +827,7 @@ int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	if (size)
 		*size = res.result[0];
@@ -809,7 +850,7 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 	};
 	int ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = qcom_scm_call(&desc, NULL);
 
 	/* the pg table has been initialized already, ignore the error */
 	if (ret == -EPERM)
@@ -830,7 +871,7 @@ int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_iommu_set_cp_pool_size);
 
@@ -852,7 +893,7 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
 	};
 	struct qcom_scm_res res;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -880,7 +921,7 @@ static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 	};
 	struct qcom_scm_res res;
 
-	ret = qcom_scm_call(dev, &desc, &res);
+	ret = __qcom_scm_call(dev, &desc, &res);
 
 	return ret ? : res.result[0];
 }
@@ -997,7 +1038,7 @@ int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
 		.arginfo = QCOM_SCM_ARGS(4),
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_lock);
 
@@ -1020,7 +1061,7 @@ int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
 		.arginfo = QCOM_SCM_ARGS(3),
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_unlock);
 
@@ -1061,7 +1102,7 @@ int qcom_scm_ice_invalidate_key(u32 index)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
 
@@ -1122,7 +1163,7 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 	memcpy(keybuf, key, key_size);
 	desc.args[1] = key_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = qcom_scm_call(&desc, NULL);
 
 	memzero_explicit(keybuf, key_size);
 
@@ -1191,7 +1232,7 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 	if (ret)
 		return ret;
 
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	ret = qcom_scm_call(&desc, &res);
 	*resp = res.result[0];
 
 	qcom_scm_clk_disable();
@@ -1212,7 +1253,7 @@ int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_iommu_set_pt_format);
 
@@ -1227,8 +1268,7 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-
-	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
+	return qcom_scm_call_atomic(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
 
@@ -1248,7 +1288,7 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	return qcom_scm_call(__scm->dev, &desc, NULL);
+	return qcom_scm_call(&desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
 
@@ -1283,7 +1323,7 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 
 	desc.args[0] = payload_phys;
 
-	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	ret = __qcom_scm_call(__scm->dev, &desc, NULL);
 
 	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 0d51eef2472f..d058adcc62a3 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -13,53 +13,6 @@ enum qcom_scm_convention {
 
 extern enum qcom_scm_convention qcom_scm_convention;
 
-#define MAX_QCOM_SCM_ARGS 10
-#define MAX_QCOM_SCM_RETS 3
-
-enum qcom_scm_arg_types {
-	QCOM_SCM_VAL,
-	QCOM_SCM_RO,
-	QCOM_SCM_RW,
-	QCOM_SCM_BUFVAL,
-};
-
-#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
-			   (((a) & 0x3) << 4) | \
-			   (((b) & 0x3) << 6) | \
-			   (((c) & 0x3) << 8) | \
-			   (((d) & 0x3) << 10) | \
-			   (((e) & 0x3) << 12) | \
-			   (((f) & 0x3) << 14) | \
-			   (((g) & 0x3) << 16) | \
-			   (((h) & 0x3) << 18) | \
-			   (((i) & 0x3) << 20) | \
-			   (((j) & 0x3) << 22) | \
-			   ((num) & 0xf))
-
-#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-
-/**
- * struct qcom_scm_desc
- * @arginfo:	Metadata describing the arguments in args[]
- * @args:	The array of arguments for the secure syscall
- */
-struct qcom_scm_desc {
-	u32 svc;
-	u32 cmd;
-	u32 arginfo;
-	u64 args[MAX_QCOM_SCM_ARGS];
-	u32 owner;
-};
-
-/**
- * struct qcom_scm_res
- * @result:	The values returned by the secure syscall
- */
-struct qcom_scm_res {
-	u64 result[MAX_QCOM_SCM_RETS];
-};
-
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
 extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 			  enum qcom_scm_convention qcom_convention,
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..87b768dedec6 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -9,6 +9,55 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
+#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
+			   (((a) & 0x3) << 4) | \
+			   (((b) & 0x3) << 6) | \
+			   (((c) & 0x3) << 8) | \
+			   (((d) & 0x3) << 10) | \
+			   (((e) & 0x3) << 12) | \
+			   (((f) & 0x3) << 14) | \
+			   (((g) & 0x3) << 16) | \
+			   (((h) & 0x3) << 18) | \
+			   (((i) & 0x3) << 20) | \
+			   (((j) & 0x3) << 22) | \
+			   ((num) & 0xf))
+
+#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+
+#define MAX_QCOM_SCM_ARGS 10
+#define MAX_QCOM_SCM_RETS 3
+
+enum qcom_scm_arg_types {
+	QCOM_SCM_VAL,
+	QCOM_SCM_RO,
+	QCOM_SCM_RW,
+	QCOM_SCM_BUFVAL,
+};
+
+/**
+ * struct qcom_scm_desc - SCM call descriptor.
+ * @arginfo:	Metadata describing the arguments in args[]
+ * @args:	The array of arguments for the secure syscall
+ */
+struct qcom_scm_desc {
+	u32 svc;
+	u32 cmd;
+	u32 arginfo;
+	u64 args[MAX_QCOM_SCM_ARGS];
+	u32 owner;
+};
+
+/**
+ * struct qcom_scm_res - SCM call response.
+ * @result:	The values returned by the secure syscall
+ */
+struct qcom_scm_res {
+	u64 result[MAX_QCOM_SCM_RETS];
+};
+
+int qcom_scm_call(const struct qcom_scm_desc *desc, struct qcom_scm_res *res);
+int qcom_scm_call_atomic(const struct qcom_scm_desc *desc, struct qcom_scm_res *res);
+
 #define QCOM_SCM_VERSION(major, minor)	(((major) << 16) | ((minor) & 0xFF))
 #define QCOM_SCM_CPU_PWR_DOWN_L2_ON	0x0
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
-- 
2.37.1

