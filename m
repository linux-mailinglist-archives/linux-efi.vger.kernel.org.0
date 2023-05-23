Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974F570D7B1
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjEWIi6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjEWIi1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 04:38:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD0130
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 01:36:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2536b4b3398so4675591a91.3
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684831018; x=1687423018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FkI9KbhnXgTmYmCRe4xcVqk3BbHU4UOBX4HNd5hrPo=;
        b=L9ehjLRRkHL0vZxpzVmOGPE0O8iUlR7tcGoDmkjIEWv1egG/bRSAQ30VJwfnue6atm
         A/AIvKY7Mehs7QETpIcrCqr7PhmUEs25Hi6yMos/4AEdhkITzfVOBrNV77/M5K5eeL5t
         zPlqRGPMmhPHlG66Tf5SJ9QxjqZKDEWuMB/rpHnysIVzG4JpPkt/+eYJq8Lk6M8/cwLG
         iRf9K3o1u+KOmShNLpnuZMiovK4b+6gspoFdHvuIveu6EIWJxkpfOFD1X2Af8CDk0DIv
         45iWg1YcKxY2VTcpIDF5uA+yVTQJXXN2rQSolZteB4pWgkq4lBsRqex97OOe5MP+fysH
         BJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831018; x=1687423018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FkI9KbhnXgTmYmCRe4xcVqk3BbHU4UOBX4HNd5hrPo=;
        b=E5MNu9qiXg/4hsH8ZKGaOF0lxpjf9WXBofUA4UxmkdTkR8l/m36zh0OBKZbGD7chkm
         b4E3ISLCKXuv0YfT4gPpWKj88Pc+LUb5TJiNqLayNPGpyYQpxAM6ETrAyvNfbLr4lrCW
         SRBKnX/vECEqg50M1lB7pP/r2Jea6jgzgJ0gcISJIBmwq9jJnrTCvBk/j1eqOORWb/VS
         E55PQzeUEnazzoQSG/Tx/MOUGR4q9N+xeJPnzYpIIiR0a2gR42UYOzM9OICMiJp39a4M
         +VZ1qricZpRyIZQV0FLqXHmWdBmWsqroRvZQfJgQSu9Uj/ihgekfeU1Hh0pX2Z2LfYJi
         5YQA==
X-Gm-Message-State: AC+VfDyqolirK/iH5gbepjCcL6gHGGyZ3bFjfpx4RDPk+NkcHx4pYExd
        9xNwtdckcEtCib18RsotWq78+/uLA9YN7UQb+vqtYQ==
X-Google-Smtp-Source: ACHHUZ7X6LBzfgpm6l50XZv5/uLIfKDFewRGWL2lCbp8Vol46vR8vYzpy5M0v86/PM7dNdbud9aksAXM+mNko+O1ytE=
X-Received: by 2002:a17:903:1112:b0:1aa:e736:3beb with SMTP id
 n18-20020a170903111200b001aae7363bebmr15624674plh.25.1684831017641; Tue, 23
 May 2023 01:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230222053825.992-1-masahisa.kojima@linaro.org>
 <20230222053825.992-4-masahisa.kojima@linaro.org> <CAHUa44G_=BDd4AfsaqwYCSSCWLC89iBWmRGkzh6Pa3iOtOCTpQ@mail.gmail.com>
In-Reply-To: <CAHUa44G_=BDd4AfsaqwYCSSCWLC89iBWmRGkzh6Pa3iOtOCTpQ@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Tue, 23 May 2023 17:36:46 +0900
Message-ID: <CADQ0-X9rokv4Aw_NGsTW9e-asM_6WPxsRSsaZs17TRmHJiqFpA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] efi: Add tee-based EFI variable driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jens,

