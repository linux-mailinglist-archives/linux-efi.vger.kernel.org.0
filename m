Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B324EADFE
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiC2M6s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiC2M6A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 08:58:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B85FE8;
        Tue, 29 Mar 2022 05:56:16 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TAuZXs003538;
        Tue, 29 Mar 2022 12:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K8srbVD97aBzbFKQRRvFsxZKalyJdMdPYve7feegeqo=;
 b=gED/f7sP3QkJCr3Ag5xybc5apnsX3GY9yyAp3GUrsKtPekBnVghBcQeZqM7lsL+aypyY
 KCDCSjs/7teRCQdas8JNKZPywykPzXxMHkx99Jnsp5j68tzKGdXe/lMCBMkvOZGgmlPd
 omP0zaNP18eVEitO2uxuL8QltArnteXltkhEeuvEI4Jz7Wo+hNk2DNFw6kjOswv/QAoV
 tsc0CSEKIRhzhs8vRYdsCtBeq92Aq+JvCm1Pym8W185sVISTLFpEQJoBIHh4j3yhjFN3
 gm4uUlnJ3WRRY++iQb+skqwmUapajANRP5B8fkwTw5/X/bX2XLHu9Lf3eyym0zlWpxKb sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40t82hjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 12:55:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22TBeHcF005691;
        Tue, 29 Mar 2022 12:55:47 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40t82hj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 12:55:47 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22TCrTcR025140;
        Tue, 29 Mar 2022 12:55:46 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3f1tf9snbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 12:55:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22TCtj6S26739196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 12:55:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2A6112067;
        Tue, 29 Mar 2022 12:55:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA13112063;
        Tue, 29 Mar 2022 12:55:40 +0000 (GMT)
Received: from [9.160.79.229] (unknown [9.160.79.229])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Mar 2022 12:55:40 +0000 (GMT)
Message-ID: <f2fb7553-0313-6393-c93c-2bb6619086dc@linux.ibm.com>
Date:   Tue, 29 Mar 2022 15:55:38 +0300
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
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <YjydSNnG6EJ1KWx0@zn.tnic>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yr3QtwC9c6b71TvjRjZOXB9MPeM1WEI4
X-Proofpoint-GUID: hXEZmmRtRw7JWMAZA1Jxsy53t_CFW_xT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_04,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Boris,

On 24/03/2022 18:33, Borislav Petkov wrote:
> On Mon, Feb 28, 2022 at 11:42:50AM +0000, Dov Murik wrote:
>> Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
>> Virtualization) allows guest owners to inject secrets into the VMs
>> memory without the host/hypervisor being able to read them.  In SEV,
>> secret injection is performed early in the VM launch process, before the
>> guest starts running.
>>
>> OVMF already reserves designated area for secret injection (in its
>> AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
>> Sev Secret area using a configuration table" [1]), but the secrets were
>> not available in the guest kernel.
>>
>> The patch series keeps the address of the EFI-provided memory for
>> injected secrets, and exposes the secrets to userspace via securityfs
>> using a new efi_secret kernel module.  The module is autoloaded (by the
>> EFI driver) if the secret area is populated.
> 
> Right, so this thing.
> 
> Tom and I were talking about SEV* guest debugging today and I believe
> there might be another use case for this: SEV-ES guests cannot find out
> from an attestation report - like SNP guests can - whether they're being
> debugged or not so it would be very helpful if the fact that a -ES guest
> is being debugged, could be supplied through such a secrets blob.
> 
> Because then, when I'm singlestepping the guest with gdb over the
> gdbstub, the guest could determine based on those guest-owner previously
> injected secrets whether it should allow debugging or not.
> 

Let's see if I understand this correctly:

You want the guest to know if the its own SEV VM policy allows
debugging.  And that flag has to be trusted -- so passed from the Guest
Owner in a secure channel (otherwise the host could set it to
ALLOW_DEBUGGING even though the Guest Owner didn't approve that).



> And this is where your set comes in.
> 
> However, I'm wondering if - instead of defining your own secrets structs
> etc - you could use the SNP confidential computing blob machinery the
> SNP set is adding. In particular:
> 
> https://lore.kernel.org/all/20220307213356.2797205-30-brijesh.singh@amd.com/
> 
> And you're adding another GUID but maybe you could simply use the SNP
> thing called EFI_CC_BLOB_GUID and mimick that layout.
> 
> That should unify things more. And then guest kernel code could query
> the blob also for debugging policy and so on.
>

Maybe you could do that, but that will unify things that are not the
same, so I think it is the wrong approach here.

The SNP secrets are secrets generated by the AMD-SP and allow the guest
to communicate with the PSP.  There are exactly 4 of them (if I remember
correctly) and they are only AES-256-GCM keys (if I remember correctly).

On the other hand, the SEV launch secrets (which this series is about)
are secrets populated by the Guest Owner and are intended for the proper
operation of the applications in the guest (example use cases: luks
passphrase, secret API keys, file decryption keys, encrypted container
images keys, ...).

The SEV launch secrets area can also be read by grub [1], for example,
to fetch a luks passphrase from there (instead of from keyboard).
That's why its structure is generic.

[1] https://lists.gnu.org/archive/html/grub-devel/2022-02/msg00066.html


> Thoughts, opinions?
> 

I think Guest Owner can add a 1-byte predefined secret to the SEV secret
table, let's say an entry with GUID 2b91a212-b0e1-4816-b021-1e9991ddb6af
and value "\x01" to indicate debugging is allowed.

With the efi_secrets module, a 1-byte file called
/sys/kernel/security/secrets/coco/2b91a212-b0e1-4816-b021-1e9991ddb6af
will appear with "\x01" in its content.

This can indicate to the guest that debugging was permitted by the Guest
Owner.

If you want this unified in the kernel, maybe we can look for this entry
and set the relevant kernel variable.

-Dov
