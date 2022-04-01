Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03834EE7B4
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 07:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiDAFRV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiDAFRU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 01:17:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C5261304;
        Thu, 31 Mar 2022 22:15:31 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2314gsKV028760;
        Fri, 1 Apr 2022 05:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xzugCTuDJ0DLdgI8DOvKnnfZwyRwVxfvDJEJohli1d4=;
 b=YMMaguZdGAmNKLxNmLs8aFbS9wEvvwd8SEsuHhU3DTUQnYxEYXDprwFgjibt5XDTVAz+
 o1pyOlCcIibSwQAI7o2CnClE8IRFWbzldFNDyIfX6ZfahThwq0PRXi+mZOSzi7mcKJdk
 aUE16mMYTa1GmMf633dP+ejh7WnkA1NuflGqlum9XOzetJ/xWOAbp6rmi445NIWgDC33
 /lQXlzTgJ31uw9ev9uChngZI1iCjLpNFZ+f1yek8cPG6nW0IMKUs4sp9wVMyE6cXf0FO
 brP4R4+CNJhCx8Q0Rzce26qIi7XpHOnt/SaQGt3mfYOc9MDEUb9aVT1dpdXD/Tw6Cfe0 PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f51hw70uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:15:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2314tD79032212;
        Fri, 1 Apr 2022 05:15:12 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f51hw70u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:15:11 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2315E71K021074;
        Fri, 1 Apr 2022 05:15:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3f1tfaa2yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 05:15:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2315F9sh26476990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 05:15:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9317A112064;
        Fri,  1 Apr 2022 05:15:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EA3A11206F;
        Fri,  1 Apr 2022 05:15:05 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 05:15:04 +0000 (GMT)
Message-ID: <3b590f05-ff48-8cad-8e2d-e4ea339daf9c@linux.ibm.com>
Date:   Fri, 1 Apr 2022 08:15:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 3/4] efi: Register efi_secret platform device if EFI
 secret area is declared
Content-Language: en-US
To:     linux-efi@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220331215607.3182232-1-dovmurik@linux.ibm.com>
 <20220331215607.3182232-4-dovmurik@linux.ibm.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220331215607.3182232-4-dovmurik@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7SLh08xS3MLEo0C0hEY3XB2npW34po2y
X-Proofpoint-ORIG-GUID: dZv0h6uPCKdzaMmc1D9kK-AMpfghoIQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010022
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 01/04/2022 0:56, Dov Murik wrote:
> During efi initialization, check if coco_secret is defined in the EFI
> configuration table; in such case, register platform device
> "efi_secret".  This allows udev to automatically load the efi_secret
> module (platform driver), which in turn will populate the
> <securityfs>/secrets/coco directory in guests into which secrets were
> injected.
> 
> Note that a declared address of an EFI secret area doesn't mean that
> secrets where indeed injected to that area; if the secret area is not
> populated, the driver will not load (but the platform device will still
> be registered).
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  drivers/firmware/efi/efi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 378d044b2463..b92eabc554e6 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -425,6 +425,9 @@ static int __init efisubsys_init(void)
>  	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
>  		efi_debugfs_init();
>  
> +	if (efi.coco_secret != EFI_INVALID_TABLE_ADDR)
> +		platform_device_register_simple("efi_secret", 0, NULL, 0);

These two lines should be wrapped by #ifdef CONFIG_EFI_COCO_SECRET .
I'll fix that for the next round.

-Dov

> +
>  	return 0;
>  
>  err_remove_group:
