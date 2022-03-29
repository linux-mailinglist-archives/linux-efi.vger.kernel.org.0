Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAFA4EB4B4
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiC2Ua6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2Ua5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 16:30:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717A231229;
        Tue, 29 Mar 2022 13:29:13 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TJbjs6012612;
        Tue, 29 Mar 2022 20:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RtpygqGfs5OGAozMDI4lFQBuJtECTlK2JppjdTXC0OA=;
 b=I+pOmgGjBWbPwZeizBHesRHCf59i53k6k8vZsXCPCxTL/HDkrj531domu2XntGZgsWSD
 6XOflbHVyz1hxjehHurWqozr9g9A5Wo71Qd4FKPeSNs+BUKv7bjQxtV6o2sG7vW7dTfA
 jeBLFYcVepjmV6EGAQUDLguEFqzkK52mmtMk/bIB4nGOk6S367+7UdIVNjN+sOglT9iN
 gm3U/LCUaOEv+KIVlnkbI0KUzof+av4cO5n/pgwhYOYoi/rkwvsk3s4A++rcGbRLmXkF
 nwdpYXIyeyw3r0VNHptJlP23GCUkGBxxZJtwwtupz1YnUCTWitVK8fmo9UyTDRDx+mhG hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f409rvvu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 20:28:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22TKQMxt025808;
        Tue, 29 Mar 2022 20:28:54 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f409rvvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 20:28:54 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22TKNNmQ000755;
        Tue, 29 Mar 2022 20:28:53 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3f1tf9vsb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 20:28:53 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22TKSqYt56885704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:28:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B6B1112061;
        Tue, 29 Mar 2022 20:28:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A61112063;
        Tue, 29 Mar 2022 20:28:48 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Mar 2022 20:28:47 +0000 (GMT)
Message-ID: <7696ba46-91c7-7119-bd68-b3521459cf37@linux.ibm.com>
Date:   Tue, 29 Mar 2022 23:28:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 0/4] Allow guest access to EFI confidential computing
 secret area
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
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
References: <20220228114254.1099945-1-dovmurik@linux.ibm.com>
 <YjydSNnG6EJ1KWx0@zn.tnic>
 <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
 <YkNQNzNa02Sndu+q@zn.tnic>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YkNQNzNa02Sndu+q@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: faAw94u_RZeNLLhUORJVBKERuDDuG3NZ
X-Proofpoint-ORIG-GUID: 5pIjdB5JlrxwcElAbLVLY6fDYwE_hTUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_08,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 29/03/2022 21:30, Borislav Petkov wrote:

> 
> So now that I think of it, it would be even nicer if the fact whether
> guest debugging is allowed, were available to the guest *very early*
> during boot. Because I think the most important cases where you'd want
> to singlestep a SEV* guest with the qemu gdbstub is early guest kernel
> boot code. So it would be cool if we'd have access to the debugging
> setting that early.
> 
> Lemme have a look at your patches in detail to get an idea what's
> happening there.

Is efi_config_parse_tables() early enough?  That's where we learn for
the first time that the firmware has a launch-secrets area that we can
look at.

We can add there (say, next to the call to efi_tpm_eventlog_init()) a
code to:

1. map the secret area (ioremap_encrypted())
2. parse the table, look for the "sev debug enabled" GUID.
3. set the value of the kernel variable that we can later use anywhere.


Of course Ard might know about a better mechanism or place to do that.


-Dov
