Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F189757
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfHLGv7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 02:51:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfHLGv6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Aug 2019 02:51:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5D421518EAA4334DA815;
        Mon, 12 Aug 2019 14:51:54 +0800 (CST)
Received: from [127.0.0.1] (10.74.184.86) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 14:51:50 +0800
Subject: Re: [PATCH v2 1/1] efi: cper: print AER info of PCIe fatal error
To:     <linux-kernel@vger.kernel.org>
References: <1564105417-232048-1-git-send-email-tanxiaofei@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <ying.huang@intel.com>,
        <ross.lagerwall@citrix.com>, <ard.biesheuvel@linaro.org>,
        <james.morse@arm.com>
From:   tanxiaofei <tanxiaofei@huawei.com>
Message-ID: <5D510C86.5040000@huawei.com>
Date:   Mon, 12 Aug 2019 14:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1564105417-232048-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.184.86]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


ping...

On 2019/7/26 9:43, Xiaofei Tan wrote:
> AER info of PCIe fatal error is not printed in the current driver.
> Because APEI driver will panic directly for fatal error, and can't
> run to the place of printing AER info.
> 
> An example log is as following:
> {763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
> {763}[Hardware Error]: event severity: fatal
> {763}[Hardware Error]:  Error 0, type: fatal
> {763}[Hardware Error]:   section_type: PCIe error
> {763}[Hardware Error]:   port_type: 0, PCIe end point
> {763}[Hardware Error]:   version: 4.0
> {763}[Hardware Error]:   command: 0x0000, status: 0x0010
> {763}[Hardware Error]:   device_id: 0000:82:00.0
> {763}[Hardware Error]:   slot: 0
> {763}[Hardware Error]:   secondary_bus: 0x00
> {763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
> {763}[Hardware Error]:   class_code: 000002
> Kernel panic - not syncing: Fatal hardware error!
> 
> This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
> cper_print_aer() call out of interrupt context")'. To fix this issue,
> this patch adds print of AER info in cper_print_pcie() for fatal error.
> 
> Here is the example log after this patch applied:
> {24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
> {24}[Hardware Error]: event severity: fatal
> {24}[Hardware Error]:  Error 0, type: fatal
> {24}[Hardware Error]:   section_type: PCIe error
> {24}[Hardware Error]:   port_type: 0, PCIe end point
> {24}[Hardware Error]:   version: 4.0
> {24}[Hardware Error]:   command: 0x0546, status: 0x4010
> {24}[Hardware Error]:   device_id: 0000:01:00.0
> {24}[Hardware Error]:   slot: 0
> {24}[Hardware Error]:   secondary_bus: 0x00
> {24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
> {24}[Hardware Error]:   class_code: 000002
> {24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
> {24}[Hardware Error]:   aer_uncor_severity: 0x00062010
> {24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
> Kernel panic - not syncing: Fatal hardware error!
> 
> Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of interrupt context")
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/firmware/efi/cper.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 8fa977c..78b8922 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -390,6 +390,21 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>  		printk(
>  	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
>  	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
> +
> +	/* Fatal errors call __ghes_panic() before AER handler prints this */
> +	if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO &&
> +	    gdata->error_severity & CPER_SEV_FATAL) {
> +		struct aer_capability_regs *aer;
> +
> +		aer = (struct aer_capability_regs *)pcie->aer_info;
> +		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
> +		       pfx, aer->uncor_status, aer->uncor_mask);
> +		printk("%saer_uncor_severity: 0x%08x\n",
> +		       pfx, aer->uncor_severity);
> +		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
> +		       aer->header_log.dw0, aer->header_log.dw1,
> +		       aer->header_log.dw2, aer->header_log.dw3);
> +	}
>  }
>  
>  static void cper_print_tstamp(const char *pfx,
> 

-- 
 thanks
tanxiaofei

