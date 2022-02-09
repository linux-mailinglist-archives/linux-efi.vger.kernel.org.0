Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC54AE600
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 01:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiBIA0T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 19:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiBIA0T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 19:26:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26669C061576;
        Tue,  8 Feb 2022 16:26:18 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218MLA19005311;
        Wed, 9 Feb 2022 00:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZPFpO/s5Ar3lz1CQqNzWAhq5HebnCKhs9fdwrCFRj6s=;
 b=hERzfYX3x/vYEkbd/ZyZEqXst6fgk+SVLVesTOCIVEqpmZWEoSEcdqfXomlJh4B+xPS8
 Vzb0bOHE0SBboQVZKTqTASzVors0Vt8v5CfUlosnaSJvoWvTJSl4t+uZojOxKjGWoxRT
 of8RINXA2/rPj2lSar2yrGVEdry4/zssMABuduj8INl1Yxxoy7095qYfonNriO6lKfz7
 vRXYtG1cpVmnkfl72gA0/5mbjKMVCLo5Ps7KoEBMsW0bXAl410yxqhms9HWaQplEO69m
 QnbOogPtww0qN6SerGrt4sti7B8Gdv1fNeTXrGOtoG4GuYj+fD7RI2K8BL9FZcP1oKsA Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e4182j4x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 00:25:38 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2190PbTV002111;
        Wed, 9 Feb 2022 00:25:37 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e4182j4ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 00:25:36 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2190Nh8E026794;
        Wed, 9 Feb 2022 00:25:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3e1gvb7dfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 00:25:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2190PXUA35258666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 00:25:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB0BC605B;
        Wed,  9 Feb 2022 00:25:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB8CAC6059;
        Wed,  9 Feb 2022 00:25:31 +0000 (GMT)
Received: from [9.211.92.120] (unknown [9.211.92.120])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 00:25:31 +0000 (GMT)
Message-ID: <e0309177-123a-18b5-a5c1-3a9266a22de0@linux.vnet.ibm.com>
Date:   Tue, 8 Feb 2022 19:25:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>, dougmill@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@ibm.com,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org> <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org> <YfotMyQiQ66xfCOQ@kroah.com>
 <20220202071023.GA9489@srcf.ucam.org>
 <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
 <20220202080401.GA9861@srcf.ucam.org> <Yfo/5gYgb9Sv24YB@kroah.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <Yfo/5gYgb9Sv24YB@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b4UEhf1SnClyxzzgBwDvJSRo4uONgLbd
X-Proofpoint-GUID: QuzRJnKjQvfnEB4nqGFOkDHaX8mQ0no9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2/2/22 03:25, Greg KH wrote:
> On Wed, Feb 02, 2022 at 08:04:01AM +0000, Matthew Garrett wrote:
>> On Wed, Feb 02, 2022 at 08:22:03AM +0100, Ard Biesheuvel wrote:
>>> On Wed, 2 Feb 2022 at 08:10, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>>>> Which other examples are you thinking of? I think this conversation may
>>>> have accidentally become conflated with a different prior one and now
>>>> we're talking at cross purposes.
>>> This came up a while ago during review of one of the earlier revisions
>>> of this patch set.
>>>
>>> https://lore.kernel.org/linux-efi/YRZuIIVIzMfgjtEl@google.com/
>>>
>>> which describes another two variations on the theme, for pKVM guests
>>> as well as Android bare metal.
>> Oh, I see! That makes much more sense - sorry, I wasn't Cc:ed on that,
>> so thought this was related to the efivars/Power secure boot. My
>> apologies, sorry for the noise. In that case, given the apparent
>> agreement between the patch owners that a consistent interface would
>> work for them, I think I agree with Greg that we should strive for that.
>> Given the described behaviour of the Google implementation, it feels
>> like the semantics in this implementation would be sufficient for them
>> as well, but having confirmation of that would be helpful.
>>
>> On the other hand, I also agree that a new filesystem for this is
>> overkill. I did that for efivarfs and I think the primary lesson from
>> that is that people who aren't familiar with the vfs shouldn't be
>> writing filesystems. Securityfs seems entirely reasonable, and it's
>> consistent with other cases where we expose firmware-provided data
>> that's security relevant.
>>
>> The only thing I personally struggle with here is whether "coco" is the
>> best name for it, and whether there are reasonable use cases that
>> wouldn't be directly related to confidential computing (eg, if the
>> firmware on a bare-metal platform had a mechanism for exposing secrets
>> to the OS based on some specific platform security state, it would seem
>> reasonable to expose it via this mechanism but it may not be what we'd
>> normally think of as Confidential Computing).
>>
>> But I'd also say that while we only have one implementation currently
>> sending patches, it's fine for the code to live in that implementation
>> and then be abstracted out once we have another.
> Well right now the Android code looks the cleanest and should be about
> ready to be merged into my tree.
>
> But I can almost guarantee that that interface is not what anyone else
> wants to use, so if you think somehow that everyone else is going to
> want to deal with a char device node and a simple mmap, with a DT
> description of the thing, hey, I'm all for it :)
>
> Seriously, people need to come up with something sane or this is going
> to be a total mess.
>

Thanks for adding us to this discussion. I think somehow my last post 
got html content and didn't make to mailing list, so am posting it 
again. Sorry to those who are receiving it twice.

If I have understood the discussion right, the key idea discussed here 
is to unify multiple different interfaces(this one, and [1]) exposing 
secrets for confidential computing usecase via securityfs.

And the suggestion is to see if the proposed pseries interface [2] can 
unify with the coco interface.

At high level, pseries interface is reading/writing/adding/deleting 
variables using the sysfs interface, but the underlying semantics and 
actual usecases are quite different.

The variables exposed via pseries proposed interface are:

* Variables owned by firmware as read-only.
* Variables owned by bootloader as read-only.
* Variables owned by OS and get updated as signed updates. These support 
both read/write.
* Variables owned by OS and get directly updated(unsigned) eg config 
information or some boot variables. These support both read/write.

It can be extended to support variables which contain secrets like 
symmetric keys, are owned by OS and stored in platform keystore.

Naming convention wise also, there are differences like pseries 
variables do not use GUIDs.

The initial patchset discusses secure boot usecase, but it would be 
extended for other usecases as well.

First, I feel the purpose itself is different here. If we still 
continue, I fear if we will get into similar situation as Matthew 
mentioned in context of efivars -

"the patches to add support for
manipulating the Power secure boot keys originally attempted to make it
look like efivars, but the underlying firmware semantics are
sufficiently different that even exposing the same kernel interface
wouldn't be a sufficient abstraction and userland would still need to
behave differently. Exposing an interface that looks consistent but
isn't is arguably worse for userland than exposing explicitly distinct
interfaces."

With that, I believe the scope of pseries interface is different and 
much broader than being discussed here. So, I wonder if it would be 
better to still keep pseries interface separate from this and have its 
own platform specific interface.

I would be happy to hear the ideas.

[1] https://lore.kernel.org/linux-efi/YRZuIIVIzMfgjtEl@google.com/

[2] https://lore.kernel.org/all/20220122005637.28199-1-nayna@linux.ibm.com/

Thanks & Regards,

      - Nayna

