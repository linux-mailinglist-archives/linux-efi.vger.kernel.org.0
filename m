Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15376B887
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHAPXQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHAPXP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 11:23:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2E1FDC
        for <linux-efi@vger.kernel.org>; Tue,  1 Aug 2023 08:23:12 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B41542477
        for <linux-efi@vger.kernel.org>; Tue,  1 Aug 2023 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690903389;
        bh=TTncWRHerUyrRanZici4keBbgrE+UYEOR4dmgze4mIg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bZAcTiVQr8XrDPX/ZF90CqEV5TlXJ+u/2QUc7FZkD1GQHgAO9eDdIxToHFvWLR4Mk
         Kh33qZQQeh2CS2Eg9EYkRAO/Cp1kI0XguBLjNPFraa+e4UXAwBz08+PGKM9u6obILg
         iYzHuwQFgDbNhwN/RYh69LhuEpU/pyDZJM+HmW5etg03a0dGVnkHFq3GWM0jd/VAwK
         ZRMIsjKvWMhFX2mpoxhSIqg/bfuUUA/dQaw3CVjkqDVHCAfCbnryS36r7Dt8M06mya
         +WwIyPoBwGLKFYKZP2+Pfjvw548pZo6z5M/H4E0DwTK42r1RcysPbQzLMkvgvCA9tj
         6rAVA57V3il0w==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-317b30fedb0so121561f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 01 Aug 2023 08:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903388; x=1691508188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTncWRHerUyrRanZici4keBbgrE+UYEOR4dmgze4mIg=;
        b=focE9lIDICWmWXN9SZC+QCU39RlZE+QBiHyfh3fnicc/SzGLD9wQ8j4Z1yYPFSav4N
         MaswDfkGpu3VuWHX6p3zrwClDtAtXZrfSDufUfLX8FnYKJvEWn7db25Q66mzkiZgsOZ9
         KV0Zs+N0JVHNIgeSHlNzxk+J1GGpEMPheU1G3uIUwbC7uKvQiC5Don078HxGgCKb8ftN
         j3ndiX+OytiLNzL8AFkmqlzroqZRuySAbLQ7QaAib3y3PFR8I4cjfafPpGv/FxCWlU6w
         7tuE5y6F2TnteLEosdOv7UGKN8dtp8qs9Q7jXqZTCTWl+cITyrUfMOpUz+wpMAUVfbtx
         Rn6g==
X-Gm-Message-State: ABy/qLbyNvPm8R/9xkTOnwkBbV+9BcFbFRkQ2/Wi2OvF79Be0EEfL+8n
        15WIfk52JipPmr+FWYzWDJy4Qkdt9sKoklLSs3JdA6H8D7ImV1KASKDeF/+mmsfAjvRf5wWFyxk
        dxYshofmzwDeynQHhXp0rtci0gqkGXecUo1oJ1w==
X-Received: by 2002:a05:6000:1084:b0:313:eaf5:515 with SMTP id y4-20020a056000108400b00313eaf50515mr2288842wrw.6.1690903387844;
        Tue, 01 Aug 2023 08:23:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTHlne5XaNWvZnEHGzsbYn1/wngA4SAz2RqCVu3kCTlGeRALBdJzsHXTQaWWlPbmEdblRkGA==
X-Received: by 2002:a05:6000:1084:b0:313:eaf5:515 with SMTP id y4-20020a056000108400b00313eaf50515mr2288822wrw.6.1690903387301;
        Tue, 01 Aug 2023 08:23:07 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-244-162.um16.pools.vodafone-ip.de. [62.143.244.162])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fe1a092925sm8691980wmk.19.2023.08.01.08.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 08:23:06 -0700 (PDT)
