Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D8618696
	for <lists+linux-efi@lfdr.de>; Thu,  3 Nov 2022 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKCRuQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Nov 2022 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiKCRt7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Nov 2022 13:49:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4A1D303;
        Thu,  3 Nov 2022 10:49:49 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3B732fK7z67KQL;
        Fri,  4 Nov 2022 01:47:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 18:49:46 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 17:49:46 +0000
Date:   Thu, 3 Nov 2022 17:49:45 +0000
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
Subject: Re: [PATCH v2 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Message-ID: <20221103174945.00004917@Huawei.com>
In-Reply-To: <20221028200950.67505-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
        <20221028200950.67505-2-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Fri, 28 Oct 2022 20:09:49 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Add support for decoding CXL Protocol Error Section as defined in UEFI 2.10
> Section N.2.13.
> 
> Do the section decoding in a new cper_cxl.c file. This new file will be
> used in the future for more CXL CPERs decode support. Add this to the
> existing UEFI_CPER config.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
A few really trivial things inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> 	Added all fields for decoding. Printed DVSEC and Capability ID.
> 	Added additional CXL Agent Types based on UEFI 2.10.
> 	Named the unnamed union to agent addr.
> 	Changed field name from agent_addr -> rcrb_base_addr.
> 	subsystem_device_id -> subsystem_id.
> 	Commented why different union elements are relevant.
> 	Provided other comments wherever necessary.
> ---
>  drivers/firmware/efi/Makefile   |   2 +-
>  drivers/firmware/efi/cper.c     |   9 ++
>  drivers/firmware/efi/cper_cxl.c | 152 ++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/cper_cxl.h |  66 ++++++++++++++
>  4 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/cper_cxl.c
>  create mode 100644 drivers/firmware/efi/cper_cxl.h
> 
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 8d151e332584..4f332de54173 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -19,7 +19,7 @@ endif
>  obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
>  obj-$(CONFIG_EFI_ESRT)			+= esrt.o
>  obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
> -obj-$(CONFIG_UEFI_CPER)			+= cper.o
> +obj-$(CONFIG_UEFI_CPER)			+= cper.o cper_cxl.o
>  obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
>  obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
>  subdir-$(CONFIG_EFI_STUB)		+= libstub
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index e4e5ea7ce910..181deb9af527 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -24,6 +24,7 @@
>  #include <linux/bcd.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> +#include "cper_cxl.h"
>  
>  /*
>   * CPER record ID need to be unique even after reboot, because record
> @@ -595,6 +596,14 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>  			cper_print_fw_err(newpfx, gdata, fw_err);
>  		else
>  			goto err_section_too_small;
> +	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> +
> +		printk("%ssection_type: CXL Protocol Error\n", newpfx);
> +		if (gdata->error_data_length >= sizeof(*prot_err))
> +			cper_print_prot_err(newpfx, prot_err);
> +		else
> +			goto err_section_too_small;
>  	} else {
>  		const void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> new file mode 100644
> index 000000000000..6c94af234be9
> --- /dev/null
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UEFI Common Platform Error Record (CPER) support for CXL Section.
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#include <linux/cper.h>
> +#include "cper_cxl.h"
> +
> +#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> +#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> +#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
> +#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
> +#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
> +#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)

Error log valid should probably be here.  Bit 6.
We might not use it, but it's a bit odd to have all but one entry
from the spec defined.

> +
> +static const char * const prot_err_agent_type_strs[] = {
> +	"Restricted CXL Device",
> +	"Restricted CXL Host Downstream Port",
> +	"CXL Device",
> +	"CXL Logical Device",
> +	"CXL Fabric Manager managed Logical Device",
> +	"CXL Root Port",
> +	"CXL Downstream Switch Port",
> +	"CXL Upstream Switch Port",
> +};
> +
> +/*
> + * The layout of the enumeration and the values matches CXL Agent Type
> + * field in the UEFI 2.10 Section N.2.13,
> + */
> +enum {
> +	RCD,	/* Restricted CXL Device */
> +	RCH_DP,	/* Restricted CXL Host Downstream Port */
> +	DEVICE,	/* CXL Device */
> +	LD,	/* CXL Logical Device */
> +	FMLD,	/* CXL Fabric Manager managed Logical Device */
> +	RP,	/* CXL Root Port */
> +	DSP,	/* CXL Downstream Switch Port */
> +	USP,	/* CXL Upstream Switch Port */
> +};
I would move this above the prot_err_agent_type_strs and use

[RCD] = "Restricted CXL Device". Saves on the trivial effort
for a reviewer of checking the two match up.
Probably don't need the comments on the enum as well as the
strings that say the same thing...

> +
> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
> +{
> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
> +		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
> +			prot_err->agent_type < ARRAY_SIZE(prot_err_agent_type_strs)
> +			? prot_err_agent_type_strs[prot_err->agent_type]
> +			: "unknown");
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS) {
> +		switch (prot_err->agent_type) {
> +		/*
> +		 * According to UEFI 2.10 Section N.2.13, the term CXL Device
> +		 * is used to refer to Restricted CXL Device, CXL Device, CXL
> +		 * Logical Device or a CXL Fabric Manager Managed Logical
> +		 * Device.
> +		 */
> +		case RCD:
> +		case DEVICE:
> +		case LD:
> +		case FMLD:
> +		case RP:
> +		case DSP:
> +		case USP:
> +			pr_info("%s agent_address: %04x:%02x:%02x.%x\n",
> +				pfx, prot_err->agent_addr.segment,
> +				prot_err->agent_addr.bus,
> +				prot_err->agent_addr.device,
> +				prot_err->agent_addr.function);
> +			break;
> +		case RCH_DP:
> +			pr_info("%s rcrb_base_address: 0x%016llx\n", pfx,
> +				prot_err->agent_addr.rcrb_base_addr);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID) {
> +		const __u8 *class_code;
> +
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +		case DEVICE:
> +		case LD:
> +		case FMLD:
> +		case RP:
> +		case DSP:
> +		case USP:
> +			pr_info("%s slot: %d\n", pfx,
> +				prot_err->device_id.slot >> CPER_PCIE_SLOT_SHIFT);

Probably not in keeping with other CPER handling (because that's all ancient) but
I'm a great fan of FIELD_GET() and masks for cases like this.
I this particular case the slot field goes all they way to bit 15 so there
are no reserved bits up there, but I had to go check that which a FIELD_GET()/ mask
approach would have saved me doing. 

> +			pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n",
> +				pfx, prot_err->device_id.vendor_id,
> +				prot_err->device_id.device_id);
> +			pr_info("%s sub_vendor_id: 0x%04x, sub_device_id: 0x%04x\n",
> +				pfx, prot_err->device_id.subsystem_vendor_id,
> +				prot_err->device_id.subsystem_id);
> +			class_code = prot_err->device_id.class_code;
> +			pr_info("%s class_code: %02x%02x\n", pfx,
> +				class_code[1], class_code[0]);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +		case DEVICE:
> +		case LD:
> +		case FMLD:
> +			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
> +				prot_err->dev_serial_num.lower_dw,
> +				prot_err->dev_serial_num.upper_dw);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_CAPABILITY) {
> +		switch (prot_err->agent_type) {
> +		case RCD:
> +		case DEVICE:
> +		case LD:
> +		case FMLD:
> +		case RP:
> +		case DSP:
> +		case USP:
> +			print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4,
> +				       prot_err->capability,
> +				       sizeof(prot_err->capability), 0);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_DVSEC) {
> +		pr_info("%s DVSEC length: 0x%04x\n", pfx, prot_err->dvsec_len);
> +
> +		pr_info("%s CXL DVSEC:\n", pfx);
> +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),

