Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1269C4E7
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 06:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBTFTL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 00:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTFTK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 00:19:10 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8926C93EA
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:19:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 7so959399pfo.13
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxMFKT5lk8snGUJdFU1LdD5wffjtjklYHwMyYDkEL48=;
        b=O4BtuRUzqVZhMrjM1VrldQm0R5o0PlGH8iNSZxMTBlCwls2UHTDaH1CsG+15wm+bHu
         jBsRXygTlTJ4EoRc5A0U4GZr3atrAwBGqzZoiDjAzfWeQ0Ix8WRJArJrWVsxFeVZAkvU
         /Nud35+mEea3J9DbrivFXRXiOPQAm8ZS4Ka4jFHUFLZjMjDpW6UvwCrGMsWu1zaHRwuT
         wIOOVca5jmH+w8brMDAchGyOdd+WayrBWXR+6rJlKKzdcZJRjmNhfqfqUoUY8xCc0aHq
         bb+YAuHm3CnfPqZLCJicBxl83GlF3gThe7mrK+ct1SqJf6lmCXvnRBSoXeH+XQC/xhN6
         26Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxMFKT5lk8snGUJdFU1LdD5wffjtjklYHwMyYDkEL48=;
        b=4aDQVGB1MTm0pgghDg2eTfLu8Yla4dCGvt7tnmGRXzvM6hmJflbSSwJIZ1ewY9kuP0
         HkuSyQ1h2/LiXSbMKlitYI0Ugg9MUUqvk/VmLHOComRwgKIBR+0NcUUWQzXbJ0wchGVy
         +zTi90qBADRhAvpAkJEA+vdhKdVpZS74XH+FUjcUi9JlCo4j8UDC2N7tXbmyBSffJTg0
         Gdvf8BMV9gf/b3uNSEN4hIBu8ncJdtts+vxHjhon/nt0VrtGY+c7poQHwwNhw2FXxo2Y
         /8kovPiYu3aBLzCzoOneDdd5Ranwa6/95L4z+UnQU00snM7gh0ylC+N2yOuryj9q+SrI
         2X3Q==
X-Gm-Message-State: AO0yUKXJDOgP8m4bF1znvqLUkP/OhlvZxohV/u0oTgFVRTBem3kjMBAf
        cEnotvq91QXGgqQgYlO3eP4tOg==
X-Google-Smtp-Source: AK7set+UXPdInGCns5/ZJoHWDlulahYAB/jO0QJl7ESpTPYRZyE2pl+SkeSAMxUCOaF7aY+ZFwyISA==
X-Received: by 2002:aa7:9ad1:0:b0:5a8:eb62:293e with SMTP id x17-20020aa79ad1000000b005a8eb62293emr396494pfp.7.1676870344728;
        Sun, 19 Feb 2023 21:19:04 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm3192087pfn.107.2023.02.19.21.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 21:19:03 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] efi: Add tee-based EFI variable driver
Date:   Mon, 20 Feb 2023 14:17:22 +0900
Message-Id: <20230220051723.1257-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230220051723.1257-1-masahisa.kojima@linaro.org>
References: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When the flash is not owned by the non-secure world, accessing the EFI
variables is straightforward and done via EFI Runtime Variable Services.
In this case, critical variables for system integrity and security
are normally stored in the dedicated secure storage and only accessible
from the secure world.

On the other hand, the small embedded devices don't have the special
dedicated secure storage. The eMMC device with an RPMB partition is
becoming more common, we can use an RPMB partition to store the
EFI Variables.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
eMMC driver and tee-supplicant. The last piece is the tee-based
variable access driver to interact with TEE and StandaloneMM.

So let's add the kernel functions needed.

This feature is implemented as a kernel module.
StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
so that this tee_stmm_efi module is probed after tee-supplicant starts,
since "SetVariable" EFI Runtime Variable Service requires to
interact with tee-supplicant.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/stmm/mm_communication.h | 249 ++++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 620 +++++++++++++++++++
 4 files changed, 885 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 043ca31c114e..8fed46d72999 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -287,3 +287,18 @@ config UEFI_CPER_X86
 	bool
 	depends on UEFI_CPER && X86
 	default y