On Mon, 8 May 2023 at 18:45, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Hi,
>
> On Wed, Feb 22, 2023 at 6:40=E2=80=AFAM Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > When the flash is not owned by the non-secure world, accessing the EFI
> > variables is straightforward and done via EFI Runtime Variable Services=
.
> > In this case, critical variables for system integrity and security
> > are normally stored in the dedicated secure storage and only accessible
> > from the secure world.
> >
> > On the other hand, the small embedded devices don't have the special
> > dedicated secure storage. The eMMC device with an RPMB partition is
> > becoming more common, we can use an RPMB partition to store the
> > EFI Variables.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo T=
A),
> > eMMC driver and tee-supplicant. The last piece is the tee-based
> > variable access driver to interact with TEE and StandaloneMM.
> >
> > So let's add the kernel functions needed.
> >
> > This feature is implemented as a kernel module.
> > StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> > so that this tee_stmm_efi module is probed after tee-supplicant starts,
> > since "SetVariable" EFI Runtime Variable Service requires to
> > interact with tee-supplicant.
> >
> > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/firmware/efi/Kconfig                 |  15 +
> >  drivers/firmware/efi/Makefile                |   1 +
> >  drivers/firmware/efi/stmm/mm_communication.h | 249 ++++++++
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 626 +++++++++++++++++++
> >  4 files changed, 891 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfi=
g
> > index 043ca31c114e..aa38089d1e4a 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -287,3 +287,18 @@ config UEFI_CPER_X86
> >         bool
> >         depends on UEFI_CPER && X86
> >         default y
> > +
> > +config TEE_STMM_EFI
> > +       tristate "TEE based EFI runtime variable service driver"
> > +       depends on EFI && OPTEE && !EFI_VARS_PSTORE
> > +       help
> > +         Select this config option if TEE is compiled to include Stand=
AloneMM
> > +         as a separate secure partition it has the ability to check an=
d store
> > +         EFI variables on an RPMB or any other non-volatile medium use=
d by
> > +         StandAloneMM.
> > +
> > +         Enabling this will change the EFI runtime services from the f=
irmware
> > +         provided functions to TEE calls.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called tee_stmm_efi.
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makef=
ile
> > index b51f2a4c821e..2ca8ee6ab490 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)      +=3D capsule-lo=
ader.o
> >  obj-$(CONFIG_EFI_EARLYCON)             +=3D earlycon.o
> >  obj-$(CONFIG_UEFI_CPER_ARM)            +=3D cper-arm.o
> >  obj-$(CONFIG_UEFI_CPER_X86)            +=3D cper-x86.o
> > +obj-$(CONFIG_TEE_STMM_EFI)             +=3D stmm/tee_stmm_efi.o
> > diff --git a/drivers/firmware/efi/stmm/mm_communication.h b/drivers/fir=
mware/efi/stmm/mm_communication.h
> > new file mode 100644
> > index 000000000000..a7fa6723d56e
> > --- /dev/null
> > +++ b/drivers/firmware/efi/stmm/mm_communication.h
> > @@ -0,0 +1,249 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + *  Headers for EFI variable service via StandAloneMM, EDK2 applicatio=
n running
> > + *  in OP-TEE
> > + *
> > + *  Copyright (c) 2017, Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2020 Linaro Ltd.
> > + */
> > +
> > +#ifndef _MM_COMMUNICATION_H_
> > +#define _MM_COMMUNICATION_H_
> > +
> > +/*
> > + * Interface to the pseudo Trusted Application (TA), which provides a
> > + * communication channel with the Standalone MM (Management Mode)
> > + * Secure Partition running at Secure-EL0
> > + */
> > +
> > +#define PTA_STMM_CMD_COMMUNICATE 0
> > +
> > +/* OP-TEE is using big endian GUIDs while UEFI uses little endian ones=
 */
