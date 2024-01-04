Return-Path: <linux-efi+bounces-329-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB961824144
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FD28405A
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6112111A;
	Thu,  4 Jan 2024 12:06:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122121364;
	Thu,  4 Jan 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T5QGm0rYjz6K8wb;
	Thu,  4 Jan 2024 20:03:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 18B4F140A86;
	Thu,  4 Jan 2024 20:06:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 12:06:10 +0000
Date: Thu, 4 Jan 2024 12:06:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Ben Widawsky
	<bwidawsk@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
Message-ID: <20240104120609.00005ebd@Huawei.com>
In-Reply-To: <20221028200950.67505-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
	<20221028200950.67505-2-Smita.KoralahalliChannabasappa@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

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

Obviously very late with this comment, but I now have a test setup running
so a minor formatting issue became apparent that would be nice to tidy up
I think.

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

Doesn't say what it is the lower dw of.  Good to add a mention of serial number.


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
No heading for this.  Which means the output just ends up with something like:

    lower_dw: 0x00000004, upper_dw = 0x00000000
   00000000: 00020010 00008000 0000000f 00000411
   00000010: 00110000 00000000 00000000 00000000

etc  So also wants a space before the hex dump or indeed greater indent once that's
added.

Similar formatting things apply to later changes to the message such as the header
log register in the next patch.

Whilst not a bug as such, pretty printing is always nice :)

Jonathan


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


