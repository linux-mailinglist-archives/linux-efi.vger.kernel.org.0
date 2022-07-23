Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FF57F1EB
	for <lists+linux-efi@lfdr.de>; Sun, 24 Jul 2022 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiGWWuV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 Jul 2022 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiGWWuU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 Jul 2022 18:50:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3DDEBF;
        Sat, 23 Jul 2022 15:50:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h8so11054044wrw.1;
        Sat, 23 Jul 2022 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4feOfgdszd52ign/rC5yr4G94ED3BCh3olKGZLq9jY=;
        b=HobejFmBqaA3QY+GQhb38Vr+H7EUXYq4dLPswmMXNAh3OCspZ7n5njAvmRnZ+/TJ/w
         bpO2A4OFwzfGX6Q4ab+YeCkJUVgo+9M0v/02WzDSDQ+B+EnsZ33n+az/iHCTYwKvoP5C
         4SHJXNexDgATBzGO1wqlOWxfwKbb8juxIVl1eZltLKEBUjeBOJVE6o5aVASKahAk+40f
         yP2z+KMqHbI5MPk1+DND0C1hiDD/ULpGQUAV/neynRnARbjefoqLxMzpR4UfJwvW9FNq
         JhN5FU3SdLbjtwzDPL404m+URnE0+w849nytBrxy2ybLg8dB4NpzK6y4MThw+KGOJt1c
         2IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4feOfgdszd52ign/rC5yr4G94ED3BCh3olKGZLq9jY=;
        b=5L/woKoUqEEQbOAB062PWDV+CjyovNOgew9DnCO1/wAnZCmAGVtnYKOQhbneuHw+8s
         zfzh/2gDIth8piYS+F95QzGsD3VSHiOJu4YtkQ04yPQnb2tEDudSdOBBdEcmCB01bW98
         b9nnvzinA5XfHAvzPDnDDas7Y6mdH/5PqsHhEZtOO05ThX0mBkOfPipnI7kEIwDv/xP9
         jvNiJoRiUoeMmaTcm87XPeoFnjuz/pZ+eC8hky5+b4+V/1kn8hAqLXERPhi57mP2iT3S
         nWehFdfzSPv+NFdBqPdkFmWq1zxSB/WkZ751v4/ZRKnWpAQRyTrP/hysPPAlmjfZEQjL
         RdxQ==
X-Gm-Message-State: AJIora+KsTKiqyFVhfx5tWJ+JJ9ejXJUao8njh6ODtjUt9LT3q8SAX8o
        y2Ifm8jTwOSIbh7cRYcmdw3Yp990LZo=
X-Google-Smtp-Source: AGRyM1tjDcbL+26/64wg71B8JLS1bO8J0lqwNSwLRq5PsPCUf3BPMAH//g6ClaZ+cjTlET8yKPQ0DA==
X-Received: by 2002:a05:6000:18a2:b0:21d:bc7c:1c83 with SMTP id b2-20020a05600018a200b0021dbc7c1c83mr3577150wri.420.1658616616855;
        Sat, 23 Jul 2022 15:50:16 -0700 (PDT)
Received: from xws.localdomain (pd9ea3743.dip0.t-ipconnect.de. [217.234.55.67])
        by smtp.gmail.com with ESMTPSA id x3-20020adff0c3000000b0021deba99142sm7799284wro.40.2022.07.23.15.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 15:50:16 -0700 (PDT)
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
Subject: [PATCH 2/4] firmware: Add support for Qualcomm Trusted Execution Environment SCM calls
Date:   Sun, 24 Jul 2022 00:49:47 +0200
Message-Id: <20220723224949.1089973-3-luzmaximilian@gmail.com>
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

Add support for SCM calls to Secure OS and the Trusted Execution
Environment (TEE/TrEE) residing in the TrustZone (TZ). This allows
communication with Secure/TZ applications, for example 'uefisecapp'
managing access to UEFI variables.

While this patch introduces only a very basic interface without the more
advanced features (such as re-entrant and blocking SCM calls and
listeners/callbacks), this is enough to talk to the aforementioned
'uefisecapp'.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS                 |   7 ++
 drivers/firmware/Kconfig    |   4 +
 drivers/firmware/Makefile   |   1 +
 drivers/firmware/qcom_tee.c | 213 ++++++++++++++++++++++++++++++++++++
 include/linux/qcom_tee.h    | 179 ++++++++++++++++++++++++++++++
 5 files changed, 404 insertions(+)
 create mode 100644 drivers/firmware/qcom_tee.c
 create mode 100644 include/linux/qcom_tee.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e9eaceeb61ef..e174747df92f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16587,6 +16587,13 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
