Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D848971F
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiAJLOz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 06:14:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244448AbiAJLOx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 06:14:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A8pdMl027013;
        Mon, 10 Jan 2022 11:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5m+2mfDDyh0TlLkCF2Fr+/g8FUjpntfEtGsUAUREgiU=;
 b=A31BwOezhZp9Xz2t2BZNKPI+dpH4hQpioYfoRMJ6G5OlW3FuqZfZEXO9kngyKq0wSODr
 weEEQu/Y1CpJ4f3+/HPrHi1Y0MAzjMwDDkfN3yzMENK8vhkPijM6WsZjSIQ6AkRwgndA
 1hKSGMYRN0HzS/m5GsPz9npArXcS6B+3NLul54ortSbfUhVNJ3E2r01dZYJ9n375oX8G
 vwpCDz9jmM8iE6aOdJXgNEF542oFaKWZJXSENPnvT6djGnB+uBGKcgsx9r8ROLTM/MKK
 YHpaXAIBpfbUgqFBmyuwQI95T8f5+87WyAMdfY/cqNS1MQ9m9Px2vVqgClUm738FJZV9 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3vg3ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 11:14:26 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20AB9vIZ025950;
        Mon, 10 Jan 2022 11:14:25 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3vg3y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 11:14:25 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20AB7gpK026886;
        Mon, 10 Jan 2022 11:14:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 3df289grw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 11:14:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20ABENwx33554938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 11:14:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07AA3C606C;
        Mon, 10 Jan 2022 11:14:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB54FC6061;
        Mon, 10 Jan 2022 11:14:17 +0000 (GMT)
Received: from [9.65.224.158] (unknown [9.65.224.158])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 11:14:17 +0000 (GMT)
Message-ID: <fec22c21-795a-82b8-0001-30648a22e792@linux.ibm.com>
Date:   Mon, 10 Jan 2022 13:14:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic> <YdWEXRt7Ixm6/+Dq@work-vm>
 <YdXq9t75aYLJfb69@zn.tnic> <YdX6aAwy0txT9Dk7@work-vm>
 <YdgrDRCJOOg4k1Za@zn.tnic>
 <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XmEgR8upfN5kPEh08dJJxLHCi4XWNX4l
X-Proofpoint-GUID: 7Ym9zYsGBX9O7Y1FyyCgl5ENs8NT4U4z
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_04,2022-01-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100074
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 07/01/2022 21:16, Peter Gonda wrote:
> On Fri, Jan 7, 2022 at 4:59 AM Borislav Petkov <bp@suse.de> wrote:
>>
>> On Wed, Jan 05, 2022 at 08:07:04PM +0000, Dr. David Alan Gilbert wrote:
>>> I thought I saw something in their patch series where they also had a
>>> secret that got passed down from EFI?
>>
>> Probably. I've seen so many TDX patchsets so that I'm completely
>> confused what is what.
>>
>>> As I remember they had it with an ioctl and something; but it felt to
>>> me if it would be great if it was shared.
>>
>> I guess we could try to share
>>
>> https://lore.kernel.org/r/20211210154332.11526-28-brijesh.singh@amd.com
>>
>> for SNP and TDX.
>>
>>> I'd love to hear from those other cloud vendors; I've not been able to
>>> find any detail on how their SEV(-ES) systems actually work.
>>
>> Same here.
>>
>>> However, this aims to be just a comms mechanism to pass that secret;
>>> so it's pretty low down in the stack and is there for them to use -
>>> hopefully it's general enough.
>>
>> Exactly!
>>
>>> (An interesting question is what exactly gets passed in this key and
>>> what it means).
>>>
>>> All the contentious stuff I've seen seems to be further up the stack - like
>>> who does the attestation and where they get the secrets and how they
>>> know what a valid measurement looks like.
>>
>> It would be much much better if all the parties involved would sit down
>> and decide on a common scheme so that implementation can be shared but
>> getting everybody to agree is likely hard...
> 
> I saw a request for other cloud provider input here. A little
> background for our SEV VMs in GCE we rely on our vTPM for attestation,
> we do this because of SEV security properties quoting from AMD being
> to protect guests from a benign but vulnerable hypervisor. So a
> benign/compliant hypervisor's vTPM wouldn't lie to the guest. So we
> added a few bits in the PCRs to allow users to see their SEV status in
> vTPM quotes.

Thanks Peter for explaining the GCE approach.  If I understand correctly,
if the hypervisor is malicious, it could lie to the vTPM and set those
"few bits" so it'll look like the VM is running with SEV enabled (whereas
in fact it is running without memory encryption).  But that's outside the
scope, right?


> 
> It would be very interesting to offer an attestation solution that
> doesn't rely on our virtual TPM. But after reading through this cover
> letter and the linked OVMF patches I am confused what's the high level
> flow you are working towards? Are you loading in some OVMF using
> LAUNCH_UPDATE_DATA, getting the measurement with LAUNCH_MEASURE, then
> sending that to the customer who can then craft a "secret" (maybe say
> SSH key) for injection with LAUNCH_SECRET? Thats sounds good but there
> are a lot details left unattested there, how do you know you will boot
> from the image loaded with the PSP into a known state? Do you have
> some documentation I could read through to try and understand a little
> more and apologies if I missed it.
> 

We rely on the OvmfPkg/AmdSev build of OVMF, which is a stripped down
firmware that can boot only in one of two ways:

a. direct boot to kernel/initrd/cmdline whose hashes are included in
   the LAUNCH_MEASURE data (see [1], [2], [3]).
b. boot to embedded grub (in OVMF) which decrypts an encrypted boot drive
   using a secret from LAUNCH_SECRET (see [4] and [5]).

For the current series (efi_secret kernel module), method (a) is the relevant
one.  The Cloud Provider boots a guest VM with OVMF, and -kernel/-initrd/-append. The
content of OVMF and the hashes of kernel/initrd/cmdline are measured in LAUNCH_MEASURE
and sent to the Guest Owner (=Customer).  If they match, the Guest Owner should perform 
a LAUNCH_SECRET and inject the secret to a designated SEV launch secrets page.  

Then the guest starts running; when the kernel starts the EFI driver saves the address
of this page (patch 1), and later exposes the secrets in this page as files in
securityfs (patch 3). The secrets can be used by the guest workload in whatever way
it needs (examples discussed above: ssh private key; API key to obtain secrets;
decryption key for some encrypted files; ...). 

Any attempt of a malicious cloud provider to modify OVMF, kernel, initrd, or cmdline
will cause the SEV measurement to be wrong. 

Note again that the proposed kernel patch series has nothing to do with the measurement
sequence -- it assumes the secrets page is already populated, and exposes it
to userspace as files.

Hope this explains our approach.


[1] https://www.youtube.com/watch?v=jzP8RlTRErk
[2] https://lore.kernel.org/qemu-devel/20210930054915.13252-1-dovmurik@linux.ibm.com/
[3] https://lore.kernel.org/qemu-devel/20211111100048.3299424-1-dovmurik@linux.ibm.com/

[4] https://www.youtube.com/watch?v=rCsIxzM6C_I
[5] https://blog.hansenpartnership.com/deploying-encrypted-images-for-confidential-computing/



-Dov
