Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9F4EE30B
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbiCaVH4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 17:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbiCaVHr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 17:07:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4F2128C4;
        Thu, 31 Mar 2022 14:05:57 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VI9Lpd016650;
        Thu, 31 Mar 2022 21:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ljfngnAvNHoR2uZIcgbQosSticCbmJRTWA+WtGqL89M=;
 b=Y83tO+H2J1cQcr+zqzTh27+6htAl+sWVdVG9K48VbKWxgmQIDcbuk4pMEHz7s6Xlao1o
 O/ikSyZ66r62Dt0GHA6KgDdihvW+Znx8vlwPe/VREuyFEW1rz7QtU260ZQggohhEtTSx
 cdcHTig9ml4RCLVlLRH1fyCYOPS5GvYBjaQWC2YpGfqtjo9RdbmoIW02CPY6B23JNqSh
 lxqMqTmb1w++Uo0Q4QFTS21xqMsaik9zjOJnReNTsjZ4CSUwcNvm+X0P656PnbNrkU4o
 0TdSy/NUCuZLu1jRhL9Hnwmhu48TJQrj1zM+VJU1yJPnuKOcbmpFAmpFACyyIntE+Xat uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f57rn0ugx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:05:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22VL0CUx020832;
        Thu, 31 Mar 2022 21:05:27 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f57rn0ugd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:05:27 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22VKw9ua022924;
        Thu, 31 Mar 2022 21:05:26 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3f1tfa7cqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 21:05:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22VL5PSJ18219286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:05:25 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73BF5112063;
        Thu, 31 Mar 2022 21:05:25 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7474A112061;
        Thu, 31 Mar 2022 21:05:20 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 21:05:20 +0000 (GMT)
Message-ID: <9e911444-0772-b3da-3e63-f5d49543c752@linux.ibm.com>
Date:   Fri, 1 Apr 2022 00:05:18 +0300
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
 <7696ba46-91c7-7119-bd68-b3521459cf37@linux.ibm.com>
 <247080bd-fef5-c892-7753-f9b7cf650166@linux.ibm.com>
 <YkVyIE8H4Ivb6J2l@zn.tnic>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YkVyIE8H4Ivb6J2l@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aDgjCc15v1AzUzef8ru-vr1pBBoWGYfE
X-Proofpoint-ORIG-GUID: 8rNkU0EGWLXxmPkK_DA2qPxqvRnBJRtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=841 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 31/03/2022 12:19, Borislav Petkov wrote:
> On Wed, Mar 30, 2022 at 09:11:54AM +0300, Dov Murik wrote:
>> If that's the case, we don't need a secure channel and secret injection.
>> You can use a simple "sev=debug" (or whatever) in the kernel
>> command-line to indicate your needs.
> 
> Yeah, that would work for a normal SEV guest.
> 
> However, if it is an -ES guest, you need to somehow tell it as the guest
> owner: "hey you're being debugged and that's fine."
> 
> Because if you want to singlestep the thing, you're going to land in
> the #VC handler and destroy registers so you want to save them first if
> you're being debugged and then shovel them out to the host somehow. And
> that's another question but first things first.
> 
> And "if you're being debugged" needs to be somehow told the guest
> through a secure channel so that the HV doesn't go and simply enable
> debugging by booting with "sev=debug" and bypass it all.
> 

Note that the HV can also start the VM with SEV completely turned off.
Similarly, it can enable debugging and "fool" the guest.  Of course all
this tricks will affect the measurement, and then the Guest Owner will
know that something is wrong and won't inject the secrets.  If you don't
rely on secret injection anyway, then I think a kernel command-line
param is good enough.  (I might be missing a scenario though)


Maybe you can use KVM_SEV_GET_ATTESTATION_REPORT (ask the host to do it
for you).  But I think it returns only the launch digest, and you can't
figure out the SEV Policy field from it.



> And SNP has access to the policy in the attestation report, says Tom, so
> that's possible there.

True. But not in really early boot? This is all in the sev-guest
platform driver.


> 
> So we need a way to add the debugging aspect to the measurement and be
> able to recreate that measurement quickly so that a simple debugging
> session of a kernel in a guest can work pretty much the same with a SEV*
> guest.
> 
> I'm still digging the details tho...
> 