Message-ID: <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
Date:   Tue, 1 Aug 2023 17:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
 <20230731065041.1447-4-masahisa.kojima@linaro.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230731065041.1447-4-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 31.07.23 08:50, Masahisa Kojima wrote:
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
> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> eMMC driver and tee-supplicant. The last piece is the tee-based
> variable access driver to interact with TEE and StandaloneMM.
> 
> So let's add the kernel functions needed.
> 
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this tee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   drivers/firmware/efi/Kconfig                 |  15 +
>   drivers/firmware/efi/Makefile                |   1 +
>   drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
>   drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
>   4 files changed, 890 insertions(+)
>   create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>   create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> 
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..aa38089d1e4a 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -287,3 +287,18 @@ config UEFI_CPER_X86
>   	bool
>   	depends on UEFI_CPER && X86
>   	default y
> +
> +config TEE_STMM_EFI
> +	tristate "TEE based EFI runtime variable service driver"
> +	depends on EFI && OPTEE && !EFI_VARS_PSTORE
> +	help
> +	  Select this config option if TEE is compiled to include StandAloneMM
> +	  as a separate secure partition it has the ability to check and store
> +	  EFI variables on an RPMB or any other non-volatile medium used by
> +	  StandAloneMM.
> +
> +	  Enabling this will change the EFI runtime services from the firmware
> +	  provided functions to TEE calls.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tee_stmm_efi.
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index b51f2a4c821e..2ca8ee6ab490 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
>   obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
>   obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
>   obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
> +obj-$(CONFIG_TEE_STMM_EFI)		+= stmm/tee_stmm_efi.o
> diff --git a/drivers/firmware/efi/stmm/mm_communication.h b/drivers/firmware/efi/stmm/mm_communication.h
> new file mode 100644
> index 000000000000..52a1f32cd1eb
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/mm_communication.h
> @@ -0,0 +1,236 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Headers for EFI variable service via StandAloneMM, EDK2 application running
> + *  in OP-TEE. Most of the structs and defines resemble the EDK2 naming.
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
> +#define PTA_STMM_CMD_COMMUNICATE 0
> +
> +/*
> + * Defined in OP-TEE, this UUID is used to identify the pseudo-TA.
> + * OP-TEE is using big endian GUIDs while UEFI uses little endian ones
> + */
> +#define PTA_STMM_UUID \
> +	UUID_INIT(0xed32d533, 0x99e6, 0x4209, \
> +		  0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +#define EFI_MM_VARIABLE_GUID \
> +	EFI_GUID(0xed32d533, 0x99e6, 0x4209, \
> +		 0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +/**
> + * struct efi_mm_communicate_header - Header used for SMM variable communication
> +
> + * @header_guid:  header use for disambiguation of content
> + * @message_len:  length of the message. Does not include the size of the
> + *                header
> + * @data:         payload of the message
> + *
> + * Defined in the PI spec as EFI_MM_COMMUNICATE_HEADER.
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
> +/* SPM return error codes */
> +#define ARM_SVC_SPM_RET_SUCCESS               0
> +#define ARM_SVC_SPM_RET_NOT_SUPPORTED        -1
> +#define ARM_SVC_SPM_RET_INVALID_PARAMS       -2
> +#define ARM_SVC_SPM_RET_DENIED               -3
> +#define ARM_SVC_SPM_RET_NO_MEMORY            -5
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
> + */
> +struct smm_variable_var_check_property {
> +	efi_guid_t guid;
> +	size_t name_size;
> +	struct var_check_property property;
> +	u16 name[];
> +};
> +
> +#endif /* _MM_COMMUNICATION_H_ */
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> new file mode 100644
> index 000000000000..f6623171ae04
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  EFI variable service via TEE
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
> +
> +static struct efivars tee_efivars;
> +static struct efivar_operations tee_efivar_ops;
> +
> +static size_t max_buffer_size; /* comm + var + func + data */
> +static size_t max_payload_size; /* func + data */
> +
> +struct tee_stmm_efi_private {
> +	struct tee_context *ctx;
> +	u32 session;
> +	struct device *dev;
> +};
> +
> +static struct tee_stmm_efi_private pvt_data;
> +
> +/* UUID of the stmm PTA */
> +static const struct tee_client_device_id tee_stmm_efi_id_table[] = {
> +	{PTA_STMM_UUID},
> +	{}
> +};
> +
> +static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/* currently only OP-TEE is supported as a communication path */
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/**
> + * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
> + *
> + * @comm_buf:		locally allocated communication buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
> +{
> +	size_t buf_size;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[4];
> +	struct tee_shm *shm = NULL;
> +	int rc;
> +
> +	if (!comm_buf)
> +		return EFI_INVALID_PARAMETER;
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
> +
> +	if (dsize != buf_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	shm = tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
> +	if (IS_ERR(shm)) {
> +		dev_err(pvt_data.dev, "Unable to register shared memory\n");
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.func = PTA_STMM_CMD_COMMUNICATE;
> +	arg.session = pvt_data.session;
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
> +	rc = tee_client_invoke_func(pvt_data.ctx, &arg, param);
> +	tee_shm_free(shm);
> +
> +	if (rc < 0 || arg.ret != 0) {
> +		dev_err(pvt_data.dev,
> +			"PTA_STMM_CMD_COMMUNICATE invoke error: 0x%x\n", arg.ret);
> +		return EFI_DEVICE_ERROR;
> +	}
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
> + * mm_communicate() - Adjust the communication buffer to StandAlonneMM and send
> + * it to TEE
> + *
> + * @comm_buf:		locally allocated communication buffer, buffer should
> + *			be enough big to have some headers and payload
> + * @payload_size:	payload size
> + * Return:		status code
> + */
> +static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
> +{
> +	size_t dsize;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct smm_variable_communicate_header *var_hdr;
> +
> +	dsize = payload_size + MM_COMMUNICATE_HEADER_SIZE +
> +		MM_VARIABLE_COMMUNICATE_SIZE;
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +
> +	ret = tee_mm_communicate(comm_buf, dsize);
> +	if (ret != EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "%s failed!\n", __func__);
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
> + * @dptr:		pointer address to store allocated buffer
> + * @payload_size:	payload size
> + * @func:		standAloneMM function number
> + * @ret:		EFI return code
> + * Return:		pointer to corresponding StandAloneMM function buffer or NULL
> + */
> +static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
> +			  efi_status_t *ret)
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
> +		*dptr = comm_buf;
> +	*ret = EFI_SUCCESS;
> +
> +	return var_hdr->data;
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
> +	var_payload = setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
> +				   &ret);
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
> +	smm_property = setup_mm_hdr(
> +		&comm_buf, payload_size,
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
> +static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
> +				     u32 *attributes, unsigned long *data_size,
> +				     void *data)
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
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
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
> +static efi_status_t tee_get_next_variable(unsigned long *name_size,
> +					  efi_char16_t *name, efi_guid_t *guid)
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
> +	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +				   &ret);
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
> +static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> +				     u32 attributes, unsigned long data_size,
> +				     void *data)
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
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/*
> +	 * The API has the ability to override RO flags. If no RO check was
> +	 * requested switch the variable to RW for the duration of this call
> +	 */
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "Getting variable property failed\n");
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
> +	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable_nonblocking(efi_char16_t *name,
> +						 efi_guid_t *vendor,
> +						 u32 attributes,
> +						 unsigned long data_size,
> +						 void *data)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t tee_query_variable_info(u32 attributes,
> +					    u64 *max_variable_storage_size,
> +					    u64 *remain_variable_storage_size,
> +					    u64 *max_variable_size)
> +{
> +	struct smm_variable_query_info *mm_query_info;
> +	size_t payload_size;
> +	efi_status_t ret;
> +	u8 *comm_buf;
> +
> +	payload_size = sizeof(*mm_query_info);
> +	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
> +				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +				&ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	mm_query_info->attr = attributes;
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +	*max_variable_storage_size = mm_query_info->max_variable_storage;
> +	*remain_variable_storage_size =
> +		mm_query_info->remaining_variable_storage;
> +	*max_variable_size = mm_query_info->max_variable_size;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static int tee_stmm_efi_probe(struct device *dev)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	efi_status_t ret;
> +	int rc;
> +
> +	/* Open context with TEE driver */
> +	pvt_data.ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	/* Open session with StMM PTA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
> +	rc = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out_ctx;
> +	}
> +	pvt_data.session = sess_arg.session;
> +	pvt_data.dev = dev;
> +
> +	ret = get_max_payload(&max_payload_size);
> +	if (ret != EFI_SUCCESS) {
> +		rc = -EIO;
> +		goto out_sess;
> +	}
> +
> +	max_buffer_size = MM_COMMUNICATE_HEADER_SIZE +
> +			  MM_VARIABLE_COMMUNICATE_SIZE +
> +			  max_payload_size;
> +
> +	tee_efivar_ops.get_variable = tee_get_variable;
> +	tee_efivar_ops.get_next_variable = tee_get_next_variable;
> +	tee_efivar_ops.set_variable = tee_set_variable;
> +	tee_efivar_ops.set_variable_nonblocking = tee_set_variable_nonblocking;
> +	tee_efivar_ops.query_variable_store = efi_query_variable_store;
> +	tee_efivar_ops.query_variable_info = tee_query_variable_info;
> +
> +	efivars_generic_ops_unregister();
> +	pr_info("Use tee-based EFI runtime variable services\n");
> +	efivars_register(&tee_efivars, &tee_efivar_ops);
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return rc;
> +}
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +	efivars_unregister(&tee_efivars);
> +	efivars_generic_ops_register();
> +
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> +
> +static struct tee_client_driver tee_stmm_efi_driver = {
> +	.id_table	= tee_stmm_efi_id_table,
> +	.driver		= {
> +		.name		= "tee-stmm-efi",
> +		.bus		= &tee_bus_type,
> +		.probe		= tee_stmm_efi_probe,
> +		.remove		= tee_stmm_efi_remove,
> +	},
> +};
> +
> +static int __init tee_stmm_efi_mod_init(void)
> +{
> +	return driver_register(&tee_stmm_efi_driver.driver);

Assuming that multiple drivers supplying EFI runtime services may be 
available in future, e.g.

* generic, using EFI runtime function supplied by UEFI firmware
* TEE-STMM
* Qualcomm driver as needed for Lenovo X13s
* ubootefi.var file in ESP

further assuming that multiple driver probe functions succeed:

How do you identify which driver to activate?

Best regards

Heinrich

> +}
> +
> +static void __exit tee_stmm_efi_mod_exit(void)
> +{
> +	driver_unregister(&tee_stmm_efi_driver.driver);
> +}
> +
> +module_init(tee_stmm_efi_mod_init);
> +module_exit(tee_stmm_efi_mod_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");

