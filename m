Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC34A6FB3
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 12:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiBBLOU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 06:14:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229667AbiBBLOU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 06:14:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212B44ph032379;
        Wed, 2 Feb 2022 11:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5lQDaG9EdKlRA9jkh47xSZs6ypUAV9t1nCGeUqGMcKw=;
 b=pYzDZ/fJ2nujrTLp2vUgJuXcP4A7pjFGLffAwsZKLEku/7iLKWuPam7zKzMn9ZLJcctM
 NlWbQvRhJ2P5KYcL9Y4rRkAV2XSYXcS52pjDKCry/mIlTAffJ1pguIiemVta5kXvCBdx
 jLWOIAypnzQps5Ho5LlBqiBKc77GLadJQzfDCeRRHq0h03rF/8m1UQ3QtQyDvSVldg4Y
 /uP1yC4tLJuRvnge5AlmYbbeXE9lxTnQwtydXrWtbUV3DJgYsYdWd0bo7ABsdRVl2JYu
 5cJeg8NKH4rpiRaiFm1+TweoR1DswG48cf+WYXjbEJLpwocgmtve6Nio6ocjppTkxsAe AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dynuakrr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:13:58 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2129vNAM014702;
        Wed, 2 Feb 2022 11:13:57 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dynuakrqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:13:57 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212B8iKO005434;
        Wed, 2 Feb 2022 11:13:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7c3rj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 11:13:56 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212BDs4B8847910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 11:13:54 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB4F528058;
        Wed,  2 Feb 2022 11:13:54 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8776128059;
        Wed,  2 Feb 2022 11:13:50 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 11:13:50 +0000 (GMT)
Message-ID: <7daea93d-4b35-b98c-af11-afc6c74de4c7@linux.ibm.com>
Date:   Wed, 2 Feb 2022 13:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 2/5] efi/libstub: Reserve confidential computing secret
 area
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
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
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-3-dovmurik@linux.ibm.com>
 <20220202084104.zkhnclpxigct4tf6@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220202084104.zkhnclpxigct4tf6@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q47oDXObYtIOMU7GW9lW5VwVzYwzpoIm
X-Proofpoint-GUID: zMrqZQQrQJbQYNVlr-c_dAvHVonlrwtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_05,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020059
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/02/2022 10:41, Gerd Hoffmann wrote:
> On Tue, Feb 01, 2022 at 12:44:10PM +0000, Dov Murik wrote:
>> Some older firmware declare the confidential computing secret area as
>> EFI_BOOT_SERVICES_DATA region.  Fix this up by treating this memory
>> region as EFI_RESERVED_TYPE, as it should be.
>>
>> If that memory region is already EFI_RESERVED_TYPE then this has no
>> effect on the E820 map.
> 
> Hmm, sure we actually want merge this?  I suspect by the time this
> landed in an upstream kernel "older firmware" isn't much of a problem
> any more.
> 

When we originally wrote this patch the OVMF fix was not yet upstream
(and currently it is still not part of an official edk2 stable tag/release).

But I agree that as time goes by, the need for this fix is diminishing.

I'll consider dropping this patch entirely in the next round.

Thanks,
-Dov
