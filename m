Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7196FE7EA
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 01:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjEJXFE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjEJXFC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 19:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5E524C;
        Wed, 10 May 2023 16:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF0E636E4;
        Wed, 10 May 2023 23:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E5C433D2;
        Wed, 10 May 2023 23:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683759892;
        bh=QxtvXxDtUmO2zciTU9oZisOXrc+rH38HVyRqoKkNSF0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=jxqufG+qooH4aJVMNjh2O09Sd+b03vlSqSVZwvPJFqf855TFAXGtc/cXNknIFIma3
         JsMe4/YBqLkuayBZN6xHYBuiil2dRiQfdRci+VO2FEFdWkzbyOCIckowL3kcVuH5XU
         pGPZCpMVQeUJki4RoervOwfbZQYT3ku4mLwdrHgPg4QmMrGxUz/kYOlutbENNgnwjN
         K8I+BVuw2hezglvSVaOw5VJ18WpelPJEsc/fARh+V+dDVZTkPIJug7p2mObnNO6bAI
         49j9mDbx/JKn0sV1f2vXuwlJqtdewvUC0e72YsmRP6QxItVW+hDJW/3XT5rjTID3wj
         DV7Vsm5t7ac6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 02:04:47 +0300
Message-Id: <CSIZ2DT5C4WQ.19ZUUIWKNAJY9@suppilovahvero>
Cc:     <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
        <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
        <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ross Philipson" <ross.philipson@oracle.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
In-Reply-To: <20230504145023.835096-5-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 include/linux/slr_table.h
>
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
> new file mode 100644
> index 0000000..d4b76e5
> --- /dev/null
> +++ b/include/linux/slr_table.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Secure Launch Resource Table
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#ifndef _LINUX_SLR_TABLE_H
> +#define _LINUX_SLR_TABLE_H
> +
> +/* Put this in efi.h if it becomes a standard */
> +#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x3=
4, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
> +
> +/* SLR table header values */
> +#define SLR_TABLE_MAGIC		0x4452544d
> +#define SLR_TABLE_REVISION	1
> +
> +/* Current revisions for the policy and UEFI config */
> +#define SLR_POLICY_REVISION		1
> +#define SLR_UEFI_CONFIG_REVISION	1
> +
> +/* SLR defined architectures */
> +#define SLR_INTEL_TXT		1
> +#define SLR_AMD_SKINIT		2
> +
> +/* SLR defined bootloaders */
> +#define SLR_BOOTLOADER_INVALID	0
> +#define SLR_BOOTLOADER_GRUB	1
> +
> +/* Log formats */
> +#define SLR_DRTM_TPM12_LOG	1
> +#define SLR_DRTM_TPM20_LOG	2
> +
> +/* DRTM Policy Entry Flags */
> +#define SLR_POLICY_FLAG_MEASURED	0x1
> +#define SLR_POLICY_IMPLICIT_SIZE	0x2
> +
> +/* Array Lengths */
> +#define TPM_EVENT_INFO_LENGTH		32
> +#define TXT_VARIABLE_MTRRS_LENGTH	32
> +
> +/* Tags */
> +#define SLR_ENTRY_INVALID	0x0000
> +#define SLR_ENTRY_DL_INFO	0x0001
> +#define SLR_ENTRY_LOG_INFO	0x0002
> +#define SLR_ENTRY_ENTRY_POLICY	0x0003
> +#define SLR_ENTRY_INTEL_INFO	0x0004
> +#define SLR_ENTRY_AMD_INFO	0x0005
> +#define SLR_ENTRY_ARM_INFO	0x0006
> +#define SLR_ENTRY_UEFI_INFO	0x0007
> +#define SLR_ENTRY_UEFI_CONFIG	0x0008
> +#define SLR_ENTRY_END		0xffff

"Enums are preferred when defining several related constants."

See:

https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enu=
ms-and-rtl

BR, Jarkko
