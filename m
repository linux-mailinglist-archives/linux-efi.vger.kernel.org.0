Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677D38A7BC
	for <lists+linux-efi@lfdr.de>; Thu, 20 May 2021 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhETKmM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 May 2021 06:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236802AbhETKkP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 May 2021 06:40:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KAYCm2009613;
        Thu, 20 May 2021 06:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=d4keRJbZxxU3IW1YrXVjUG742qIfle3pQLb4NWHBFoA=;
 b=HcnzQoGfrPLYJ6uwa/XdX7xILsrKmT2XTCWHxqevhv8lytdxpY79nXM86nzoqJmiCeXZ
 7wB8fYXrJ0IrXCWhBLPRL8uSSj6sl3Svy0LuANQKtxLV4vNPMamwhvtU28m35O/so3LX
 s2eWKqRdyuzSMa6GlEyZi83vgYJUY/WFPiE3g5gwHDl7zgd+Dvf97DGJhnu6yCf5iEQC
 Db34SWJEzezk0dJxF+e9gV2/SmPIRgoN0CuhgowUAZIO+mWLcV5I/+w/gYFcmKcxgOgg
 wZKsi0UIHVNrqOKjtDPV8CqdTCgGkuxCxSneNJoZAhn6x9k7CFLF8Dc4KIa6XlqKJjM1 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nmhck9n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 06:38:41 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14KAcfV9026927;
        Thu, 20 May 2021 06:38:41 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nmhck9mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 06:38:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KAbb8U020532;
        Thu, 20 May 2021 10:38:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgtjkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 10:38:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14KAcZ2f41222544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 10:38:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAC72A4055;
        Thu, 20 May 2021 10:38:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE24A4040;
        Thu, 20 May 2021 10:38:30 +0000 (GMT)
Received: from [9.65.213.35] (unknown [9.65.213.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 10:38:30 +0000 (GMT)
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     Brijesh Singh <brijesh.singh@amd.com>, linux-efi@vger.kernel.org
Cc:     Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
Message-ID: <c3a781e0-1c76-e0b5-9d65-e1c049dc2deb@linux.ibm.com>
Date:   Thu, 20 May 2021 13:38:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 19QOyHsaOqAd2Prp-Ov2DoXqpYxUuyjl
X-Proofpoint-ORIG-GUID: 4BJdHmsvcFbJSwKnFFhtLtsOyR0w-JD7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_01:2021-05-20,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200079
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Brijesh,

On 14/05/2021 16:01, Brijesh Singh wrote:
> Hi Dov,
> 
> 
> On 5/13/21 1:26 AM, Dov Murik wrote:
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
>> that exposes the content of the secret entries as securityfs files.
>>
>> This has been tested with AMD SEV guests, but the kernel side of
>> handling the secret area has no SEV-specific dependencies, and therefore
>> should be usable for any confidential computing hardware that can
>> publish the secret area via the standard EFI config table entry.
>>
>> Here is a simple example for usage of the sev_secret module in a guest to which
>> secrets were injected during launch:
>>
>> # modprobe sev_secret
>> # ls -la /sys/kernel/security/sev_secret
>> total 0
>> drwxr-xr-x 2 root root 0 May 12 18:03 .
>> drwxr-xr-x 3 root root 0 May 12 18:02 ..
>> -r--r----- 1 root root 0 May 12 18:03 736870e5-84f0-4973-92ec-06879ce3da0b
>> -r--r----- 1 root root 0 May 12 18:03 83c83f7f-1356-4975-8b7e-d3a0b54312c6
>> -r--r----- 1 root root 0 May 12 18:03 9553f55d-3da2-43ee-ab5d-ff17f78864d2
>> -r--r----- 1 root root 0 May 12 18:03 e6f5a162-d67f-4750-a67c-5d065f2a9910
>>
>> # xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
>> 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
>> 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
>> 00000020: 0607                                     ..
> 
> I am adding a new virt driver to help get the attestation report for the
> SEV-SNP guest. I understand they both are different, in case of the SEV
> the attestation is already completed and we are simply exposing the
> secret provided after the attestation to the userspace, whereas in SNP,
> the userspace is querying the attestation and will probably derive keys
> etc based on the attestation report. 

I don't know a lot about SNP, but are we talking about the same secrets? SEV's LAUNCH_SECRET command allows the guest owner to inject any binary blob, though through the current OVMF implementation it is limited to one page.  These can be used for anything - encryption keys, private keys for signature, passphrases, etc. The SNP secret is used for communication with the PSP only? 

Can the two co-exist?


> I am wondering if we should merge
> both the SEV secret and SNP attestation query in a single driver ?

Generally I'm OK with this, but I want to support plain SEV as well. The current suggested snp-guest driver is only activated on SNP (if I read the code correctly).  Now the question is whether a general SEV (or confidential computing) driver makes sense? It looks like only parts of its functionality will be available depending on the actual hardware available.


> Should we cover usecases where SEV guest is not booted under the EFI ?

This sounds interesting; it might be useful for Kata were we try to minimize the overhead of the VM, so fewer moving parts is better.  So far we don't know how to boot an SEV guest without OVMF (=EFI).  Is this supported with QEMU (we currently inject SEV secrets using QEMU's sev-inject-launch-secret)?  Can you share such instructions?


> Also, it appears that this driver need to be manually loaded, should we
> create a platform device so that the driver binds to platform device and
> use the resource structure to find the location of the secret data?

I designed the sev-secret driver to be hardware-indepedent (maybe a better name would be confidential-computing-secret); it just looks for the declared secrets page and creates a userspace API to read the secrets by GUID.  In that sense, binding it to specific hardware will limit its usage with other platforms that can "prepare" the secrets in the correct place.



> 
> I was trying to answer some of these questions SNP series. See these patches
> 
> https://marc.info/?l=kvm&m=161978514019741&w=2
> 
> https://marc.info/?l=kvm&m=161978514119744&w=2
> 
> https://marc.info/?l=kvm&m=161978514219751&w=2
> 
> 
>>
>> [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
>>
>>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Ashish Kalra <ashish.kalra@amd.com>
>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Cc: James Bottomley <jejb@linux.ibm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-efi@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
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
>>  .../efi/libstub/confidential-computing.c      |  68 +++++
>>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>>  drivers/firmware/efi/libstub/efistub.h        |   2 +
>>  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
>>  drivers/virt/Kconfig                          |   2 +
>>  drivers/virt/Makefile                         |   1 +
>>  drivers/virt/sev_secret/Kconfig               |  11 +
>>  drivers/virt/sev_secret/Makefile              |   2 +
>>  drivers/virt/sev_secret/sev_secret.c          | 260 ++++++++++++++++++
>>  include/linux/efi.h                           |  11 +
>>  14 files changed, 410 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/firmware/efi/confidential-computing.c
>>  create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
>>  create mode 100644 drivers/virt/sev_secret/Kconfig
>>  create mode 100644 drivers/virt/sev_secret/Makefile
>>  create mode 100644 drivers/virt/sev_secret/sev_secret.c
>>
>>
>> base-commit: c06a2ba62fc401b7aaefd23f5d0bc06d2457ccc1
