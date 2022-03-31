Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817954ED675
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiCaJHI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiCaJHH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 05:07:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA8C1E;
        Thu, 31 Mar 2022 02:05:20 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V7Q8Hp021363;
        Thu, 31 Mar 2022 09:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ckSmIxNCjYFQIGbXFthpHgQOTV2iLuP1NhT+3ICfHxs=;
 b=hyHZZdBQKAbK4xwaO6avP0oOuceP7Lvc/LKG2xUt/M2t07G0Tju+pxizcggB6VRtD48y
 q8VRN5itB3QWwGibd33phGqpLFctfW1pJBjL3v0CFFpvWAuzCED8mCW2IoVV5aRR2yda
 FBdpsbOVp23c1y6iCknKT+qS/TYCoUEnPWjZDLhPrvK9q9Y/gf8Z16mFL9nO1Q5F6oCL
 i5X8s35dl/On0AWkDBpK3xiPx3MkFY1W6mq6aKYGalEV5N6yxOGUKADZa5/oXomKXPSc
 fb1IRQ5FBsBg7bSUYqqPKXOPreZ+DRv3fFvJo/ZX0S8kG32dB2Y9j1wW5QJGyHEk7QER hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f57wj1xky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:04:49 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22V80BDq009890;
        Thu, 31 Mar 2022 09:04:49 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f57wj1xkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:04:49 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22V93gls021669;
        Thu, 31 Mar 2022 09:04:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3f1tfac4u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:04:48 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22V94l6Q7406438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:04:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B5C0112065;
        Thu, 31 Mar 2022 09:04:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41997112063;
        Thu, 31 Mar 2022 09:04:42 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 09:04:41 +0000 (GMT)
Message-ID: <38daffb6-a72a-87f4-d927-0b857b7b6833@linux.ibm.com>
Date:   Thu, 31 Mar 2022 12:04:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 3/4] efi: Load efi_secret module if EFI secret area is
 populated
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <20220228114254.1099945-4-dovmurik@linux.ibm.com>
 <CAMj1kXFybkGtxH2U6oAi_Qeqe-i_kH-hZjUZKY3-UzPHUg55vg@mail.gmail.com>
 <f3de6cd9-9f58-7db3-e367-a6a5a5d826e2@linux.ibm.com>
 <CAMj1kXEKh-Ve3iPDnNTxi10=hcARN4ntpyQOrmb=B+4DpC24vQ@mail.gmail.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <CAMj1kXEKh-Ve3iPDnNTxi10=hcARN4ntpyQOrmb=B+4DpC24vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qpD6gjZEeh4GmRrc1ZJLUnn8972oc_Us
X-Proofpoint-ORIG-GUID: S7H5SGOfUR6vVATNH_SdrDmES15vFakc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_03,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

On 28/02/2022 15:15, Ard Biesheuvel wrote:
> On Mon, 28 Feb 2022 at 14:07, Dov Murik <dovmurik@linux.ibm.com> wrote:
>>
>>
>>
>> On 28/02/2022 14:49, Ard Biesheuvel wrote:
>>> On Mon, 28 Feb 2022 at 12:43, Dov Murik <dovmurik@linux.ibm.com> wrote:
>>>>
>>>> If the efi_secret module is built, register a late_initcall in the EFI
>>>> driver which checks whether the EFI secret area is available and
>>>> populated, and then requests to load the efi_secret module.
>>>>
>>>> This will cause the <securityfs>/secrets/coco directory to appear in
>>>> guests into which secrets were injected; in other cases, the module is
>>>> not loaded.
>>>>
>>>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>>
>>> It would be better to simply expose a platform device and associated
>>> driver, instead of hooking into the module machinery directly.
>>>
>>> We already do something similar for the EFI rtc and the efivars
>>> subsystem, using platform_device_register_simple()
>>>
>>
>> Thanks Ard, I'll look into this.
>>
>> I hope the mechanism you suggest allows me to perform complex check to
>> see if the device is really there (in this case: check for an efi
>> variable, map memory as encrypted, verify it starts with a specific GUID
>> -- everything before request_module() in the code below).
>>
> 
> There is the device part and the driver part. Some of this belongs in
> the core code that registers the platform device, and some of it
> belongs in the driver. At this point, it probably does not matter that
> much which side does what, as the platform driver simply probes and
> can perform whatever check it needs, as long as it can back out
> gracefully (although I understand that, in this particular case, there
> are reasons why the driver may decide to wipe the secret)

I finally got to implement this, it seems like it makes the code simple.
Thanks for the advice.

Just making sure I understand correctly: in this approach this we rely
on udev to load the efi_secret module (aliased as "platform:efi_secret")
and call its .probe() function?  If there's no udev, the module will not
be loaded automatically.  Did I understand that correctly?


In such a case, the only thing needed to add in efi.c is:


diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 378d044b2463..b92eabc554e6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -425,6 +425,9 @@ static int __init efisubsys_init(void)
        if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
                efi_debugfs_init();

+       if (efi.coco_secret != EFI_INVALID_TABLE_ADDR)
+               platform_device_register_simple("efi_secret", 0, NULL, 0);
+
        return 0;

 err_remove_group:



Does this seem OK? (before I re-spin the whole series.)

Thanks,
-Dov