+
+config TEE_STMM_EFI
+	tristate "TEE based EFI runtime variable service driver"
+	depends on OPTEE && !EFI_VARS_PSTORE
+	help
+	  Select this config option if TEE is compiled to include StandAloneMM
+	  as a separate secure partition it has the ability to check and store
+	  EFI variables on an RPMB or any other non-volatile medium used by
+	  StandAloneMM.
+
+	  Enabling this will change the EFI runtime services from the firmware
+	  provided functions to TEE calls.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called tee_stmm_efi.
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index b51f2a4c821e..2ca8ee6ab490 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_TEE_STMM_EFI)		+= stmm/tee_stmm_efi.o
diff --git a/drivers/firmware/efi/stmm/mm_communication.h b/drivers/firmware/efi/stmm/mm_communication.h
new file mode 100644
index 000000000000..a7fa6723d56e
--- /dev/null
+++ b/drivers/firmware/efi/stmm/mm_communication.h
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Headers for EFI variable service via StandAloneMM, EDK2 application running
+ *  in OP-TEE
+ *
+ *  Copyright (c) 2017, Intel Corporation. All rights reserved.
+ *  Copyright (C) 2020 Linaro Ltd.
+ */
+
+#ifndef _MM_COMMUNICATION_H_
+#define _MM_COMMUNICATION_H_
+
+/*
+ * Interface to the pseudo Trusted Application (TA), which provides a
+ * communication channel with the Standalone MM (Management Mode)
+ * Secure Partition running at Secure-EL0
+ */
+
+#define PTA_STMM_CMD_COMMUNICATE 0
+
+/* OP-TEE is using big endian GUIDs while UEFI uses little endian ones */
+#define PTA_STMM_UUID \
+	UUID_INIT(0xed32d533, 0x99e6, 0x4209, \
+		  0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
+
+#define EFI_MM_VARIABLE_GUID \
+	EFI_GUID(0xed32d533, 0x99e6, 0x4209, \
+		 0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
+
+/* Defined in EDK2 MdePkg/Include/Protocol/MmCommunication.h */
+
+/**
+ * struct efi_mm_communicate_header - Header used for SMM variable communication
+
+ * @header_guid:  header use for disambiguation of content
+ * @message_len:  length of the message. Does not include the size of the
+ *                header
+ * @data:         payload of the message
+ *
+ * Defined in EDK2 as EFI_MM_COMMUNICATE_HEADER.
+ * To avoid confusion in interpreting frames, the communication buffer should
+ * always begin with efi_mm_communicate_header.
+ */
+struct efi_mm_communicate_header {
+	efi_guid_t header_guid;
+	size_t     message_len;
+	u8         data[];
+} __packed;
+
+#define MM_COMMUNICATE_HEADER_SIZE \
+	(sizeof(struct efi_mm_communicate_header))
+
+/* Defined in EDK2 ArmPkg/Include/IndustryStandard/ArmMmSvc.h */
+
+/* SPM return error codes */
+#define ARM_SVC_SPM_RET_SUCCESS               0
+#define ARM_SVC_SPM_RET_NOT_SUPPORTED        -1
+#define ARM_SVC_SPM_RET_INVALID_PARAMS       -2
+#define ARM_SVC_SPM_RET_DENIED               -3
+#define ARM_SVC_SPM_RET_NO_MEMORY            -5
+
+/* Defined in EDK2 MdeModulePkg/Include/Guid/SmmVariableCommon.h */
+
+#define SMM_VARIABLE_FUNCTION_GET_VARIABLE  1
+/*
+ * The payload for this function is
+ * SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
+ */
+#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
+/*
+ * The payload for this function is SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
+ */
+#define SMM_VARIABLE_FUNCTION_SET_VARIABLE  3
+/*
+ * The payload for this function is
+ * SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
+ */
+#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO  4
+/*
+ * It is a notify event, no extra payload for this function.
+ */
+#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT  5
+/*
+ * It is a notify event, no extra payload for this function.
+ */
+#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE  6
+/*
+ * The payload for this function is VARIABLE_INFO_ENTRY.
+ * The GUID in EFI_SMM_COMMUNICATE_HEADER is gEfiSmmVariableProtocolGuid.
+ */
+#define SMM_VARIABLE_FUNCTION_GET_STATISTICS  7
+/*
+ * The payload for this function is SMM_VARIABLE_COMMUNICATE_LOCK_VARIABLE
+ */
+#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE   8
+
+#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET  9
+
+#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET  10
+
+#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE  11
+/*
+ * The payload for this function is
+ * SMM_VARIABLE_COMMUNICATE_RUNTIME_VARIABLE_CACHE_CONTEXT
+ */
+#define SMM_VARIABLE_FUNCTION_INIT_RUNTIME_VARIABLE_CACHE_CONTEXT 12
+
+#define SMM_VARIABLE_FUNCTION_SYNC_RUNTIME_CACHE  13
+/*
+ * The payload for this function is
+ * SMM_VARIABLE_COMMUNICATE_GET_RUNTIME_CACHE_INFO
+ */
+#define SMM_VARIABLE_FUNCTION_GET_RUNTIME_CACHE_INFO  14
+
+/**
+ * struct smm_variable_communicate_header - Used for SMM variable communication
+
+ * @function:     function to call in Smm.
+ * @ret_status:   return status
+ * @data:         payload
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_HEADER.
+ */
+struct smm_variable_communicate_header {
+	size_t  function;
+	efi_status_t ret_status;
+	u8 data[];
+};
+
+#define MM_VARIABLE_COMMUNICATE_SIZE \
+	(sizeof(struct smm_variable_communicate_header))
+
+/**
+ * struct smm_variable_access - Used to communicate with StMM by
+ *                              SetVariable and GetVariable.
+
+ * @guid:         vendor GUID
+ * @data_size:    size of EFI variable data
+ * @name_size:    size of EFI name
+ * @attr:         attributes
+ * @name:         variable name
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
+ *
+ */
+struct smm_variable_access {
+	efi_guid_t  guid;
+	size_t data_size;
+	size_t name_size;
+	u32 attr;
+	u16 name[];
+};
+
+#define MM_VARIABLE_ACCESS_HEADER_SIZE \
+	(sizeof(struct smm_variable_access))
+/**
+ * struct smm_variable_payload_size - Used to get the max allowed
+ *                                    payload used in StMM.
+ *
+ * @size:  size to fill in
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_PAYLOAD_SIZE.
+ *
+ */
+struct smm_variable_payload_size {
+	size_t size;
+};
+
+/**
+ * struct smm_variable_getnext - Used to communicate with StMM for
+ *                               GetNextVariableName.
+ *
+ * @guid:       vendor GUID
+ * @name_size:  size of the name of the variable
+ * @name:       variable name
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
+ */
+struct smm_variable_getnext {
+	efi_guid_t  guid;
+	size_t name_size;
+	u16         name[];
+};
+
+#define MM_VARIABLE_GET_NEXT_HEADER_SIZE \
+	(sizeof(struct smm_variable_getnext))
+
+/**
+ * struct smm_variable_query_info - Used to communicate with StMM for
+ *                                  QueryVariableInfo.
+ *
+ * @max_variable_storage:        max available storage
+ * @remaining_variable_storage:  remaining available storage
+ * @max_variable_size:           max variable supported size
+ * @attr:                        attributes to query storage for
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
+ */
+struct smm_variable_query_info {
+	u64 max_variable_storage;
+	u64 remaining_variable_storage;
+	u64 max_variable_size;
+	u32 attr;
+};
+
+#define VAR_CHECK_VARIABLE_PROPERTY_REVISION 0x0001
+#define VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY BIT(0)
+/**
+ * struct var_check_property - Used to store variable properties in StMM
+ *
+ * @revision:   magic revision number for variable property checking
+ * @property:   properties mask for the variable used in StMM.
+ *              Currently RO flag is supported
+ * @attributes: variable attributes used in StMM checking when properties
+ *              for a variable are enabled
+ * @minsize:    minimum allowed size for variable payload checked against
+ *              smm_variable_access->datasize in StMM
+ * @maxsize:    maximum allowed size for variable payload checked against
+ *              smm_variable_access->datasize in StMM
+ *
+ * Defined in EDK2 as VAR_CHECK_VARIABLE_PROPERTY.
+ */
+struct var_check_property {
+	u16 revision;
+	u16 property;
+	u32 attributes;
+	size_t minsize;
+	size_t maxsize;
+};
+
+/**
+ * struct smm_variable_var_check_property - Used to communicate variable
+ *                                          properties with StMM
+ *
+ * @guid:       vendor GUID
+ * @name_size:  size of EFI name
+ * @property:   variable properties struct
+ * @name:       variable name
+ *
+ * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_VAR_CHECK_VARIABLE_PROPERTY.
+ */
+struct smm_variable_var_check_property {
+	efi_guid_t guid;
+	size_t name_size;
+	struct var_check_property property;
+	u16 name[];
+};
+
+#endif /* _MM_COMMUNICATION_H_ */
diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
new file mode 100644
index 000000000000..d3cf47d8986f
--- /dev/null
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  EFI variable service via TEE
+ *
+ *  Copyright (C) 2022 Linaro
+ */
+
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/ucs2_string.h>
+#include "mm_communication.h"
+
+static struct efivars tee_efivars;
+static struct efivar_operations tee_efivar_ops;
+
+static size_t max_buffer_size; /* comm + var + func + data */
+static size_t max_payload_size; /* func + data */
+
+struct tee_stmm_efi_private {
+	struct tee_context *ctx;
+	u32 session;
+	struct device *dev;
+};
+
+static struct tee_stmm_efi_private pvt_data;
+
+/* UUID of the stmm PTA */
+static const struct tee_client_device_id tee_stmm_efi_id_table[] = {
+	{PTA_STMM_UUID},
+	{}
+};
+
+static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* currently only OP-TEE is supported as a communication path */
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
+ *
+ * @comm_buf:		locally allocated communication buffer
+ * @dsize:		buffer size
+ * Return:		status code
+ */
+static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
+{
+	size_t buf_size;
+	efi_status_t ret;
+	struct efi_mm_communicate_header *mm_hdr;
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_param param[4];
+	struct tee_shm *shm = NULL;
+	int rc;
+
+	if (!comm_buf)
+		return EFI_INVALID_PARAMETER;
+
+	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
+	buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
+
+	if (dsize != buf_size)
+		return EFI_INVALID_PARAMETER;
+
+	shm = tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
+	if (IS_ERR(shm)) {
+		dev_err(pvt_data.dev, "Unable to register shared memory\n");
+		return EFI_UNSUPPORTED;
+	}
+
+	memset(&arg, 0, sizeof(arg));
+	arg.func = PTA_STMM_CMD_COMMUNICATE;
+	arg.session = pvt_data.session;
+	arg.num_params = 4;
+
+	memset(param, 0, sizeof(param));
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+	param[0].u.memref.size = buf_size;
+	param[0].u.memref.shm = shm;
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+	param[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+
+	rc = tee_client_invoke_func(pvt_data.ctx, &arg, param);
+	tee_shm_free(shm);
+
+	if (arg.ret != 0)
+		return EFI_DEVICE_ERROR;
+
+	switch (param[1].u.value.a) {
+	case ARM_SVC_SPM_RET_SUCCESS:
+		ret = EFI_SUCCESS;
+		break;
+
+	case ARM_SVC_SPM_RET_INVALID_PARAMS:
+		ret = EFI_INVALID_PARAMETER;
+		break;
+
+	case ARM_SVC_SPM_RET_DENIED:
+		ret = EFI_ACCESS_DENIED;
+		break;
+
+	case ARM_SVC_SPM_RET_NO_MEMORY:
+		ret = EFI_OUT_OF_RESOURCES;
+		break;
+
+	default:
+		ret = EFI_ACCESS_DENIED;
+	}
+
+	return ret;
+}
+
+/**
+ * mm_communicate() - Adjust the communication buffer to StandAlonneMM and send
+ * it to TEE
+ *
+ * @comm_buf:		locally allocated communication buffer
+ * @dsize:		buffer size
+ * Return:		status code
+ */
+static efi_status_t mm_communicate(u8 *comm_buf, size_t dsize)
+{
+	efi_status_t ret;
+	struct efi_mm_communicate_header *mm_hdr;
+	struct smm_variable_communicate_header *var_hdr;
+
+	dsize += MM_COMMUNICATE_HEADER_SIZE + MM_VARIABLE_COMMUNICATE_SIZE;
+	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
+	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
+
+	ret = tee_mm_communicate(comm_buf, dsize);
+	if (ret != EFI_SUCCESS) {
+		dev_err(pvt_data.dev, "%s failed!\n", __func__);
+		return ret;
+	}
+
+	return var_hdr->ret_status;
+}
+
+/**
+ * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
+ *			header data.
+ *
+ * @dptr:		pointer address of the corresponding StandAloneMM
+ *			function
+ * @payload_size:	buffer size
+ * @func:		standAloneMM function number
+ * @ret:		EFI return code
+ * Return:		buffer or NULL
+ */
+static u8 *setup_mm_hdr(void **dptr, size_t payload_size, size_t func,
+			efi_status_t *ret)
+{
+	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
+	struct efi_mm_communicate_header *mm_hdr;
+	struct smm_variable_communicate_header *var_hdr;
+	u8 *comm_buf;
+
+	/* In the init function we initialize max_buffer_size with
+	 * get_max_payload(). So skip the test if max_buffer_size is initialized
+	 * StandAloneMM will perform similar checks and drop the buffer if it's
+	 * too long
+	 */
+	if (max_buffer_size &&
+	    max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
+			       MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
+		*ret = EFI_INVALID_PARAMETER;
+		return NULL;
+	}
+
+	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
+				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
+			   GFP_KERNEL);
+	if (!comm_buf) {
+		*ret = EFI_OUT_OF_RESOURCES;
+		return NULL;
+	}
+
+	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
+	memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
+	mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
+
+	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
+	var_hdr->function = func;
+	if (dptr)
+		*dptr = var_hdr->data;
+	*ret = EFI_SUCCESS;
+
+	return comm_buf;
+}
+
+/**
+ * get_max_payload() - Get variable payload size from StandAloneMM.
+ *
+ * @size:    size of the variable in storage
+ * Return:   status code
+ */
+static efi_status_t get_max_payload(size_t *size)
+{
+	struct smm_variable_payload_size *var_payload = NULL;
+	size_t payload_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	if (!size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	payload_size = sizeof(*var_payload);
+	comm_buf = setup_mm_hdr((void **)&var_payload, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE, &ret);
+	if (!comm_buf)
+		goto out;
+
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	/* Make sure the buffer is big enough for storing variables */
+	if (var_payload->size < MM_VARIABLE_ACCESS_HEADER_SIZE + 0x20) {
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	}
+	*size = var_payload->size;
+	/*
+	 * There seems to be a bug in EDK2 miscalculating the boundaries and
+	 * size checks, so deduct 2 more bytes to fulfill this requirement. Fix
+	 * it up here to ensure backwards compatibility with older versions
+	 * (cf. StandaloneMmPkg/Drivers/StandaloneMmCpu/AArch64/EventHandle.c.
+	 * sizeof (EFI_MM_COMMUNICATE_HEADER) instead the size minus the
+	 * flexible array member).
+	 *
+	 * size is guaranteed to be > 2 due to checks on the beginning.
+	 */
+	*size -= 2;
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static efi_status_t get_property_int(u16 *name, size_t name_size,
+				     const efi_guid_t *vendor,
+				     struct var_check_property *var_property)
+{
+	struct smm_variable_var_check_property *smm_property;
+	size_t payload_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	memset(var_property, 0, sizeof(*var_property));
+	payload_size = sizeof(*smm_property) + name_size;
+	if (payload_size > max_payload_size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	comm_buf = setup_mm_hdr(
+		(void **)&smm_property, payload_size,
+		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
+	if (!comm_buf)
+		goto out;
+
+	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
+	smm_property->name_size = name_size;
+	memcpy(smm_property->name, name, name_size);
+
+	ret = mm_communicate(comm_buf, payload_size);
+	/*
+	 * Currently only R/O property is supported in StMM.
+	 * Variables that are not set to R/O will not set the property in StMM
+	 * and the call will return EFI_NOT_FOUND. We are setting the
+	 * properties to 0x0 so checking against that is enough for the
+	 * EFI_NOT_FOUND case.
+	 */
+	if (ret == EFI_NOT_FOUND)
+		ret = EFI_SUCCESS;
+	if (ret != EFI_SUCCESS)
+		goto out;
+	memcpy(var_property, &smm_property->property, sizeof(*var_property));
+
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
+				     u32 *attributes, unsigned long *data_size,
+				     void *data)
+{
+	struct var_check_property var_property;
+	struct smm_variable_access *var_acc;
+	size_t payload_size;
+	size_t name_size;
+	size_t tmp_dsize;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	if (!name || !vendor || !data_size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
+	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/* Trim output buffer size */
+	tmp_dsize = *data_size;
+	if (name_size + tmp_dsize >
+	    max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
+		tmp_dsize = max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE -
+			    name_size;
+	}
+
+	/* Get communication buffer and initialize header */
+	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
+	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
+	if (!comm_buf)
+		goto out;
+
+	/* Fill in contents */
+	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
+	var_acc->data_size = tmp_dsize;
+	var_acc->name_size = name_size;
+	var_acc->attr = attributes ? *attributes : 0;
+	memcpy(var_acc->name, name, name_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL)
+		/* Update with reported data size for trimmed case */
+		*data_size = var_acc->data_size;
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = get_property_int(name, name_size, vendor, &var_property);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	if (attributes)
+		*attributes = var_acc->attr;
+
+	if (data)
+		memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
+		       var_acc->data_size);
+	else
+		ret = EFI_INVALID_PARAMETER;
+
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static efi_status_t tee_get_next_variable(unsigned long *name_size,
+					  efi_char16_t *name, efi_guid_t *guid)
+{
+	struct smm_variable_getnext *var_getnext;
+	size_t payload_size;
+	size_t out_name_size;
+	size_t in_name_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	if (!name_size || !name || !guid) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	out_name_size = *name_size;
+	in_name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
+
+	if (out_name_size < in_name_size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	if (in_name_size >
+	    max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/* Trim output buffer size */
+	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
+		out_name_size =
+			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
+
+	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
+	comm_buf = setup_mm_hdr((void **)&var_getnext, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
+				&ret);
+	if (!comm_buf)
+		goto out;
+
+	/* Fill in contents */
+	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
+	var_getnext->name_size = out_name_size;
+	memcpy(var_getnext->name, name, in_name_size);
+	memset((u8 *)var_getnext->name + in_name_size, 0x0,
+	       out_name_size - in_name_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
+		/* Update with reported data size for trimmed case */
+		*name_size = var_getnext->name_size;
+	}
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	memcpy(guid, &var_getnext->guid, sizeof(*guid));
+	memcpy(name, var_getnext->name, var_getnext->name_size);
+
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
+				     u32 attributes, unsigned long data_size,
+				     void *data)
+{
+	efi_status_t ret;
+	struct var_check_property var_property;
+	struct smm_variable_access *var_acc;
+	size_t payload_size;
+	size_t name_size;
+	u8 *comm_buf = NULL;
+
+	if (!name || name[0] == 0 || !vendor) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	if (data_size > 0 && !data) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	/* Check payload size */
+	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
+	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
+	if (payload_size > max_payload_size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/*
+	 * Allocate the buffer early, before switching to RW (if needed)
+	 * so we won't need to account for any failures in reading/setting
+	 * the properties, if the allocation fails
+	 */
+	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
+				SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
+	if (!comm_buf)
+		goto out;
+
+	/*
+	 * The API has the ability to override RO flags. If no RO check was
+	 * requested switch the variable to RW for the duration of this call
+	 */
+	ret = get_property_int(name, name_size, vendor, &var_property);
+	if (ret != EFI_SUCCESS) {
+		dev_err(pvt_data.dev, "Getting variable property failed\n");
+		goto out;
+	}
+
+	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY) {
+		ret = EFI_WRITE_PROTECTED;
+		goto out;
+	}
+
+	/* Fill in contents */
+	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
+	var_acc->data_size = data_size;
+	var_acc->name_size = name_size;
+	var_acc->attr = attributes;
+	memcpy(var_acc->name, name, name_size);
+	memcpy((u8 *)var_acc->name + name_size, data, data_size);
+
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static efi_status_t __maybe_unused tee_query_variable_info(u32 attributes,
+					    u64 *max_variable_storage_size,
+					    u64 *remain_variable_storage_size,
+					    u64 *max_variable_size)
+{
+	struct smm_variable_query_info *mm_query_info;
+	size_t payload_size;
+	efi_status_t ret;
+	u8 *comm_buf;
+
+	payload_size = sizeof(*mm_query_info);
+	comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
+				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
+				&ret);
+	if (!comm_buf)
+		goto out;
+
+	mm_query_info->attr = attributes;
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret != EFI_SUCCESS)
+		goto out;
+	*max_variable_storage_size = mm_query_info->max_variable_storage;
+	*remain_variable_storage_size =
+		mm_query_info->remaining_variable_storage;
+	*max_variable_size = mm_query_info->max_variable_size;
+
+out:
+	kfree(comm_buf);
+	return ret;
+}
+
+static int tee_stmm_efi_probe(struct device *dev)
+{
+	struct tee_ioctl_open_session_arg sess_arg;
+	efi_status_t ret;
+	int rc;
+
+	/* Open context with TEE driver */
+	pvt_data.ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
+	if (IS_ERR(pvt_data.ctx))
+		return -ENODEV;
+
+	/* Open session with StMM PTA */
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
+	rc = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	if ((rc < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n",
+			sess_arg.ret);
+		rc = -EINVAL;
+		goto out_ctx;
+	}
+	pvt_data.session = sess_arg.session;
+	pvt_data.dev = dev;
+
+	ret = get_max_payload(&max_payload_size);
+	if (ret != EFI_SUCCESS) {
+		rc = -EIO;
+		goto out_sess;
+	}
+
+	max_buffer_size = MM_COMMUNICATE_HEADER_SIZE +
+			  MM_VARIABLE_COMMUNICATE_SIZE +
+			  max_payload_size;
+
+	tee_efivar_ops.get_variable = tee_get_variable;
+	tee_efivar_ops.get_next_variable = tee_get_next_variable;
+	tee_efivar_ops.set_variable = tee_set_variable;
+	/* TODO: support non-blocking variant */
+	tee_efivar_ops.set_variable_nonblocking = NULL;
+	tee_efivar_ops.query_variable_store = efi_query_variable_store;
+
+	tee_register_efivar_ops(&tee_efivars, &tee_efivar_ops);
+
+	return 0;
+
+out_sess:
+	tee_client_close_session(pvt_data.ctx, pvt_data.session);
+out_ctx:
+	tee_client_close_context(pvt_data.ctx);
+
+	return rc;
+}
+
+static int tee_stmm_efi_remove(struct device *dev)
+{
+	tee_unregister_efivar_ops(&tee_efivars);
+
+	tee_client_close_session(pvt_data.ctx, pvt_data.session);
+	tee_client_close_context(pvt_data.ctx);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
+
+static struct tee_client_driver tee_stmm_efi_driver = {
+	.id_table	= tee_stmm_efi_id_table,
+	.driver		= {
+		.name		= "tee-stmm-efi",
+		.bus		= &tee_bus_type,
+		.probe		= tee_stmm_efi_probe,
+		.remove		= tee_stmm_efi_remove,
+	},
+};
+
+static int __init tee_stmm_efi_mod_init(void)
+{
+	return driver_register(&tee_stmm_efi_driver.driver);
+}
+
+static void __exit tee_stmm_efi_mod_exit(void)
+{
+	driver_unregister(&tee_stmm_efi_driver.driver);
+}
+
+module_init(tee_stmm_efi_mod_init);
+module_exit(tee_stmm_efi_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
+MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
+MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");
-- 
2.30.2