+QUALCOMM TRUSTED EXECUTION ENVIRONMENT DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom_tee.c
+F:	include/linux/qcom_tee.h
+
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
 M:	Thara Gopinath <thara.gopinath@linaro.org>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..cde60a332b3c 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,10 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config QCOM_TEE
+	tristate
+	select QCOM_SCM
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..93dbc6b5a603 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_TEE)		+= qcom_tee.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom_tee.c b/drivers/firmware/qcom_tee.c
new file mode 100644
index 000000000000..7a93776a901d
--- /dev/null
+++ b/drivers/firmware/qcom_tee.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Interface driver for the Qualcomm Trusted Execution Environment (TrEE or
+ * TEE) / TrustZone secure OS (TzOS). Manages communication via Secure Channel
+ * Manager (SCM) calls.
+ *
+ * Copyright (C) 2022 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/barrier.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/qcom_scm.h>
+#include <linux/string.h>
+
+#include <linux/qcom_tee.h>
+
+
+/* -- Secure-OS SCM call interface. ----------------------------------------- */
+
+static DEFINE_MUTEX(scm_call_lock);
+
+static int __qctee_os_scm_call(const struct qcom_scm_desc *desc,
+			       struct qctee_os_scm_resp *res)
+{
+	struct qcom_scm_res scm_res = {};
+	int status;
+
+	status = qcom_scm_call(desc, &scm_res);
+
+	res->status = scm_res.result[0];
+	res->resp_type = scm_res.result[1];
+	res->data = scm_res.result[2];
+
+	if (status)
+		return status;
+
+	return 0;
+}
+
+/**
+ * qctee_os_scm_call() - Perform a TrEE SCM call.
+ * @dev:  The (client) device to use for logging.
+ * @desc: SCM call descriptor.
+ * @res:  SCM call response (output).
+ *
+ * Performs the TrEE SCM call described by @desc, returning the response in
+ * @rsp. The provided device @dev is used exclusively for logging.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+int qctee_os_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+		      struct qctee_os_scm_resp *res)
+{
+	int status;
+
+	/*
+	 * Note: Multiple TrEE SCM calls should not be executed same time, so
+	 * lock things here. This needs to be extended to callback/listener
+	 * handling when support for that is implemented.
+	 */
+
+	mutex_lock(&scm_call_lock);
+	status = __qctee_os_scm_call(desc, res);
+	mutex_unlock(&scm_call_lock);
+
+	dev_dbg(dev, "%s: owner=%x, svc=%x, cmd=%x, status=%lld, type=%llx, data=%llx",
+		__func__, desc->owner, desc->svc, desc->cmd, res->status,
+		res->resp_type, res->data);
+
+	if (status) {
+		dev_err(dev, "qcom_scm_call failed with error %d\n", status);
+		return status;
+	}
+
+	/*
+	 * TODO: Handle incomplete and blocked calls:
+	 *
+	 * Incomplete and blocked calls are not supported yet. Some devices
+	 * and/or commands require those, some don't. Let's warn about them
+	 * prominently in case someone attempts to try these commands with a
+	 * device/command combination that isn't supported yet.
+	 */
+	WARN_ON(res->status == QCTEE_OS_RESULT_INCOMPLETE);
+	WARN_ON(res->status == QCTEE_OS_RESULT_BLOCKED_ON_LISTENER);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qctee_os_scm_call);
+
+
+/* -- Secure App interface. ------------------------------------------------- */
+
+/**
+ * qctee_app_get_id() - Query the app ID for a given TrEE app name.
+ * @dev:      The (client) device used for logging and DMA mapping.
+ * @app_name: The name of the app.
+ * @app_id:   The returned app ID.
+ *
+ * Query and return the application ID of the TrEE app identified by the given
+ * name. This returned ID is the unique identifier of the app required for
+ * subsequent communication.
+ *
+ * Return: Returns zero on success, nonzero on failure. Returns -ENOENT if the
+ * app has not been loaded or could not be found.
+ */
+int qctee_app_get_id(struct device *dev, const char *app_name, u32 *app_id)
+{
+	unsigned long name_buf_size = QCTEE_MAX_APP_NAME_SIZE;
+	unsigned long app_name_len = strlen(app_name);
+	struct qcom_scm_desc desc = {};
+	struct qctee_os_scm_resp res = {};
+	dma_addr_t name_buf_phys;
+	char *name_buf;
+	int status;
+
+	if (app_name_len >= name_buf_size)
+		return -EINVAL;
+
+	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	if (!name_buf)
+		return -ENOMEM;
+
+	memcpy(name_buf, app_name, app_name_len);
+
+	name_buf_phys = dma_map_single(dev, name_buf, name_buf_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, name_buf_phys)) {
+		kfree(name_buf);
+		dev_err(dev, "failed to map dma address\n");
+		return -EFAULT;
+	}
+
+	desc.owner = QCTEE_TZ_OWNER_QSEE_OS;
+	desc.svc = QCTEE_TZ_SVC_APP_MGR;
+	desc.cmd = 0x03;
+	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
+	desc.args[0] = name_buf_phys;
+	desc.args[1] = app_name_len;
+
+	status = qctee_os_scm_call(dev, &desc, &res);
+	dma_unmap_single(dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
+	kfree(name_buf);
+
+	if (status)
+		return status;
+
+	if (res.status != QCTEE_OS_RESULT_SUCCESS)
+		return -ENOENT;
+
+	*app_id = res.data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qctee_app_get_id);
+
+/**
+ * qctee_app_send() - Send to and receive data from a given TrEE app.
+ * @dev:    The (client) device used for logging.
+ * @app_id: The ID of the app to communicate with.
+ * @req:    DMA region of the request sent to the app.
+ * @rsp:    DMA region of the response returned by the app.
+ *
+ * Sends a request to the TrEE app identified by the given ID and read back its
+ * response. The caller must provide two DMA memory regions, one for the
+ * request and one for the response, and fill out the @req region with the
+ * respective (app-specific) request data. The TrEE app reads this and returns
+ * its response in the @rsp region.
+ *
+ * Return: Returns zero on success, nonzero on failure.
+ */
+int qctee_app_send(struct device *dev, u32 app_id, struct qctee_dma *req, struct qctee_dma *rsp)
+{
+	struct qctee_os_scm_resp res = {};
+	int status;
+
+	struct qcom_scm_desc desc = {
+		.owner = QCTEE_TZ_OWNER_TZ_APPS,
+		.svc = QCTEE_TZ_SVC_APP_ID_PLACEHOLDER,
+		.cmd = 0x01,
+		.arginfo = QCOM_SCM_ARGS(5, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[0] = app_id,
+		.args[1] = req->phys,
+		.args[2] = req->size,
+		.args[3] = rsp->phys,
+		.args[4] = rsp->size,
+	};
+
+	/* Make sure the request is fully written before sending it off. */
+	dma_wmb();
+
+	status = qctee_os_scm_call(dev, &desc, &res);
+
+	/* Make sure we don't attempt any reads before the SCM call is done. */
+	dma_rmb();
+
+	if (status)
+		return status;
+
+	if (res.status != QCTEE_OS_RESULT_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qctee_app_send);
+
+
+/* -- Module metadata. ------------------------------------------------------ */
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Interface for Qualcomm TrEE/TZ secure OS and secure applications");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/qcom_tee.h b/include/linux/qcom_tee.h
new file mode 100644
index 000000000000..b904d6a010d7
--- /dev/null
+++ b/include/linux/qcom_tee.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Interface driver for the Qualcomm Trusted Execution Environment (TrEE/TEE) /
+ * TrustZone OS (TzOS). Manages communication via Secure Channel Manager (SCM)
+ * calls.
+ *
+ * Copyright (C) 2022 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _LINUX_QCOM_TEE_H
+#define _LINUX_QCOM_TEE_H
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/qcom_scm.h>
+#include <linux/types.h>
+
+
+/* -- DMA helpers. ---------------------------------------------------------- */
+
+/* DMA requirements for TrEE SCM calls. */
+#define QCTEE_DMA_ALIGNMENT		8
+#define QCTEE_DMA_ALIGN(ptr)		ALIGN(ptr, QCTEE_DMA_ALIGNMENT)
+
+/**
+ * struct qctee_dma - DMA memory region.
+ * @size: Size of the memory region, in bytes.
+ * @virt: Pointer / virtual address to the memory, accessible by the kernel.
+ * @phys: Physical address of the memory region.
+ */
+struct qctee_dma {
+	unsigned long size;
+	void *virt;
+	dma_addr_t phys;
+};
+
+/**
+ * qctee_dma_alloc() - Allocate a DMA-able memory region suitable for TrEE SCM
+ * calls.
+ * @dev:  The device used for DMA memory allocation.
+ * @dma:  Where to write the allocated memory addresses and size to.
+ * @size: Minimum size of the memory to be allocated.
+ * @gfp:  Flags used for allocation.
+ *
+ * Allocate a DMA-able memory region suitable for interaction with TrEE
+ * services and the TzOS. The provided size is treated as the minimum required
+ * size and rounded up, if necessary. The actually allocated memory region will
+ * be stored in @dma. Allocated memory must be freed via qctee_dma_free().
+ *
+ * Return: Returns zero on success, -ENOMEM on allocation failure.
+ */
+static inline int qctee_dma_alloc(struct device *dev, struct qctee_dma *dma,
+				  unsigned long size, gfp_t gfp)
+{
+	size = PAGE_ALIGN(size);
+
+	dma->virt = dma_alloc_coherent(dev, size, &dma->phys, GFP_KERNEL);
+	if (!dma->virt)
+		return -ENOMEM;
+
+	dma->size = size;
+	return 0;
+}
+
+/**
+ * qctee_dma_free() - Free a DMA memory region.
+ * @dev: The device used for allocation.
+ * @dma: The DMA region to be freed.
+ *
+ * Free a DMA region previously allocated via qctee_dma_alloc(). Note that
+ * freeing sub-regions is not supported.
+ */
+static inline void qctee_dma_free(struct device *dev, struct qctee_dma *dma)
+{
+	dma_free_coherent(dev, dma->size, dma->virt, dma->phys);
+}
+
+/**
+ * qctee_dma_realloc() - Re-allocate DMA memory region with the requested size.
+ * @dev:  The device used for allocation.
+ * @dma:  The region descriptor to be updated.
+ * @size: The new requested size.
+ * @gfp:  Flags used for allocation.
+ *
+ * Re-allocates a DMA memory region suitable for TrEE SCM calls to fit the
+ * requested amount of bytes, if necessary. Does nothing if the provided region
+ * already has enough space to store the requested data.
+ *
+ * See qctee_dma_alloc() for details.
+ *
+ * Return: Returns zero on success, -ENOMEM on allocation failure.
+ */
+static inline int qctee_dma_realloc(struct device *dev, struct qctee_dma *dma,
+				    unsigned long size, gfp_t gfp)
+{
+	if (PAGE_ALIGN(size) <= dma->size)
+		return 0;
+
+	qctee_dma_free(dev, dma);
+	return qctee_dma_alloc(dev, dma, size, gfp);
+}
+
+/**
+ * qctee_dma_aligned() - Create a aligned DMA memory sub-region suitable for
+ * TrEE SCM calls.
+ * @base:   Base DMA memory region, in which the new region will reside.
+ * @out:    Descriptor to store the aligned sub-region in.
+ * @offset: The offset inside base region at which to place the new sub-region.
+ *
+ * Creates an aligned DMA memory region suitable for TrEE SCM calls at or after
+ * the given offset. The size of the sub-region will be set to the remaining
+ * size in the base region after alignment, i.e. the end of the sub-region will
+ * be equal the end of the base region.
+ *
+ * Return: Returns zero on success or -EINVAL if the new aligned memory address
+ * would point outside the base region.
+ */
+static inline int qctee_dma_aligned(const struct qctee_dma *base, struct qctee_dma *out,
+				    unsigned long offset)
+{
+	void *aligned = (void *)QCTEE_DMA_ALIGN((uintptr_t)base->virt + offset);
+
+	if (aligned - base->virt > base->size)
+		return -EINVAL;
+
+	out->virt = aligned;
+	out->phys = base->phys + (out->virt - base->virt);
+	out->size = base->size - (out->virt - base->virt);
+
+	return 0;
+}
+
+
+/* -- Secure-OS SCM call interface. ----------------------------------------- */
+
+#define QCTEE_TZ_OWNER_TZ_APPS			48
+#define QCTEE_TZ_OWNER_QSEE_OS			50
+
+#define QCTEE_TZ_SVC_APP_ID_PLACEHOLDER		0
+#define QCTEE_TZ_SVC_APP_MGR			1
+
+enum qctee_os_scm_result {
+	QCTEE_OS_RESULT_SUCCESS			= 0,
+	QCTEE_OS_RESULT_INCOMPLETE		= 1,
+	QCTEE_OS_RESULT_BLOCKED_ON_LISTENER	= 2,
+	QCTEE_OS_RESULT_FAILURE			= 0xFFFFFFFF,
+};
+
+enum qctee_os_scm_resp_type {
+	QCTEE_OS_SCM_RES_APP_ID			= 0xEE01,
+	QCTEE_OS_SCM_RES_QSEOS_LISTENER_ID	= 0xEE02,
+};
+
+/**
+ * struct qctee_os_scm_resp - TrEE / TzOS SCM call response.
+ * @status:    Status of the SCM call. See &enum qctee_os_scm_result.
+ * @resp_type: Type of the response. See &enum qctee_os_scm_resp_type.
+ * @data:      Response data. The type of this data is given in @resp_type.
+ */
+struct qctee_os_scm_resp {
+	u64 status;
+	u64 resp_type;
+	u64 data;
+};
+
+int qctee_os_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+		      struct qctee_os_scm_resp *res);
+
+
+/* -- Secure App interface. ------------------------------------------------- */
+
+#define QCTEE_MAX_APP_NAME_SIZE			64
+
+int qctee_app_get_id(struct device *dev, const char *app_name, u32 *app_id);
+int qctee_app_send(struct device *dev, u32 app_id, struct qctee_dma *req, struct qctee_dma *rsp);
+
+#endif /* _LINUX_QCOM_TEE_H */
-- 
2.37.1