Excess brackets?

> +			       prot_err->dvsec_len, 0);
> +	}
> +}
> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
> new file mode 100644
> index 000000000000..86bfcf7909ec
> --- /dev/null
> +++ b/drivers/firmware/efi/cper_cxl.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UEFI Common Platform Error Record (CPER) support for CXL Section.
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#ifndef LINUX_CPER_CXL_H
> +#define LINUX_CPER_CXL_H
> +
> +/* CXL Protocol Error Section */
> +#define CPER_SEC_CXL_PROT_ERR						\
> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
> +		  0x4B, 0x77, 0x10, 0x48)
> +
> +#pragma pack(1)
> +
> +/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
> +struct cper_sec_prot_err {
> +	u64 valid_bits;
> +	u8 agent_type;
> +	u8 reserved[7];
> +
> +	/*
> +	 * Except for RCH Downstream Port, all the remaining CXL Agent
> +	 * types are uniquely identified by the PCIe compatible SBDF number.
> +	 */
> +	union {
> +		u64 rcrb_base_addr;
> +		struct {
> +			u8 function;
> +			u8 device;
> +			u8 bus;
> +			u16 segment;
> +			u8 reserved_1[3];
> +		};
> +	} agent_addr;
> +
> +	struct {
> +		u16 vendor_id;
> +		u16 device_id;
> +		u16 subsystem_vendor_id;
> +		u16 subsystem_id;
> +		u8 class_code[2];
> +		u16 slot;
> +		u8 reserved_1[4];
> +	} device_id;
> +
> +	struct {
> +		u32 lower_dw;
> +		u32 upper_dw;
> +	} dev_serial_num;
> +
> +	u8 capability[60];
> +	u16 dvsec_len;
> +	u16 err_len;
> +	u8 reserved_2[4];
> +};
> +
> +#pragma pack()
> +
> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
> +
> +#endif //__CPER_CXL_

