Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54166893BE
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBCJau (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 04:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjBCJag (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 04:30:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262D1C58F
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 01:30:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m8so4546730edd.10
        for <linux-efi@vger.kernel.org>; Fri, 03 Feb 2023 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozi2ff4B9slP5Ym99tM5ZOD+FsAFrMrJOm/LOS1i7ZM=;
        b=tOs4NodeuRjM0FriEddbVWuSJlI9skV4MPqH/w25cXxNAIGods3xQvbkdy5d4Mh7Px
         72HSrd0YBaz5bZrFxhQKt9kdS5OUcYYbTCD1LJLMB8boq/UX47YzgDsfyKqqjxGQWeoo
         zLdU7m7qtgI7sNcj4RCZPkdfk8HJ9o12Fd8/jyJZXqWy3BH2BthX3KS5W2jfqCzXHTpa
         sjvx6U2rqZJR/rrmH6efdjhD1HhSnXfASBGppqMRQWn7I0kNvI9Hhv6InUlMOum0cro2
         U4HPhf6OUu0YUgc4BAuBo2bD1dDVp+ZhBdbwLq+WC9fGw6Ms1PofIWb3Ecn6B78jn7Wy
         ZWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozi2ff4B9slP5Ym99tM5ZOD+FsAFrMrJOm/LOS1i7ZM=;
        b=YgnpKTAAKk/t1GKSGXHvLXYhzzuSHsjrr5d8/1F+9HRcufYFSuouh4mt42QpzpuQcr
         LDiIp81Qrxn+dV8sJN+ha5IRhXWSJ2H4h29XXp7DJUfkVQlGSrY4gu9BLE3QrmJT/kpW
         SxO7EzPnTE9w8s/2p2AgGVjd95+zfx24xx0TMr/q9/+gkXa+xXkcGBvtzdVcwdji9XjI
         rWt5814wUs11JpOZJsrr5EhXLqD+Cq5CpzSP75UDEqe2j/RB/NzMgSYDthN/YRboniqn
         ttck4O9zUiAUR8wufxi23UcmkYWfVD4uHCo9ZdLeCX+Povvel0qGwuAx1ppnVYm6l4sx
         Q9EA==
X-Gm-Message-State: AO0yUKWRrxr/2Q2P0lb4NvFyLQdt8Vm1jAP/BfKXPMIHlsZWtkMCWhSj
        JOg4dNe/v8VteZcoV6vp8SHCjw==
X-Google-Smtp-Source: AK7set8FOE1WdwvQZnUV7M/tJCf9KWPyTXJ0xo0hUkqqI7Lw0yFPLCKV8OfsqYJvzrFPhHiFpMcnsQ==
X-Received: by 2002:a05:6402:4006:b0:4a2:71eb:b1e7 with SMTP id d6-20020a056402400600b004a271ebb1e7mr10227955eda.20.1675416630589;
        Fri, 03 Feb 2023 01:30:30 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id eg35-20020a05640228a300b0049f5ab4fa97sm824754edb.86.2023.02.03.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:30:30 -0800 (PST)
Date:   Fri, 3 Feb 2023 10:30:28 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tee: Add op-tee helper functions for variable
 access
Message-ID: <Y9zUNHqEAHRPgRdY@jade>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <20230126132120.1661-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230126132120.1661-3-masahisa.kojima@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 26, 2023 at 10:21:19PM +0900, Masahisa Kojima wrote:
> When the flash is not owned by the non-secure world, accessing the EFI
> variables is straightforward and done via EFI Runtime Variable Services.
> In this case, critical variables for system integrity and security
> are normally stored in the dedicated secure storage and only accessible
> from the secure world.
> 
> On the other hand, the small embedded devices don't have the special
> dedicated secure storage. The eMMC device with an RPMB partition is
> becoming more common, we can use an RPMB partition to store the
> EFI Variables.
> 
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
> 
> So let's add the kernel functions needed.
> 
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this optee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
> 
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/tee/optee/Kconfig            |  10 +
>  drivers/tee/optee/Makefile           |   1 +
>  drivers/tee/optee/mm_communication.h | 249 +++++++++++
>  drivers/tee/optee/optee_private.h    |   5 +-
>  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
>  drivers/tee/tee_core.c               |  23 ++
>  include/linux/efi.h                  |   1 +
>  include/linux/tee_drv.h              |  23 ++
>  8 files changed, 909 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/tee/optee/mm_communication.h
>  create mode 100644 drivers/tee/optee/optee_stmm_efi.c


Please split this patch into three patches, one for drivers/tee, one
for the driver/tee/optee, and one for include/linux/efi.h.

> 
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index f121c224e682..a0b699977e51 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -7,3 +7,13 @@ config OPTEE
>  	help
>  	  This implements the OP-TEE Trusted Execution Environment (TEE)
>  	  driver.
> +
> +config EFI_STMM_OPTEE

Should this be OPTEE_EFI_STMM?

> +	tristate "OP-TEE based EFI runtime variable service driver"
> +	depends on OPTEE
> +	help
> +	  This  driver provides support for OP-TEE based EFI runtime
> +	  variable service driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called optee_stmm_efi.
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index a6eff388d300..9acb0b2de8fe 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -8,6 +8,7 @@ optee-objs += supp.o
>  optee-objs += device.o
>  optee-objs += smc_abi.o
>  optee-objs += ffa_abi.o
> +obj-$(CONFIG_EFI_STMM_OPTEE) += optee_stmm_efi.o
>  
>  # for tracing framework to find optee_trace.h
>  CFLAGS_smc_abi.o := -I$(src)
> diff --git a/drivers/tee/optee/mm_communication.h b/drivers/tee/optee/mm_communication.h
> new file mode 100644
> index 000000000000..23e6672991ef
> --- /dev/null
> +++ b/drivers/tee/optee/mm_communication.h
> @@ -0,0 +1,249 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Headers for EFI variable service via StandAloneMM, EDK2 application running
> + *  in OP-TEE
> + *
> + *  Copyright (c) 2017, Intel Corporation. All rights reserved.
> + *  Copyright (C) 2020 Linaro Ltd.
> + */
> +
> +#ifndef _MM_COMMUNICATION_H_
> +#define _MM_COMMUNICATION_H_
> +
> +/*
> + * Interface to the pseudo Trusted Application (TA), which provides a
> + * communication channel with the Standalone MM (Management Mode)
> + * Secure Partition running at Secure-EL0
> + */
> +
> +#define PTA_STMM_CMDID_COMMUNICATE 0

PTA_STMM_CMD_COMMUNICATE

> +
> +/* OP-TEE is using big endian GUIDs while UEFI uses little endian ones */
> +#define PTA_STMM_UUID \
> +	UUID_INIT(0xed32d533, 0x99e6, 0x4209, \
> +		  0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +#define EFI_MM_VARIABLE_GUID \
> +	EFI_GUID(0xed32d533, 0x99e6, 0x4209, \
> +		 0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +/* Defined in EDK2 MdePkg/Include/Protocol/MmCommunication.h */
> +
> +/**
> + * struct efi_mm_communicate_header - Header used for SMM variable communication
> +
> + * @header_guid:  header use for disambiguation of content
> + * @message_len:  length of the message. Does not include the size of the
> + *                header
> + * @data:         payload of the message
> + *
> + * Defined in EDK2 as EFI_MM_COMMUNICATE_HEADER.
> + * To avoid confusion in interpreting frames, the communication buffer should
> + * always begin with efi_mm_communicate_header.
> + */
> +struct efi_mm_communicate_header {
> +	efi_guid_t header_guid;
> +	size_t     message_len;
> +	u8         data[];
> +} __packed;
> +
> +#define MM_COMMUNICATE_HEADER_SIZE \
> +	(sizeof(struct efi_mm_communicate_header))
> +
> +/* Defined in EDK2 ArmPkg/Include/IndustryStandard/ArmMmSvc.h */
> +
> +/* SPM return error codes */
> +#define ARM_SVC_SPM_RET_SUCCESS               0
> +#define ARM_SVC_SPM_RET_NOT_SUPPORTED        -1
> +#define ARM_SVC_SPM_RET_INVALID_PARAMS       -2
> +#define ARM_SVC_SPM_RET_DENIED               -3
> +#define ARM_SVC_SPM_RET_NO_MEMORY            -5
> +
> +/* Defined in EDK2 MdeModulePkg/Include/Guid/SmmVariableCommon.h */
> +
> +#define SMM_VARIABLE_FUNCTION_GET_VARIABLE  1
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
> +/*
> + * The payload for this function is SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
> + */
> +#define SMM_VARIABLE_FUNCTION_SET_VARIABLE  3
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
> + */
> +#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO  4
> +/*
> + * It is a notify event, no extra payload for this function.
> + */
> +#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT  5
> +/*
> + * It is a notify event, no extra payload for this function.
> + */
> +#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE  6
> +/*
> + * The payload for this function is VARIABLE_INFO_ENTRY.
> + * The GUID in EFI_SMM_COMMUNICATE_HEADER is gEfiSmmVariableProtocolGuid.
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_STATISTICS  7
> +/*
> + * The payload for this function is SMM_VARIABLE_COMMUNICATE_LOCK_VARIABLE
> + */
> +#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE   8
> +
> +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET  9
> +
> +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET  10
> +
> +#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE  11
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_RUNTIME_VARIABLE_CACHE_CONTEXT
> + */
> +#define SMM_VARIABLE_FUNCTION_INIT_RUNTIME_VARIABLE_CACHE_CONTEXT 12
> +
> +#define SMM_VARIABLE_FUNCTION_SYNC_RUNTIME_CACHE  13
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_GET_RUNTIME_CACHE_INFO
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_RUNTIME_CACHE_INFO  14
> +
> +/**
> + * struct smm_variable_communicate_header - Used for SMM variable communication
> +
> + * @function:     function to call in Smm.
> + * @ret_status:   return status
> + * @data:         payload
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_HEADER.
> + */
> +struct smm_variable_communicate_header {
> +	size_t  function;
> +	efi_status_t ret_status;
> +	u8 data[];
> +};
> +
> +#define MM_VARIABLE_COMMUNICATE_SIZE \
> +	(sizeof(struct smm_variable_communicate_header))
> +
> +/**
> + * struct smm_variable_access - Used to communicate with StMM by
> + *                              SetVariable and GetVariable.
> +
> + * @guid:         vendor GUID
> + * @data_size:    size of EFI variable data
> + * @name_size:    size of EFI name
> + * @attr:         attributes
> + * @name:         variable name
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
> + *
> + */
> +struct smm_variable_access {
> +	efi_guid_t  guid;
> +	size_t data_size;
> +	size_t name_size;
> +	u32 attr;
> +	u16 name[];
> +};
> +
> +#define MM_VARIABLE_ACCESS_HEADER_SIZE \
> +	(sizeof(struct smm_variable_access))
> +/**
> + * struct smm_variable_payload_size - Used to get the max allowed
> + *                                    payload used in StMM.
> + *
> + * @size:  size to fill in
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_PAYLOAD_SIZE.
> + *
> + */
> +struct smm_variable_payload_size {
> +	size_t size;
> +};
> +
> +/**
> + * struct smm_variable_getnext - Used to communicate with StMM for
> + *                               GetNextVariableName.
> + *
> + * @guid:       vendor GUID
> + * @name_size:  size of the name of the variable
> + * @name:       variable name
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
> + */
> +struct smm_variable_getnext {
> +	efi_guid_t  guid;
> +	size_t name_size;
> +	u16         name[];
> +};
> +
> +#define MM_VARIABLE_GET_NEXT_HEADER_SIZE \
> +	(sizeof(struct smm_variable_getnext))
> +
> +/**
> + * struct smm_variable_query_info - Used to communicate with StMM for
> + *                                  QueryVariableInfo.
> + *
> + * @max_variable_storage:        max available storage
> + * @remaining_variable_storage:  remaining available storage
> + * @max_variable_size:           max variable supported size
> + * @attr:                        attributes to query storage for
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
> + */
> +struct smm_variable_query_info {
> +	u64 max_variable_storage;
> +	u64 remaining_variable_storage;
> +	u64 max_variable_size;
> +	u32 attr;
> +};
> +
> +#define VAR_CHECK_VARIABLE_PROPERTY_REVISION 0x0001
> +#define VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY BIT(0)
> +/**
> + * struct var_check_property - Used to store variable properties in StMM
> + *
> + * @revision:   magic revision number for variable property checking
> + * @property:   properties mask for the variable used in StMM.
> + *              Currently RO flag is supported
> + * @attributes: variable attributes used in StMM checking when properties
> + *              for a variable are enabled
> + * @minsize:    minimum allowed size for variable payload checked against
> + *              smm_variable_access->datasize in StMM
> + * @maxsize:    maximum allowed size for variable payload checked against
> + *              smm_variable_access->datasize in StMM
> + *
> + * Defined in EDK2 as VAR_CHECK_VARIABLE_PROPERTY.
> + */
> +struct var_check_property {
> +	u16 revision;
> +	u16 property;
> +	u32 attributes;
> +	size_t minsize;
> +	size_t maxsize;
> +};
> +
> +/**
> + * struct smm_variable_var_check_property - Used to communicate variable
> + *                                          properties with StMM
> + *
> + * @guid:       vendor GUID
> + * @name_size:  size of EFI name
> + * @property:   variable properties struct
> + * @name:       variable name
> + *
> + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_VAR_CHECK_VARIABLE_PROPERTY.
> + */
> +struct smm_variable_var_check_property {
> +	efi_guid_t guid;
> +	size_t name_size;
> +	struct var_check_property property;
> +	u16 name[];
> +};
> +
> +#endif /* _MM_COMMUNICATION_H_ */
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 04ae58892608..10af910e0dce 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -12,6 +12,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
>  #include "optee_msg.h"
> +#include "optee_private.h"

This is "optee_private.h", no need to include it.

>  
>  #define DRIVER_NAME "optee"
>  
> @@ -19,6 +20,7 @@
>  
>  /* Some Global Platform error codes used in this driver */
>  #define TEEC_SUCCESS			0x00000000
> +#define TEEC_ERROR_EXCESS_DATA		0xFFFF0004
>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
>  #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
> @@ -250,7 +252,6 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			       int (*shm_unregister)(struct tee_context *ctx,
>  						     struct tee_shm *shm));
>  
> -
>  void optee_remove_common(struct optee *optee);
>  int optee_open(struct tee_context *ctx, bool cap_memref_null);
>  void optee_release(struct tee_context *ctx);
> @@ -322,4 +323,6 @@ void optee_smc_abi_unregister(void);
>  int optee_ffa_abi_register(void);
>  void optee_ffa_abi_unregister(void);
>  
> +int optee_efivar_ops_init(struct tee_context *ctx);

This isn't used or implemented as far as I can tell.

> +
>  #endif /*OPTEE_PRIVATE_H*/
> diff --git a/drivers/tee/optee/optee_stmm_efi.c b/drivers/tee/optee/optee_stmm_efi.c
> new file mode 100644
> index 000000000000..6dcf1eb4b96c
> --- /dev/null
> +++ b/drivers/tee/optee/optee_stmm_efi.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  EFI variable service via OP-TEE
> + *
> + *  Copyright (C) 2022 Linaro
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +#include "mm_communication.h"
> +#include "optee_private.h"
> +
> +static struct efivars optee_efivars;
> +static struct efivar_operations optee_ops;

optee_efi_ops instead? To avoid being confused with the other optee_ops.

> +
> +static size_t max_buffer_size; /* comm + var + func + data */
> +static size_t max_payload_size; /* func + data */
> +
> +struct mm_connection {
> +	struct tee_context *ctx;
> +	u32 session;
> +};
> +
> +/* UUID of the stmm PTA */
> +static const struct tee_client_device_id optee_stmm_efi_id_table[] = {
> +	{PTA_STMM_UUID},
> +	{}
> +};
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/**
> + * get_connection() - Retrieve OP-TEE session for a specific UUID.
> + *
> + * @conn:   session buffer to fill
> + * Return:  status code
> + */
> +static int get_connection(struct mm_connection *conn)
> +{
> +	struct tee_context *ctx = NULL;
> +	struct tee_ioctl_open_session_arg arg;
> +	int rc;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	/* Open context with OP-TEE driver */
> +	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);

tee_client_close_context() is missing in the error paths.

> +	if (IS_ERR(ctx))
> +		return -ENODEV;
> +
> +	export_uuid(arg.uuid, &optee_stmm_efi_id_table[0].uuid);
> +	rc = tee_client_open_session(ctx, &arg, NULL);
> +	if (!rc) {
> +		conn->ctx = ctx;
> +		conn->session = arg.session;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * optee_mm_communicate() - Pass a buffer to StandaloneMM running in OP-TEE
> + *
> + * @comm_buf:		locally allocated communcation buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t optee_mm_communicate(void *comm_buf, size_t dsize)
> +{
> +	size_t buf_size;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct mm_connection conn = { NULL, 0 };
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[4];
> +	struct tee_shm *shm = NULL;
> +	int rc;
> +
> +	if (!comm_buf)
> +		return EFI_INVALID_PARAMETER;
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;

No need to cast.

> +	buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
> +
> +	if (dsize != buf_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	rc = get_connection(&conn);
> +	if (rc) {
> +		pr_err("Unable to open OP-TEE session (err=%d)\n", rc);

Perhaps better to print from get_connection() to be able to distinguish
between errors from tee_client_open_context() and
tee_client_open_session().

> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	shm = tee_shm_register_kernel_buf(conn.ctx, comm_buf, buf_size);
> +	if (IS_ERR(shm)) {
> +		pr_err("Unable to register shared memory\n");
> +		tee_client_close_session(conn.ctx, conn.session);
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.func = PTA_STMM_CMDID_COMMUNICATE;
> +	arg.session = conn.session;
> +	arg.num_params = 4;
> +
> +	memset(param, 0, sizeof(param));
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +	param[0].u.memref.size = buf_size;
> +	param[0].u.memref.shm = shm;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +	param[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +
> +	rc = tee_client_invoke_func(conn.ctx, &arg, param);
> +	tee_shm_free(shm);
> +	/* even if close session fails the session will be invalidaded */
> +	tee_client_close_session(conn.ctx, conn.session);
> +	if (rc)
> +		return EFI_DEVICE_ERROR;
> +	if (arg.ret == TEEC_ERROR_EXCESS_DATA)
> +		pr_err("Variable payload too large\n");
> +	if (arg.ret != TEEC_SUCCESS)
> +		return EFI_DEVICE_ERROR;
> +
> +	switch (param[1].u.value.a) {
> +	case ARM_SVC_SPM_RET_SUCCESS:
> +		ret = EFI_SUCCESS;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_INVALID_PARAMS:
> +		ret = EFI_INVALID_PARAMETER;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_DENIED:
> +		ret = EFI_ACCESS_DENIED;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_NO_MEMORY:
> +		ret = EFI_OUT_OF_RESOURCES;
> +		break;
> +
> +	default:
> +		ret = EFI_ACCESS_DENIED;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * mm_communicate() - Adjust the cmonnucation buffer to StandAlonneMM and send
> + * it to OP-TEE
> + *
> + * @comm_buf:		locally allocated communcation buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t mm_communicate(u8 *comm_buf, size_t dsize)
> +{
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct smm_variable_communicate_header *var_hdr;
> +
> +	dsize += MM_COMMUNICATE_HEADER_SIZE + MM_VARIABLE_COMMUNICATE_SIZE;
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +
> +	ret = optee_mm_communicate(comm_buf, dsize);
> +	if (ret != EFI_SUCCESS) {
> +		pr_err("%s failed!\n", __func__);
> +		return ret;
> +	}
> +
> +	return var_hdr->ret_status;
> +}
> +
> +/**
> + * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
> + *			header data.
> + *
> + * @dptr:		pointer address of the corresponding StandAloneMM
> + *			function
> + * @payload_size:	buffer size
> + * @func:		standAloneMM function number
> + * @ret:		EFI return code
> + * Return:		buffer or NULL
> + */
> +static u8 *setup_mm_hdr(void **dptr, size_t payload_size, size_t func,
> +			efi_status_t *ret)
> +{
> +	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct smm_variable_communicate_header *var_hdr;
> +	u8 *comm_buf;
> +
> +	/* In the init function we initialize max_buffer_size with
> +	 * get_max_payload(). So skip the test if max_buffer_size is initialized
> +	 * StandAloneMM will perform similar checks and drop the buffer if it's
> +	 * too long
> +	 */
> +	if (max_buffer_size &&
> +	    max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
> +			       MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
> +		*ret = EFI_INVALID_PARAMETER;
> +		return NULL;
> +	}
> +
> +	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> +				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> +			   GFP_KERNEL);
> +	if (!comm_buf) {
> +		*ret = EFI_OUT_OF_RESOURCES;
> +		return NULL;
> +	}
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
> +	mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
> +
> +	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +	var_hdr->function = func;
> +	if (dptr)
> +		*dptr = var_hdr->data;
> +	*ret = EFI_SUCCESS;
> +
> +	return comm_buf;
> +}
> +
> +/**
> + * get_max_payload() - Get variable payload size from StandAloneMM.
> + *
> + * @size:    size of the variable in storage
> + * Return:   status code
> + */
> +static efi_status_t get_max_payload(size_t *size)
> +{
> +	struct smm_variable_payload_size *var_payload = NULL;
> +	size_t payload_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	payload_size = sizeof(*var_payload);
> +	comm_buf = setup_mm_hdr((void **)&var_payload, payload_size,
> +				SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	/* Make sure the buffer is big enough for storing variables */
> +	if (var_payload->size < MM_VARIABLE_ACCESS_HEADER_SIZE + 0x20) {
> +		ret = EFI_DEVICE_ERROR;
> +		goto out;
> +	}
> +	*size = var_payload->size;
> +	/*
> +	 * There seems to be a bug in EDK2 miscalculating the boundaries and
> +	 * size checks, so deduct 2 more bytes to fulfill this requirement. Fix
> +	 * it up here to ensure backwards compatibility with older versions
> +	 * (cf. StandaloneMmPkg/Drivers/StandaloneMmCpu/AArch64/EventHandle.c.
> +	 * sizeof (EFI_MM_COMMUNICATE_HEADER) instead the size minus the
> +	 * flexible array member).
> +	 *
> +	 * size is guaranteed to be > 2 due to checks on the beginning.
> +	 */
> +	*size -= 2;
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t get_property_int(u16 *name, size_t name_size,
> +				     const efi_guid_t *vendor,
> +				     struct var_check_property *var_property)
> +{
> +	struct smm_variable_var_check_property *smm_property;
> +	size_t payload_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	memset(var_property, 0, sizeof(*var_property));
> +	payload_size = sizeof(*smm_property) + name_size;
> +	if (payload_size > max_payload_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	comm_buf = setup_mm_hdr(
> +		(void **)&smm_property, payload_size,
> +		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
> +	smm_property->name_size = name_size;
> +	memcpy(smm_property->name, name, name_size);
> +
> +	ret = mm_communicate(comm_buf, payload_size);
> +	/*
> +	 * Currently only R/O property is supported in StMM.
> +	 * Variables that are not set to R/O will not set the property in StMM
> +	 * and the call will return EFI_NOT_FOUND. We are setting the
> +	 * properties to 0x0 so checking against that is enough for the
> +	 * EFI_NOT_FOUND case.
> +	 */
> +	if (ret == EFI_NOT_FOUND)
> +		ret = EFI_SUCCESS;
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +	memcpy(var_property, &smm_property->property, sizeof(*var_property));
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t optee_get_variable(u16 *name, efi_guid_t *vendor,
> +				       u32 *attributes,
> +				       unsigned long *data_size, void *data)
> +{
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	size_t tmp_dsize;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name || !vendor || !data_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	tmp_dsize = *data_size;
> +	if (name_size + tmp_dsize >
> +	    max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		tmp_dsize = max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE -
> +			    name_size;
> +	}
> +
> +	/* Get communication buffer and initialize header */
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
> +	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> +				SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = tmp_dsize;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes ? *attributes : 0;
> +	memcpy(var_acc->name, name, name_size);
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL)
> +		/* Update with reported data size for trimmed case */
> +		*data_size = var_acc->data_size;
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	if (attributes)
> +		*attributes = var_acc->attr;
> +
> +	if (data)
> +		memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
> +		       var_acc->data_size);
> +	else
> +		ret = EFI_INVALID_PARAMETER;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t optee_get_next_variable(unsigned long *name_size,
> +					    efi_char16_t *name,
> +					    efi_guid_t *guid)
> +{
> +	struct smm_variable_getnext *var_getnext;
> +	size_t payload_size;
> +	size_t out_name_size;
> +	size_t in_name_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name_size || !name || !guid) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	out_name_size = *name_size;
> +	in_name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +
> +	if (out_name_size < in_name_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (in_name_size >
> +	    max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
> +		out_name_size =
> +			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
> +
> +	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
> +	comm_buf = setup_mm_hdr((void **)&var_getnext, payload_size,
> +				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +				&ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> +	var_getnext->name_size = out_name_size;
> +	memcpy(var_getnext->name, name, in_name_size);
> +	memset((u8 *)var_getnext->name + in_name_size, 0x0,
> +	       out_name_size - in_name_size);
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
> +		/* Update with reported data size for trimmed case */
> +		*name_size = var_getnext->name_size;
> +	}
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	memcpy(guid, &var_getnext->guid, sizeof(*guid));
> +	memcpy(name, var_getnext->name, var_getnext->name_size);
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t optee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> +				       u32 attributes, unsigned long data_size,
> +				       void *data)
> +{
> +	efi_status_t ret;
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	u8 *comm_buf = NULL;
> +
> +	if (!name || name[0] == 0 || !vendor) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	if (data_size > 0 && !data) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	/* Check payload size */
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
> +	if (payload_size > max_payload_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate the buffer early, before switching to RW (if needed)
> +	 * so we won't need to account for any failures in reading/setting
> +	 * the properties, if the allocation fails
> +	 */
> +	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> +				SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/*
> +	 * The API has the ability to override RO flags. If no RO check was
> +	 * requested switch the variable to RW for the duration of this call
> +	 */
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS) {
> +		pr_err("Getting variable property failed\n");
> +		goto out;
> +	}
> +
> +	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY) {
> +		ret = EFI_WRITE_PROTECTED;
> +		goto out;
> +	}
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = data_size;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes;
> +	memcpy(var_acc->name, name, name_size);
> +	memcpy((u8 *)var_acc->name + name_size, data, data_size);
> +
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	pr_info("Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static int optee_stmm_efi_probe(struct device *dev)
> +{
> +	efi_status_t ret;
> +
> +	ret = get_max_payload(&max_payload_size);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	max_buffer_size = MM_COMMUNICATE_HEADER_SIZE +
> +			  MM_VARIABLE_COMMUNICATE_SIZE +
> +			  max_payload_size;
> +
> +	optee_ops.get_variable = optee_get_variable;
> +	optee_ops.get_next_variable = optee_get_next_variable;
> +	optee_ops.set_variable = optee_set_variable;
> +	/* TODO: support nonblocking variant */
> +	optee_ops.set_variable_nonblocking = NULL;
> +	/* set NULL, always return EFI_SUCCESS by efi_query_variable_store() */
> +	optee_ops.query_variable_store = NULL;

Why aren't you using static initialization instead?

Thanks,
Jens

> +
> +	tee_register_efivar_ops(&optee_efivars, &optee_ops);
> +
> +	return 0;
> +}
> +
> +static int optee_stmm_efi_remove(struct device *dev)
> +{
> +	tee_unregister_efivar_ops(&optee_efivars);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, optee_stmm_efi_id_table);
> +
> +static struct tee_client_driver optee_stmm_efi_driver = {
> +	.id_table	= optee_stmm_efi_id_table,
> +	.driver		= {
> +		.name		= "optee-stmm-efi",
> +		.bus		= &tee_bus_type,
> +		.probe		= optee_stmm_efi_probe,
> +		.remove		= optee_stmm_efi_remove,
> +	},
> +};
> +
> +static int __init optee_stmm_efi_mod_init(void)
> +{
> +	return driver_register(&optee_stmm_efi_driver.driver);
> +}
> +
> +static void __exit optee_stmm_efi_mod_exit(void)
> +{
> +	driver_unregister(&optee_stmm_efi_driver.driver);
> +}
> +
> +module_init(optee_stmm_efi_mod_init);
> +module_exit(optee_stmm_efi_mod_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_DESCRIPTION("OP-TEE based EFI runtime variable service driver");
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 98da206cd761..ac46274844a3 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/cred.h>
> +#include <linux/efi.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> @@ -1263,6 +1264,28 @@ static void __exit tee_exit(void)
>  	tee_class = NULL;
>  }
>  
> +void tee_register_efivar_ops(struct efivars *tee_efivars,
> +			     struct efivar_operations *ops)
> +{
> +	/*
> +	 * If the firmware EFI runtime services support SetVariable(),
> +	 * tee-based EFI variable services are not used.
> +	 */
> +	if (!efivar_supports_writes()) {
> +		pr_info("Use tee-based EFI runtime variable services\n");
> +		efivars_generic_ops_unregister();
> +		efivars_register(tee_efivars, ops);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(tee_register_efivar_ops);
> +
> +void tee_unregister_efivar_ops(struct efivars *tee_efivars)
> +{
> +	efivars_unregister(tee_efivars);
> +	efivars_generic_ops_register();
> +}
> +EXPORT_SYMBOL_GPL(tee_unregister_efivar_ops);
> +
>  subsys_initcall(tee_init);
>  module_exit(tee_exit);
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 5e301c00e9b0..14d4aa83ce60 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -39,6 +39,7 @@
>  #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
> +#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 17eb1c5205d3..def4ea6212ee 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -7,6 +7,7 @@
>  #define __TEE_DRV_H
>  
>  #include <linux/device.h>
> +#include <linux/efi.h>
>  #include <linux/idr.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -507,4 +508,26 @@ struct tee_context *teedev_open(struct tee_device *teedev);
>   */
>  void teedev_close_context(struct tee_context *ctx);
>  
> +/**
> + * tee_register_efivar_ops() - register the efivar ops
> + * @tee_efivars:	pointer to efivars structure
> + * @ops:		pointer to contain the efivar operation
> + *
> + * This function registers the tee-based efivar operation as an
> + * EFI Runtime Service.
> + *
> + */
> +void tee_register_efivar_ops(struct efivars *tee_efivars,
> +			     struct efivar_operations *ops);
> +
> +/**
> + * tee_unregister_efivar_ops() - unregister the efivar ops
> + * @tee_efivars:	pointer to efivars structure
> + *
> + * This function unregisters the tee-based efivar operation
> + * and reverts to the generic operation.
> + *
> + */
> +void tee_unregister_efivar_ops(struct efivars *tee_efivars);
> +
>  #endif /*__TEE_DRV_H*/
> -- 
> 2.30.2
> 
