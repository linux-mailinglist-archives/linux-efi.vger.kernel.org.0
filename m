Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0053B6E9B
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jun 2021 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhF2HTN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 03:19:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhF2HTM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 03:19:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T74NHj073962;
        Tue, 29 Jun 2021 03:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fEoq0GAfky9yQORdc09YiOw0VuMqMvMvEJPOj9WXLxU=;
 b=gduTOkOLf0vMoZY1agFu9rEmA5sxGFy4c1L/47hwAYXbPPKqKz75/BTW7IAY0bzHiNb8
 if4B9WAG7vNQPKcqgFDUA4XMkGqkkAlniHrqDdY8R7pNxy/fs018a4MHIh8HmlC4KJTz
 hsmg3YcA4/Zx/BeW8ZTlvtpUq4ZHItKXHZsQrBRwDNRVYTP7iD/bHOchW+CsmEX3xtAn
 e/8fG68DTuMyIUVbYcajrLww4J+UVKUjWnGNl4KwFotqvLOlztseM7fmYx5OcfubK5hi
 wKWZ8jxe6DTVvTBDUl5UlTQMmkkrAtHmy86tIsxCSkGWgNVk/x8vXy9vEFqFcyj445sI gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwu71r5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:16:35 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15T75Nkh076813;
        Tue, 29 Jun 2021 03:16:35 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwu71r45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:16:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15T7D34Q032077;
        Tue, 29 Jun 2021 07:16:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 39fv59r154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 07:16:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15T7GT9631392006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:16:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B80AA4060;
        Tue, 29 Jun 2021 07:16:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0333EA4085;
        Tue, 29 Jun 2021 07:16:24 +0000 (GMT)
Received: from [9.160.49.135] (unknown [9.160.49.135])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 07:16:23 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/3] Allow access to confidential computing secret
 area
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-efi@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <YNoiydeow+ftvfYX@zn.tnic>
Message-ID: <90fa45e6-8c24-6c72-2ef5-35a4b3c4d5d7@linux.ibm.com>
Date:   Tue, 29 Jun 2021 10:16:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YNoiydeow+ftvfYX@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V1RSAYGGH9PqY6c7f15R0381jwYVoo3m
X-Proofpoint-ORIG-GUID: mLqY3SH1nQQdww3K9RGKFYQ2My2ENNVj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_02:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290050
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Boris,

