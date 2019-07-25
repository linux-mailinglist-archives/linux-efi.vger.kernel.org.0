Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741AF74E62
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2019 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfGYMoP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jul 2019 08:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:56502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfGYMoP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jul 2019 08:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACC728;
        Thu, 25 Jul 2019 05:44:14 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAE2E3F71F;
        Thu, 25 Jul 2019 05:44:12 -0700 (PDT)
Subject: Re: [PATCH 1/1] efi: cper: print AER info of PCIe fatal error
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, ying.huang@intel.com,
        ross.lagerwall@citrix.com, ard.biesheuvel@linaro.org,
        lance.ortiz@hp.com
References: <1562898017-27166-1-git-send-email-tanxiaofei@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e596aec8-1239-0a46-39cf-e682fada9945@arm.com>
Date:   Thu, 25 Jul 2019 13:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562898017-27166-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 12/07/2019 03:20, Xiaofei Tan wrote:
> AER info of PCIe fatal error is not printed in the current driver.
> Because APEI driver will panic directly for fatal error, and can't
> run to the place of printing AER info.
> 
> An example log is as following:
> [ 3157.655028] {763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
> [ 3157.663610] {763}[Hardware Error]: event severity: fatal
> [ 3157.663612] {763}[Hardware Error]:  Error 0, type: fatal
> [ 3157.663614] {763}[Hardware Error]:   section_type: PCIe error
> [ 3157.680328] {763}[Hardware Error]:   port_type: 0, PCIe end point
> [ 3157.680329] {763}[Hardware Error]:   version: 4.0
> [ 3157.680332] {763}[Hardware Error]:   command: 0x0000, status: 0x0010
> [ 3157.698757] {763}[Hardware Error]:   device_id: 0000:82:00.0
> [ 3157.698758] {763}[Hardware Error]:   slot: 0
> [ 3157.698759] {763}[Hardware Error]:   secondary_bus: 0x00
> [ 3157.698760] {763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
> [ 3157.698761] {763}[Hardware Error]:   class_code: 000002
> [ 3157.698825] Kernel panic - not syncing: Fatal hardware error!
> 
> This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
> cper_print_aer() call out of interrupt context")'. To fix this issue,
> this patch adds print of AER info in cper_print_pcie() for fatal error.
> 
> Here is the example log after this patch applied:
> [ 7032.893566] {24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
> [ 7032.901965] {24}[Hardware Error]: event severity: fatal
> [ 7032.907166] {24}[Hardware Error]:  Error 0, type: fatal
> [ 7032.912366] {24}[Hardware Error]:   section_type: PCIe error
> [ 7032.917998] {24}[Hardware Error]:   port_type: 0, PCIe end point
> [ 7032.923974] {24}[Hardware Error]:   version: 4.0
> [ 7032.928569] {24}[Hardware Error]:   command: 0x0546, status: 0x4010
> [ 7032.934806] {24}[Hardware Error]:   device_id: 0000:01:00.0
> [ 7032.940352] {24}[Hardware Error]:   slot: 0
> [ 7032.944514] {24}[Hardware Error]:   secondary_bus: 0x00
> [ 7032.949714] {24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
> [ 7032.956381] {24}[Hardware Error]:   class_code: 000002
> [ 7032.961495] {24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
> [ 7032.969891] {24}[Hardware Error]:   aer_uncor_severity: 0x00062010
> [ 7032.976042] {24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
> [ 7032.983663] Kernel panic - not syncing: Fatal hardware error!

> Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of
> interrupt context")

(Please put this all on one line)


> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 8fa977c..bf8600d 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -390,6 +390,19 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>  		printk(
>  	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
>  	pfx, pcie->bridge.secondary_status, pcie->bridge.control);

It may be worth a comment explaining why we only do this for fatal errors. Something like:
| /* Fatal errors call __ghes_panic() before the AER handler gets to print this */


> +	if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO &&
> +	    gdata->error_severity & CPER_SEV_FATAL) {
> +		struct aer_capability_regs *aer;
> +
> +		aer = (struct aer_capability_regs *)pcie->aer_info;
> +		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",

The convention in the rest of the file is for the prefix format string to be separate. i.e:
| "%s""aer_uncor_status: ..."

Could it be the same for consistency?

> +		       pfx, aer->uncor_status, aer->uncor_mask);
> +		printk("%saer_uncor_severity: 0x%08x\n",
> +		       pfx, aer->uncor_severity);
> +		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
> +		       aer->header_log.dw0, aer->header_log.dw1,
> +		       aer->header_log.dw2, aer->header_log.dw3);
> +	}
>  }

Regardless,
Reviewed-by; James Morse <james.morse@arm.com>


Thanks,

James