> > +#define PTA_STMM_UUID \
> > +       UUID_INIT(0xed32d533, 0x99e6, 0x4209, \
> > +                 0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> > +
> > +#define EFI_MM_VARIABLE_GUID \
> > +       EFI_GUID(0xed32d533, 0x99e6, 0x4209, \
> > +                0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> > +
> > +/* Defined in EDK2 MdePkg/Include/Protocol/MmCommunication.h */
> > +
> > +/**
> > + * struct efi_mm_communicate_header - Header used for SMM variable com=
munication
> > +
> > + * @header_guid:  header use for disambiguation of content
> > + * @message_len:  length of the message. Does not include the size of =
the
> > + *                header
> > + * @data:         payload of the message
> > + *
> > + * Defined in EDK2 as EFI_MM_COMMUNICATE_HEADER.
> > + * To avoid confusion in interpreting frames, the communication buffer=
 should
> > + * always begin with efi_mm_communicate_header.
> > + */
> > +struct efi_mm_communicate_header {
> > +       efi_guid_t header_guid;
> > +       size_t     message_len;
> > +       u8         data[];
> > +} __packed;
> > +
> > +#define MM_COMMUNICATE_HEADER_SIZE \
> > +       (sizeof(struct efi_mm_communicate_header))
> > +
> > +/* Defined in EDK2 ArmPkg/Include/IndustryStandard/ArmMmSvc.h */
> > +
> > +/* SPM return error codes */
> > +#define ARM_SVC_SPM_RET_SUCCESS               0
> > +#define ARM_SVC_SPM_RET_NOT_SUPPORTED        -1
> > +#define ARM_SVC_SPM_RET_INVALID_PARAMS       -2
> > +#define ARM_SVC_SPM_RET_DENIED               -3
> > +#define ARM_SVC_SPM_RET_NO_MEMORY            -5
> > +
> > +/* Defined in EDK2 MdeModulePkg/Include/Guid/SmmVariableCommon.h */
> > +
> > +#define SMM_VARIABLE_FUNCTION_GET_VARIABLE  1
> > +/*
> > + * The payload for this function is
> > + * SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
> > +/*
> > + * The payload for this function is SMM_VARIABLE_COMMUNICATE_ACCESS_VA=
RIABLE.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_SET_VARIABLE  3
> > +/*
> > + * The payload for this function is
> > + * SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO  4
> > +/*
> > + * It is a notify event, no extra payload for this function.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT  5
> > +/*
> > + * It is a notify event, no extra payload for this function.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE  6
> > +/*
> > + * The payload for this function is VARIABLE_INFO_ENTRY.
> > + * The GUID in EFI_SMM_COMMUNICATE_HEADER is gEfiSmmVariableProtocolGu=
id.
> > + */
> > +#define SMM_VARIABLE_FUNCTION_GET_STATISTICS  7
> > +/*
> > + * The payload for this function is SMM_VARIABLE_COMMUNICATE_LOCK_VARI=
ABLE
> > + */
> > +#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE   8
> > +
> > +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET  9
> > +
> > +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET  10
> > +
> > +#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE  11
> > +/*
> > + * The payload for this function is
> > + * SMM_VARIABLE_COMMUNICATE_RUNTIME_VARIABLE_CACHE_CONTEXT
> > + */
> > +#define SMM_VARIABLE_FUNCTION_INIT_RUNTIME_VARIABLE_CACHE_CONTEXT 12
> > +
> > +#define SMM_VARIABLE_FUNCTION_SYNC_RUNTIME_CACHE  13
> > +/*
> > + * The payload for this function is
> > + * SMM_VARIABLE_COMMUNICATE_GET_RUNTIME_CACHE_INFO
> > + */
> > +#define SMM_VARIABLE_FUNCTION_GET_RUNTIME_CACHE_INFO  14
> > +
> > +/**
> > + * struct smm_variable_communicate_header - Used for SMM variable comm=
unication
> > +
> > + * @function:     function to call in Smm.
> > + * @ret_status:   return status
> > + * @data:         payload
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_HEADER.
> > + */
> > +struct smm_variable_communicate_header {
> > +       size_t  function;
> > +       efi_status_t ret_status;
> > +       u8 data[];
> > +};
> > +
> > +#define MM_VARIABLE_COMMUNICATE_SIZE \
> > +       (sizeof(struct smm_variable_communicate_header))
> > +
> > +/**
> > + * struct smm_variable_access - Used to communicate with StMM by
> > + *                              SetVariable and GetVariable.
> > +
> > + * @guid:         vendor GUID
> > + * @data_size:    size of EFI variable data
> > + * @name_size:    size of EFI name
> > + * @attr:         attributes
> > + * @name:         variable name
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
> > + *
> > + */
> > +struct smm_variable_access {
> > +       efi_guid_t  guid;
> > +       size_t data_size;
> > +       size_t name_size;
> > +       u32 attr;
> > +       u16 name[];
> > +};
> > +
> > +#define MM_VARIABLE_ACCESS_HEADER_SIZE \
> > +       (sizeof(struct smm_variable_access))
> > +/**
> > + * struct smm_variable_payload_size - Used to get the max allowed
> > + *                                    payload used in StMM.
> > + *
> > + * @size:  size to fill in
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_PAYLOAD_SIZE.
> > + *
> > + */
> > +struct smm_variable_payload_size {
> > +       size_t size;
> > +};
> > +
> > +/**
> > + * struct smm_variable_getnext - Used to communicate with StMM for
> > + *                               GetNextVariableName.
> > + *
> > + * @guid:       vendor GUID
> > + * @name_size:  size of the name of the variable
> > + * @name:       variable name
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
> > + */
> > +struct smm_variable_getnext {
> > +       efi_guid_t  guid;
> > +       size_t name_size;
> > +       u16         name[];
> > +};
> > +
> > +#define MM_VARIABLE_GET_NEXT_HEADER_SIZE \
> > +       (sizeof(struct smm_variable_getnext))
> > +
> > +/**
> > + * struct smm_variable_query_info - Used to communicate with StMM for
> > + *                                  QueryVariableInfo.
> > + *
> > + * @max_variable_storage:        max available storage
> > + * @remaining_variable_storage:  remaining available storage
> > + * @max_variable_size:           max variable supported size
> > + * @attr:                        attributes to query storage for
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
> > + */
> > +struct smm_variable_query_info {
> > +       u64 max_variable_storage;
> > +       u64 remaining_variable_storage;
> > +       u64 max_variable_size;
> > +       u32 attr;
> > +};
> > +
> > +#define VAR_CHECK_VARIABLE_PROPERTY_REVISION 0x0001
> > +#define VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY BIT(0)
> > +/**
> > + * struct var_check_property - Used to store variable properties in St=
MM
> > + *
> > + * @revision:   magic revision number for variable property checking
> > + * @property:   properties mask for the variable used in StMM.
> > + *              Currently RO flag is supported
> > + * @attributes: variable attributes used in StMM checking when propert=
ies
> > + *              for a variable are enabled
> > + * @minsize:    minimum allowed size for variable payload checked agai=
nst
> > + *              smm_variable_access->datasize in StMM
> > + * @maxsize:    maximum allowed size for variable payload checked agai=
nst
> > + *              smm_variable_access->datasize in StMM
> > + *
> > + * Defined in EDK2 as VAR_CHECK_VARIABLE_PROPERTY.
> > + */
> > +struct var_check_property {
> > +       u16 revision;
> > +       u16 property;
> > +       u32 attributes;
> > +       size_t minsize;
> > +       size_t maxsize;
> > +};
> > +
> > +/**
> > + * struct smm_variable_var_check_property - Used to communicate variab=
le
> > + *                                          properties with StMM
> > + *
> > + * @guid:       vendor GUID
> > + * @name_size:  size of EFI name
> > + * @property:   variable properties struct
> > + * @name:       variable name
> > + *
> > + * Defined in EDK2 as SMM_VARIABLE_COMMUNICATE_VAR_CHECK_VARIABLE_PROP=
ERTY.
> > + */
> > +struct smm_variable_var_check_property {
> > +       efi_guid_t guid;
> > +       size_t name_size;
> > +       struct var_check_property property;
> > +       u16 name[];
> > +};
> > +
> > +#endif /* _MM_COMMUNICATION_H_ */
> > diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmwar=
e/efi/stmm/tee_stmm_efi.c
> > new file mode 100644
> > index 000000000000..da4bc447f515
> > --- /dev/null
> > +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> > @@ -0,0 +1,626 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + *  EFI variable service via TEE
> > + *
> > + *  Copyright (C) 2022 Linaro
> > + */
> > +
> > +#include <linux/efi.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/tee.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/ucs2_string.h>
> > +#include "mm_communication.h"
> > +
> > +static struct efivars tee_efivars;
> > +static struct efivar_operations tee_efivar_ops;
> > +
> > +static size_t max_buffer_size; /* comm + var + func + data */
> > +static size_t max_payload_size; /* func + data */
> > +
> > +struct tee_stmm_efi_private {
> > +       struct tee_context *ctx;
> > +       u32 session;
> > +       struct device *dev;
> > +};
> > +
> > +static struct tee_stmm_efi_private pvt_data;
> > +
> > +/* UUID of the stmm PTA */
> > +static const struct tee_client_device_id tee_stmm_efi_id_table[] =3D {
> > +       {PTA_STMM_UUID},
> > +       {}
> > +};
> > +
> > +static int tee_ctx_match(struct tee_ioctl_version_data *ver, const voi=
d *data)
> > +{
> > +       /* currently only OP-TEE is supported as a communication path *=
/
> > +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> > +               return 1;
> > +       else
> > +               return 0;
> > +}
> > +
> > +/**
> > + * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
> > + *
> > + * @comm_buf:          locally allocated communication buffer
> > + * @dsize:             buffer size
> > + * Return:             status code
> > + */
> > +static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
> > +{
> > +       size_t buf_size;
> > +       efi_status_t ret;
> > +       struct efi_mm_communicate_header *mm_hdr;
> > +       struct tee_ioctl_invoke_arg arg;
> > +       struct tee_param param[4];
> > +       struct tee_shm *shm =3D NULL;
> > +       int rc;
> > +
> > +       if (!comm_buf)
> > +               return EFI_INVALID_PARAMETER;
> > +
> > +       mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> > +       buf_size =3D mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(=
size_t);
> > +
> > +       if (dsize !=3D buf_size)
> > +               return EFI_INVALID_PARAMETER;
>
> I don't see why tee_mm_communicate() should need to look inside the
> communication buffer. If we need this sanity check it's better done in
> mm_communicate() below.

I think this check is redundant and we could remove it.

>
> > +
> > +       shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf=
_size);
> > +       if (IS_ERR(shm)) {
> > +               dev_err(pvt_data.dev, "Unable to register shared memory=
\n");
> > +               return EFI_UNSUPPORTED;
> > +       }
> > +
> > +       memset(&arg, 0, sizeof(arg));
> > +       arg.func =3D PTA_STMM_CMD_COMMUNICATE;
> > +       arg.session =3D pvt_data.session;
> > +       arg.num_params =3D 4;
> > +
> > +       memset(param, 0, sizeof(param));
> > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> > +       param[0].u.memref.size =3D buf_size;
> > +       param[0].u.memref.shm =3D shm;
> > +       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> > +       param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > +       param[3].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > +
> > +       rc =3D tee_client_invoke_func(pvt_data.ctx, &arg, param);
> > +       tee_shm_free(shm);
> > +
> > +       if (rc < 0 || arg.ret !=3D 0) {
> > +               dev_err(pvt_data.dev,
> > +                       "PTA_STMM_CMD_COMMUNICATE invoke error: 0x%x\n"=
, arg.ret);
> > +               return EFI_DEVICE_ERROR;
> > +       }
> > +
> > +       switch (param[1].u.value.a) {
> > +       case ARM_SVC_SPM_RET_SUCCESS:
> > +               ret =3D EFI_SUCCESS;
> > +               break;
> > +
> > +       case ARM_SVC_SPM_RET_INVALID_PARAMS:
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               break;
> > +
> > +       case ARM_SVC_SPM_RET_DENIED:
> > +               ret =3D EFI_ACCESS_DENIED;
> > +               break;
> > +
> > +       case ARM_SVC_SPM_RET_NO_MEMORY:
> > +               ret =3D EFI_OUT_OF_RESOURCES;
> > +               break;
> > +
> > +       default:
> > +               ret =3D EFI_ACCESS_DENIED;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * mm_communicate() - Adjust the communication buffer to StandAlonneMM=
 and send
> > + * it to TEE
> > + *
> > + * @comm_buf:          locally allocated communication buffer
> > + * @dsize:             buffer size
>
> This is confusing, comm_buf points to the mm header, while dsize tells
> the payload size. So the arguments to this function aren't the normal
> buffer pointer and length tuple. When looking at how this function is
> called it makes sense, but we should clarify the relationship here.

I will rename dsize argument to payload_size, then add some comments
for comm_buf.

>
> > + * Return:             status code
> > + */
> > +static efi_status_t mm_communicate(u8 *comm_buf, size_t dsize)
> > +{
> > +       efi_status_t ret;
> > +       struct efi_mm_communicate_header *mm_hdr;
> > +       struct smm_variable_communicate_header *var_hdr;
> > +
> > +       dsize +=3D MM_COMMUNICATE_HEADER_SIZE + MM_VARIABLE_COMMUNICATE=
_SIZE;
> > +       mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> > +       var_hdr =3D (struct smm_variable_communicate_header *)mm_hdr->d=
ata;
> > +
> > +       ret =3D tee_mm_communicate(comm_buf, dsize);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               dev_err(pvt_data.dev, "%s failed!\n", __func__);
> > +               return ret;
> > +       }
> > +
> > +       return var_hdr->ret_status;
> > +}
> > +
> > +/**
> > + * setup_mm_hdr() -    Allocate a buffer for StandAloneMM and initiali=
ze the
> > + *                     header data.
> > + *
> > + * @dptr:              pointer address of the corresponding StandAlone=
MM
> > + *                     function
> > + * @payload_size:      buffer size
> > + * @func:              standAloneMM function number
> > + * @ret:               EFI return code
> > + * Return:             buffer or NULL
> > + */
> > +static u8 *setup_mm_hdr(void **dptr, size_t payload_size, size_t func,
> > +                       efi_status_t *ret)
> > +{
> > +       const efi_guid_t mm_var_guid =3D EFI_MM_VARIABLE_GUID;
> > +       struct efi_mm_communicate_header *mm_hdr;
> > +       struct smm_variable_communicate_header *var_hdr;
> > +       u8 *comm_buf;
> > +
> > +       /* In the init function we initialize max_buffer_size with
> > +        * get_max_payload(). So skip the test if max_buffer_size is in=
itialized
> > +        * StandAloneMM will perform similar checks and drop the buffer=
 if it's
> > +        * too long
> > +        */
> > +       if (max_buffer_size &&
> > +           max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
> > +                              MM_VARIABLE_COMMUNICATE_SIZE + payload_s=
ize)) {
> > +               *ret =3D EFI_INVALID_PARAMETER;
> > +               return NULL;
> > +       }
> > +
> > +       comm_buf =3D kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> > +                                  MM_VARIABLE_COMMUNICATE_SIZE + paylo=
ad_size,
> > +                          GFP_KERNEL);
> > +       if (!comm_buf) {
> > +               *ret =3D EFI_OUT_OF_RESOURCES;
> > +               return NULL;
> > +       }
> > +
> > +       mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> > +       memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->heade=
r_guid));
> > +       mm_hdr->message_len =3D MM_VARIABLE_COMMUNICATE_SIZE + payload_=
size;
> > +
> > +       var_hdr =3D (struct smm_variable_communicate_header *)mm_hdr->d=
ata;
> > +       var_hdr->function =3D func;
> > +       if (dptr)
> > +               *dptr =3D var_hdr->data;
> > +       *ret =3D EFI_SUCCESS;
> > +
> > +       return comm_buf;
> > +}
> > +
> > +/**
> > + * get_max_payload() - Get variable payload size from StandAloneMM.
> > + *
> > + * @size:    size of the variable in storage
> > + * Return:   status code
> > + */
> > +static efi_status_t get_max_payload(size_t *size)
> > +{
> > +       struct smm_variable_payload_size *var_payload =3D NULL;
> > +       size_t payload_size;
> > +       u8 *comm_buf =3D NULL;
> > +       efi_status_t ret;
> > +
> > +       if (!size) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       payload_size =3D sizeof(*var_payload);
> > +       comm_buf =3D setup_mm_hdr((void **)&var_payload, payload_size,
> > +                               SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,=
 &ret);
>
> The (void **) cast is a bit ugly. If instead the payload buffer was
> returned in the return value and &comm_buf was the first argument we
> wouldn't need to cast at all.

Thank you, I will fix it.

Sorry for the late reply.

Regards,
Masahisa Kojima

>
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +
> > +       /* Make sure the buffer is big enough for storing variables */
> > +       if (var_payload->size < MM_VARIABLE_ACCESS_HEADER_SIZE + 0x20) =
{
> > +               ret =3D EFI_DEVICE_ERROR;
> > +               goto out;
> > +       }
> > +       *size =3D var_payload->size;
> > +       /*
> > +        * There seems to be a bug in EDK2 miscalculating the boundarie=
s and
> > +        * size checks, so deduct 2 more bytes to fulfill this requirem=
ent. Fix
> > +        * it up here to ensure backwards compatibility with older vers=
ions
> > +        * (cf. StandaloneMmPkg/Drivers/StandaloneMmCpu/AArch64/EventHa=
ndle.c.
> > +        * sizeof (EFI_MM_COMMUNICATE_HEADER) instead the size minus th=
e
> > +        * flexible array member).
> > +        *
> > +        * size is guaranteed to be > 2 due to checks on the beginning.
> > +        */
> > +       *size -=3D 2;
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static efi_status_t get_property_int(u16 *name, size_t name_size,
> > +                                    const efi_guid_t *vendor,
> > +                                    struct var_check_property *var_pro=
perty)
> > +{
> > +       struct smm_variable_var_check_property *smm_property;
> > +       size_t payload_size;
> > +       u8 *comm_buf =3D NULL;
> > +       efi_status_t ret;
> > +
> > +       memset(var_property, 0, sizeof(*var_property));
> > +       payload_size =3D sizeof(*smm_property) + name_size;
> > +       if (payload_size > max_payload_size) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       comm_buf =3D setup_mm_hdr(
> > +               (void **)&smm_property, payload_size,
> > +               SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, =
&ret);
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid))=
;
> > +       smm_property->name_size =3D name_size;
> > +       memcpy(smm_property->name, name, name_size);
> > +
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       /*
> > +        * Currently only R/O property is supported in StMM.
> > +        * Variables that are not set to R/O will not set the property =
in StMM
> > +        * and the call will return EFI_NOT_FOUND. We are setting the
> > +        * properties to 0x0 so checking against that is enough for the
> > +        * EFI_NOT_FOUND case.
> > +        */
> > +       if (ret =3D=3D EFI_NOT_FOUND)
> > +               ret =3D EFI_SUCCESS;
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +       memcpy(var_property, &smm_property->property, sizeof(*var_prope=
rty));
> > +
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
> > +                                    u32 *attributes, unsigned long *da=
ta_size,
> > +                                    void *data)
> > +{
> > +       struct var_check_property var_property;
> > +       struct smm_variable_access *var_acc;
> > +       size_t payload_size;
> > +       size_t name_size;
> > +       size_t tmp_dsize;
> > +       u8 *comm_buf =3D NULL;
> > +       efi_status_t ret;
> > +
> > +       if (!name || !vendor || !data_size) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * size=
of(u16);
> > +       if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SI=
ZE) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       /* Trim output buffer size */
> > +       tmp_dsize =3D *data_size;
> > +       if (name_size + tmp_dsize >
> > +           max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> > +               tmp_dsize =3D max_payload_size - MM_VARIABLE_ACCESS_HEA=
DER_SIZE -
> > +                           name_size;
> > +       }
> > +
> > +       /* Get communication buffer and initialize header */
> > +       payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + t=
mp_dsize;
> > +       comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
> > +                               SMM_VARIABLE_FUNCTION_GET_VARIABLE, &re=
t);
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       /* Fill in contents */
> > +       memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> > +       var_acc->data_size =3D tmp_dsize;
> > +       var_acc->name_size =3D name_size;
> > +       var_acc->attr =3D attributes ? *attributes : 0;
> > +       memcpy(var_acc->name, name, name_size);
> > +
> > +       /* Communicate */
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       if (ret =3D=3D EFI_SUCCESS || ret =3D=3D EFI_BUFFER_TOO_SMALL)
> > +               /* Update with reported data size for trimmed case */
> > +               *data_size =3D var_acc->data_size;
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +
> > +       ret =3D get_property_int(name, name_size, vendor, &var_property=
);
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +
> > +       if (attributes)
> > +               *attributes =3D var_acc->attr;
> > +
> > +       if (data)
> > +               memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
> > +                      var_acc->data_size);
> > +       else
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static efi_status_t tee_get_next_variable(unsigned long *name_size,
> > +                                         efi_char16_t *name, efi_guid_=
t *guid)
> > +{
> > +       struct smm_variable_getnext *var_getnext;
> > +       size_t payload_size;
> > +       size_t out_name_size;
> > +       size_t in_name_size;
> > +       u8 *comm_buf =3D NULL;
> > +       efi_status_t ret;
> > +
> > +       if (!name_size || !name || !guid) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       out_name_size =3D *name_size;
> > +       in_name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * s=
izeof(u16);
> > +
> > +       if (out_name_size < in_name_size) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       if (in_name_size >
> > +           max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       /* Trim output buffer size */
> > +       if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEA=
DER_SIZE)
> > +               out_name_size =3D
> > +                       max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_=
SIZE;
> > +
> > +       payload_size =3D MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_si=
ze;
> > +       comm_buf =3D setup_mm_hdr((void **)&var_getnext, payload_size,
> > +                               SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE=
_NAME,
> > +                               &ret);
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       /* Fill in contents */
> > +       memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> > +       var_getnext->name_size =3D out_name_size;
> > +       memcpy(var_getnext->name, name, in_name_size);
> > +       memset((u8 *)var_getnext->name + in_name_size, 0x0,
> > +              out_name_size - in_name_size);
> > +
> > +       /* Communicate */
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       if (ret =3D=3D EFI_SUCCESS || ret =3D=3D EFI_BUFFER_TOO_SMALL) =
{
> > +               /* Update with reported data size for trimmed case */
> > +               *name_size =3D var_getnext->name_size;
> > +       }
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +
> > +       memcpy(guid, &var_getnext->guid, sizeof(*guid));
> > +       memcpy(name, var_getnext->name, var_getnext->name_size);
> > +
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *v=
endor,
> > +                                    u32 attributes, unsigned long data=
_size,
> > +                                    void *data)
> > +{
> > +       efi_status_t ret;
> > +       struct var_check_property var_property;
> > +       struct smm_variable_access *var_acc;
> > +       size_t payload_size;
> > +       size_t name_size;
> > +       u8 *comm_buf =3D NULL;
> > +
> > +       if (!name || name[0] =3D=3D 0 || !vendor) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       if (data_size > 0 && !data) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +       /* Check payload size */
> > +       name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * size=
of(u16);
> > +       payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + d=
ata_size;
> > +       if (payload_size > max_payload_size) {
> > +               ret =3D EFI_INVALID_PARAMETER;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Allocate the buffer early, before switching to RW (if needed=
)
> > +        * so we won't need to account for any failures in reading/sett=
ing
> > +        * the properties, if the allocation fails
> > +        */
> > +       comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
> > +                               SMM_VARIABLE_FUNCTION_SET_VARIABLE, &re=
t);
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       /*
> > +        * The API has the ability to override RO flags. If no RO check=
 was
> > +        * requested switch the variable to RW for the duration of this=
 call
> > +        */
> > +       ret =3D get_property_int(name, name_size, vendor, &var_property=
);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               dev_err(pvt_data.dev, "Getting variable property failed=
\n");
> > +               goto out;
> > +       }
> > +
> > +       if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ON=
LY) {
> > +               ret =3D EFI_WRITE_PROTECTED;
> > +               goto out;
> > +       }
> > +
> > +       /* Fill in contents */
> > +       memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> > +       var_acc->data_size =3D data_size;
> > +       var_acc->name_size =3D name_size;
> > +       var_acc->attr =3D attributes;
> > +       memcpy(var_acc->name, name, name_size);
> > +       memcpy((u8 *)var_acc->name + name_size, data, data_size);
> > +
> > +
> > +       /* Communicate */
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __L=
INE__, ret);
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static efi_status_t __maybe_unused tee_query_variable_info(u32 attribu=
tes,
> > +                                           u64 *max_variable_storage_s=
ize,
> > +                                           u64 *remain_variable_storag=
e_size,
> > +                                           u64 *max_variable_size)
> > +{
> > +       struct smm_variable_query_info *mm_query_info;
> > +       size_t payload_size;
> > +       efi_status_t ret;
> > +       u8 *comm_buf;
> > +
> > +       payload_size =3D sizeof(*mm_query_info);
> > +       comm_buf =3D setup_mm_hdr((void **)&mm_query_info, payload_size=
,
> > +                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_IN=
FO,
> > +                               &ret);
> > +       if (!comm_buf)
> > +               goto out;
> > +
> > +       mm_query_info->attr =3D attributes;
> > +       ret =3D mm_communicate(comm_buf, payload_size);
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto out;
> > +       *max_variable_storage_size =3D mm_query_info->max_variable_stor=
age;
> > +       *remain_variable_storage_size =3D
> > +               mm_query_info->remaining_variable_storage;
> > +       *max_variable_size =3D mm_query_info->max_variable_size;
> > +
> > +out:
> > +       kfree(comm_buf);
> > +       return ret;
> > +}
> > +
> > +static int tee_stmm_efi_probe(struct device *dev)
> > +{
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       efi_status_t ret;
> > +       int rc;
> > +
> > +       /* Open context with TEE driver */
> > +       pvt_data.ctx =3D tee_client_open_context(NULL, tee_ctx_match, N=
ULL, NULL);
> > +       if (IS_ERR(pvt_data.ctx))
> > +               return -ENODEV;
> > +
> > +       /* Open session with StMM PTA */
> > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > +       export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
> > +       rc =3D tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> > +       if ((rc < 0) || (sess_arg.ret !=3D 0)) {
> > +               dev_err(dev, "tee_client_open_session failed, err: %x\n=
",
> > +                       sess_arg.ret);
> > +               rc =3D -EINVAL;
> > +               goto out_ctx;
> > +       }
> > +       pvt_data.session =3D sess_arg.session;
> > +       pvt_data.dev =3D dev;
> > +
> > +       ret =3D get_max_payload(&max_payload_size);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               rc =3D -EIO;
> > +               goto out_sess;
> > +       }
> > +
> > +       max_buffer_size =3D MM_COMMUNICATE_HEADER_SIZE +
> > +                         MM_VARIABLE_COMMUNICATE_SIZE +
> > +                         max_payload_size;
> > +
> > +       tee_efivar_ops.get_variable =3D tee_get_variable;
> > +       tee_efivar_ops.get_next_variable =3D tee_get_next_variable;
> > +       tee_efivar_ops.set_variable =3D tee_set_variable;
> > +       /* TODO: support non-blocking variant */
> > +       tee_efivar_ops.set_variable_nonblocking =3D NULL;
> > +       tee_efivar_ops.query_variable_store =3D efi_query_variable_stor=
e;
> > +
> > +       efivars_generic_ops_unregister();
> > +       pr_info("Use tee-based EFI runtime variable services\n");
> > +       efivars_register(&tee_efivars, &tee_efivar_ops);
> > +
> > +       return 0;
> > +
> > +out_sess:
> > +       tee_client_close_session(pvt_data.ctx, pvt_data.session);
> > +out_ctx:
> > +       tee_client_close_context(pvt_data.ctx);
> > +
> > +       return rc;
> > +}
> > +
> > +static int tee_stmm_efi_remove(struct device *dev)
> > +{
> > +       efivars_unregister(&tee_efivars);
> > +       efivars_generic_ops_register();
> > +
> > +       tee_client_close_session(pvt_data.ctx, pvt_data.session);
> > +       tee_client_close_context(pvt_data.ctx);
> > +
> > +       return 0;
> > +}
> > +
> > +MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> > +
> > +static struct tee_client_driver tee_stmm_efi_driver =3D {
> > +       .id_table       =3D tee_stmm_efi_id_table,
> > +       .driver         =3D {
> > +               .name           =3D "tee-stmm-efi",
> > +               .bus            =3D &tee_bus_type,
> > +               .probe          =3D tee_stmm_efi_probe,
> > +               .remove         =3D tee_stmm_efi_remove,
> > +       },
> > +};
> > +
> > +static int __init tee_stmm_efi_mod_init(void)
> > +{
> > +       return driver_register(&tee_stmm_efi_driver.driver);
> > +}
> > +
> > +static void __exit tee_stmm_efi_mod_exit(void)
> > +{
> > +       driver_unregister(&tee_stmm_efi_driver.driver);
> > +}
> > +
> > +module_init(tee_stmm_efi_mod_init);
> > +module_exit(tee_stmm_efi_mod_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> > +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> > +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");
> > --
> > 2.30.2
> >
>
> The TEE API usage looks OK in this patch.
>
> Cheers,
> Jens