On 28/06/2021 22:28, Borislav Petkov wrote:
> Just a couple of notes below:
> 
> On Mon, Jun 28, 2021 at 06:34:28PM +0000, Dov Murik wrote:
>> Confidential computing hardware such as AMD SEV (Secure Encrypted
>> Virtualization) allows guest owners to inject secrets into the VMs
>> memory without the host/hypervisor being able to read them.  In SEV,
>> secret injection is performed early in the VM launch process, before the
>> guest starts running.
>>
>> Support for secret injection is already available in OVMF (in its AmdSev
>> package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the Sev
>> Secret area using a configuration table" [1]), but the secrets were not
>> available in the guest kernel.
>>
>> The patch series copies the secrets from the EFI-provided memory to
>> kernel reserved memory, and optionally exposes them to userspace via
>> securityfs using a new sev_secret kernel module.
>>
>> The first patch in efi/libstub copies the secret area from the EFI
>> memory to specially allocated memory; the second patch reserves that
>> memory block; and the third patch introduces the new sev_secret module
>> that exposes the content of the secret entries as securityfs files, and
>> allows clearing out secrets with a file unlink interface.
>>
>> This has been tested with AMD SEV guests, but the kernel side of
>> handling the secret area has no SEV-specific dependencies, and therefore
>> should be usable for any confidential computing hardware that can
>> publish the secret area via the standard EFI config table entry.
>>
>> Here is a simple example for usage of the sev_secret module in a guest to which
>> secrets were injected during launch:
> 
> That's all fine and good but I miss the "why" in this explanation. I.e.,
> a proper use case of a guest owner providing those sekrits to the guest
> would be good.
> 

OK, I'll add it in the cover letter; something along the lines of:


An example would be a guest performing computations on encrypted files.
 The Guest Owner provides the decryption key (= secret) using the secret
injection mechanism.  The guest application reads the secret from the
sev_secret filesystem and proceeds to decrypt the files into memory and
then performs the needed computations on the content.

Host can't read the files from the disk image because they are
encrypted. Host can't read the decryption key because it is passed using
the secret injection mechanism (= secure channel). Host can't read the
decrypted content from memory because it's a confidential
(memory-encrypted) guest.



>>
>> # modprobe sev_secret
>> # ls -la /sys/kernel/security/sev_secret/
> 
> So that sysfs URL becomes an ABI. Shouldn't this be:
> 
> /sys/kernel/security/coco/
> 
> instead which stands for "confidential computing" and contains all kinds
> of protected guest things. TDX might wanna do something similar there,
> for example.
> 

On one hand, I agree.  This entire series has no SEV-specific code (but
I tested it only on SEV).

On the other hand, secret injection mechanisms in SEV-SNP and TDX are
different beasts than the one used here (SEV).  In SEV the secrets must
be injected at VM launch time; so when OVMF runs and kernel efistub runs
the secrets are already there (patches 1+2).  However, in SNP there's no
secret injection at launch; (/me hand-waving) the guest can securely
talk with the PSP hardware, check the attestation, and if OK then
securely contact some Guest Owner secret provider to get the required
secrets.  Not sure it makes sense for the kernel to be part of this
"getting secrets from secret provider and exposing them in securityfs".

So maybe for regular SEV we'll use this sev_secret module to get one
secret which will allow the guest to contact to the Guest Owner secret
provider (and from here continue like SNP or TDX).  Brijesh (AMD) also
suggested collapsing the proposed sev_secret module into the new
sev-guest module ("[PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest
driver", sent 2021-06-02), and the logic suggested here will be used
when SNP is not active.

Or taking a step back: Maybe the kernel should not try to unify
SEV/SEV-SNP/TDX/PEF/s390x-SE.  Each should have its own API.  A
userspace process will have to understand what is available and get the
required info to run the application in a confidential environment.

Or maybe we can find an API that fits all these confidential computing
mechanisms and expose a unified API that hides the underlying
implementation.

(I'm not really sure - that's the reason this is an RFC series.)


>> total 0
>> drwxr-xr-x 2 root root 0 Jun 28 11:54 .
>> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
>> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
>> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
>> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>> -r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910
>>
>> # xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
>> 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
>> 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
>> 00000020: 0607                                     ..
>>
>> # rm /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
>>
>> # ls -la /sys/kernel/security/sev_secret/
>> total 0
>> drwxr-xr-x 2 root root 0 Jun 28 11:55 .
>> drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
>> -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
>> -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
>> -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>>
>>
>> [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
>>
>> v2 changes:
>>  - Add unlink support in sev_secret securityfs.
>>
>>
>> Dov Murik (3):
>>   efi/libstub: Copy confidential computing secret area
>>   efi: Reserve confidential computing secret area
>>   virt: Add sev_secret module to expose confidential computing secrets
>>
>>  drivers/firmware/efi/Makefile                 |   2 +-
>>  drivers/firmware/efi/confidential-computing.c |  41 +++
>>  drivers/firmware/efi/efi.c                    |   5 +
>>  drivers/firmware/efi/libstub/Makefile         |   3 +-
>>  .../efi/libstub/confidential-computing.c      |  68 ++++
>>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>>  drivers/firmware/efi/libstub/efistub.h        |   2 +
>>  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
>>  drivers/virt/Kconfig                          |   2 +
>>  drivers/virt/Makefile                         |   1 +
>>  drivers/virt/sev_secret/Kconfig               |  11 +
>>  drivers/virt/sev_secret/Makefile              |   2 +
>>  drivers/virt/sev_secret/sev_secret.c          | 298 ++++++++++++++++++
>>  include/linux/efi.h                           |  11 +
>>  14 files changed, 448 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/firmware/efi/confidential-computing.c
>>  create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
>>  create mode 100644 drivers/virt/sev_secret/Kconfig
>>  create mode 100644 drivers/virt/sev_secret/Makefile
>>  create mode 100644 drivers/virt/sev_secret/sev_secret.c
> 
> Those "confidential-computing.c" filenames are too long. I'd vote for
> coco.c.
> 

When I wrote this I didn't yet encounter "coco" as an abbreviation. Now
there's a linux-coco mailing list, but I saw no other mentions of it in
the kernel (as an abbreviation for confidential computing).

I agree that the full term is too long; I considered conf-comp (but in
my mind "conf" is short for "configuration").  I used it in one place:
"ConfCompSecret" in patch 2/3.

If as a community we settle on coco / CoCo / COCO then I agree these
should be renamed.

(in QEMU they use CGS = Confidential Guest Support [1].)

[1]
https://lore.kernel.org/qemu-devel/20210202041315.196530-3-david@gibson.dropbear.id.au/


> Same for your naming: efi_copy_confidential_computing_secret_area() -
> that is a wow and doesn't look like kernel code to me. :)
> 
> Another example why it is too long:
> 
> +       {LINUX_EFI_CONFIDENTIAL_COMPUTING_SECRET_AREA_GUID,
> +                                               &efi.confidential_computing_secret,
> +                                                                       "ConfCompSecret"},
> 
> I'd do
> 
> 	{ LINUX_EFI_COCO_SECRET_AREA_GUID, &efi.coco_secret, "ConfCompSecret" },
> 
> 

I agree.

Thanks,
-Dov
