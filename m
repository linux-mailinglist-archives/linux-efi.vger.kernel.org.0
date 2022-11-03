Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676316186B2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Nov 2022 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKCR5O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Nov 2022 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKCR5N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Nov 2022 13:57:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22581B9F2;
        Thu,  3 Nov 2022 10:57:12 -0700 (PDT)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3BHD2x4tz67M3B;
        Fri,  4 Nov 2022 01:55:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 18:57:10 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 17:57:10 +0000
Date:   Thu, 3 Nov 2022 17:57:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 2/2] efi/cper, cxl: Decode CXL Error Log
Message-ID: <20221103175709.00000591@Huawei.com>
In-Reply-To: <20221028200950.67505-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
        <20221028200950.67505-3-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 20:09:50 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Print the CXL Error Log field as found in CXL Protocol Error Section.
> 
> The CXL RAS Capability structure will be reused by OS First Handling
> and the duplication/appropriate placement will be addressed eventually.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Hi Smita,

Ah.  Now I see why stuff wasn't in patch 1 that I expected to be there.

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>




> ---
> v2:
> 	Printed all fields separately.
> 	Printed cap_control.
> 	Prefix cxl_.
> 	Provided the reference.
> ---
>  drivers/firmware/efi/cper_cxl.c | 27 +++++++++++++++++++++++++++
>  include/linux/cxl_err.h         | 22 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 include/linux/cxl_err.h
> 
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 6c94af234be9..53e435c4f310 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/cper.h>
>  #include "cper_cxl.h"
> +#include <linux/cxl_err.h>
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>  #define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> @@ -16,6 +17,7 @@
>  #define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
>  #define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
>  #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> +#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
>  
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
> @@ -149,4 +151,29 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
>  			       prot_err->dvsec_len, 0);
>  	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG) {
> +		size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
> +		struct cxl_ras_capability_regs *cxl_ras;
> +
> +		pr_info("%s Error log length: 0x%04x\n", pfx, prot_err->err_len);
> +
> +		pr_info("%s CXL Error Log:\n", pfx);
> +		cxl_ras = (struct cxl_ras_capability_regs *)((long)prot_err + size);
> +		pr_info("%s cxl_ras_uncor_status: 0x%08x", pfx,
> +			cxl_ras->uncor_status);
> +		pr_info("%s cxl_ras_uncor_mask: 0x%08x\n", pfx,
> +			cxl_ras->uncor_mask);
> +		pr_info("%s cxl_ras_uncor_severity: 0x%08x\n", pfx,
> +			cxl_ras->uncor_severity);
> +		pr_info("%s cxl_ras_cor_status: 0x%08x", pfx,
> +			cxl_ras->cor_status);
> +		pr_info("%s cxl_ras_cor_mask: 0x%08x\n", pfx,
> +			cxl_ras->cor_mask);
> +		pr_info("%s cap_control: 0x%08x\n", pfx,
> +			cxl_ras->cap_control);
> +		pr_info("%s Header Log Registers:\n", pfx);
> +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, cxl_ras->header_log,
> +			       sizeof(cxl_ras->header_log), 0);
> +	}
>  }
> diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
> new file mode 100644
> index 000000000000..629e1bdeda44
> --- /dev/null
> +++ b/include/linux/cxl_err.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#ifndef LINUX_CXL_ERR_H
> +#define LINUX_CXL_ERR_H
> +
> +/* CXL RAS Capability Structure, CXL v3.1 sec 8.2.4.16 */
> +struct cxl_ras_capability_regs {
> +	u32 uncor_status;
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_status;
> +	u32 cor_mask;
> +	u32 cap_control;
> +	u32 header_log[16];
> +};
> +
> +#endif //__CXL_ERR_

