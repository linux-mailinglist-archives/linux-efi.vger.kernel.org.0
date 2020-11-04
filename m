Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018762A7345
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgKDXyH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 18:54:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58830 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbgKDXyG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 18:54:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NnYdo153877;
        Wed, 4 Nov 2020 23:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1iFWj4I945Pa9pfTckxa4OLou5zq0/cCG5xj+n3yHlI=;
 b=VC3YXaB/cSjDL/Aqi4lr0E0dsWAqWZzsiCYkyWm8NKkZXqA3B+ROoH3LRdbnHm3zJ0ub
 lMR+Ctcqr1GCe++HlChadwbJPjzykF5ziruZ4old6PNMfM+SPpFHYVHfJImS9uc+MkUi
 n7ip4uSGXGUuWq1Ilz/wrkHSYtSxwmAnupCqAzxN2jEVsHsdIgFUUOdlSuvKZXMxPlUq
 Er1c1ujg2l8iP/qXHWPHMYPoa2zbXpuYSQrbV7qN0OTPHp2gm9YSU0HSsA+289ruPznT
 jYh0Jdcw5B7w0Aa2mvhTgpN2HHokxHiziXOEnZjpkGBxhR/Ue7kYfPs2Sa2klC3EzWps rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2sfa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 23:53:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4NnnBx113233;
        Wed, 4 Nov 2020 23:53:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvrynkur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 23:53:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4NrpdL002452;
        Wed, 4 Nov 2020 23:53:53 GMT
Received: from [10.74.103.113] (/10.74.103.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 15:53:51 -0800
Subject: Re: [PATCH] efi: x86/xen: switch to efi_get_secureboot_mode helper
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, sstabellini@kernel.org,
        jgross@suse.com
References: <20201104221400.7005-1-ardb@kernel.org>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <f3d902ca-3fa2-aa8a-fb9a-0891b9567751@oracle.com>
Date:   Wed, 4 Nov 2020 18:53:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104221400.7005-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040171
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 11/4/20 5:14 PM, Ard Biesheuvel wrote:
> Now that we have a static inline helper to discover the platform's secure
> boot mode that can be shared between the EFI stub and the kernel proper,
> switch to it, and drop some comments about keeping them in sync manually.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/xen/efi.c                        | 37 +++++---------------
>  drivers/firmware/efi/libstub/secureboot.c |  3 --
>  2 files changed, 9 insertions(+), 31 deletions(-)
>
> diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> index 205a9bc981b0..a27444acaf1e 100644
> --- a/arch/x86/xen/efi.c
> +++ b/arch/x86/xen/efi.c
> @@ -93,37 +93,22 @@ static efi_system_table_t __init *xen_efi_probe(void)
>  
>  /*
>   * Determine whether we're in secure boot mode.
> - *
> - * Please keep the logic in sync with
> - * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
>   */
>  static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>  {
> -	static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
>  	static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
> +	enum efi_secureboot_mode mode;
>  	efi_status_t status;
> -	u8 moksbstate, secboot, setupmode;
> +	u8 moksbstate;
>  	unsigned long size;
>  
> -	size = sizeof(secboot);
> -	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> -				  NULL, &size, &secboot);
> -
> -	if (status == EFI_NOT_FOUND)
> -		return efi_secureboot_mode_disabled;
> -
> -	if (status != EFI_SUCCESS)
> -		goto out_efi_err;
> -
> -	size = sizeof(setupmode);
> -	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
> -				  NULL, &size, &setupmode);
> -
> -	if (status != EFI_SUCCESS)
> -		goto out_efi_err;
> -
> -	if (secboot == 0 || setupmode == 1)
> -		return efi_secureboot_mode_disabled;
> +	mode = efi_get_secureboot_mode(efi.get_variable);


Which tree is this patch against? I don't see a definition of efi_get_secureboot_mode().


> +	if (mode == efi_secureboot_mode_unknown) {
> +		efi_err("Could not determine UEFI Secure Boot status.\n");


We need to include drivers/firmware/efi/libstub/efistub.h for that. Which I am not sure is meant to be included anywhere outside of libstub.


-boris


