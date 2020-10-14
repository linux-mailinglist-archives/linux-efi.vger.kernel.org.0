Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B809328DFE7
	for <lists+linux-efi@lfdr.de>; Wed, 14 Oct 2020 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgJNLjW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Oct 2020 07:39:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387867AbgJNLjU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Oct 2020 07:39:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EBV9pr128561;
        Wed, 14 Oct 2020 07:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ybbBBc1ubBi+MYs3l37BnscOxOb29Z2bSOcLI0t8Q84=;
 b=DdPbZfv2bcZKQ2yY003LFhSgm52urs3ER9lhahzoSBPPJQ3uuuXqXQvNhrqJvaMVEL+Q
 70WhTwaMHxyA0Iszv7UuUxzgHbfnkkszcfdGlwmig/bvtC7HO+EQ0k1KAjQtT6B/8xUW
 l4Az2CDLsfnEKCdkxFSalWagAIiHx5pGQbp7v7QZzu2kz74riMdAwvgkNJ+AM9e9J6ul
 gAwEzI2cwB9oP+rrNF5x1ilEVE+zbCyq69Rooo5KYgY19d/2SQcNYcgCni6n9Bur14p/
 bfvkKBIR6SRsuNPVBEFpxhy7GTkxSitnl+bx0wLCSYe00zmO+we0iqsuJl4kPlnlpqAz zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3460a68jb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 07:38:58 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09EBVGIF129173;
        Wed, 14 Oct 2020 07:38:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3460a68jae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 07:38:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09EBbwd6021184;
        Wed, 14 Oct 2020 11:38:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3434k7v31m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 11:38:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EBcrN629032888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 11:38:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5004CA4062;
        Wed, 14 Oct 2020 11:38:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4D3A4054;
        Wed, 14 Oct 2020 11:38:51 +0000 (GMT)
Received: from sig-9-65-216-73.ibm.com (unknown [9.65.216.73])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 11:38:51 +0000 (GMT)
Message-ID: <98b04c130708893ebefdf81e127a66356b4a6129.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA
 init time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chester Lin <clin@suse.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, jlee@suse.com
Date:   Wed, 14 Oct 2020 07:38:50 -0400
In-Reply-To: <20201014093531.GA9408@linux-8mug>
References: <20201013081804.17332-1-ardb@kernel.org>
         <ae9ab2560f6d7b114726efb1ec26f0a36f695335.camel@linux.ibm.com>
         <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
         <20201014093531.GA9408@linux-8mug>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_07:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140081
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-10-14 at 17:35 +0800, Chester Lin wrote:
> Hi Ard & Mimi,
> 
> On Tue, Oct 13, 2020 at 06:59:21PM +0200, Ard Biesheuvel wrote:
> > On Tue, 13 Oct 2020 at 18:46, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > [Cc'ing linuxppc-dev@lists.ozlabs.org]
> > >
> > > On Tue, 2020-10-13 at 10:18 +0200, Ard Biesheuvel wrote:
> > > > Chester reports that it is necessary to introduce a new way to pass
> > > > the EFI secure boot status between the EFI stub and the core kernel
> > > > on ARM systems. The usual way of obtaining this information is by
> > > > checking the SecureBoot and SetupMode EFI variables, but this can
> > > > only be done after the EFI variable workqueue is created, which
> > > > occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> > > > is called much earlier by the IMA framework.
> > > >
> > > > However, the IMA framework itself is started as a late_initcall,
> > > > and the only reason the call to arch_ima_get_secureboot() occurs
> > > > so early is because it happens in the context of a __setup()
> > > > callback that parses the ima_appraise= command line parameter.
> > > >
> > > > So let's refactor this code a little bit, by using a core_param()
> > > > callback to capture the command line argument, and deferring any
> > > > reasoning based on its contents to the IMA init routine.
> > > >
> > > > Cc: Chester Lin <clin@suse.com>
> > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > > Link: https://lore.kernel.org/linux-arm-kernel/20200904072905.25332-2-clin@suse.com/
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > > v2: rebase onto series 'integrity: improve user feedback for invalid bootparams'
> > >
> > > Thanks, Ard.  Based on my initial, limited testing on Power, it looks
> > > good, but I'm hesistant to include it in the integrity 5.10 pull
> > > request without it having been in linux-next and some additional
> > > testing.  It's now queued in the next-integrity-testing branch awaiting
> > > some tags.
> > >
> 
> Tested-by: Chester Lin <clin@suse.com>
> 
> I have tested this patch on x86 VM.
> 
> * System configuration:
>   - Platform: QEMU/KVM
>   - Firmware: EDK2/OVMF + secure boot enabled.
>   - OS: SLE15-SP2 + SUSE's kernel-vanilla (=linux v5.9) + the follow commits
>     from linux-next and upstream:
>     * [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init time
>       https://www.spinics.net/lists/linux-efi/msg20645.html
>     * e4d7e2df3a09 "ima: limit secure boot feedback scope for appraise"
>     * 7fe2bb7e7e5c "integrity: invalid kernel parameters feedback"
>     * 4afb28ab03d5 "ima: add check for enforced appraise option"
> 
> * Logs with UEFI secure boot enabled:
> 
>   [    0.000000] Linux version 5.9.0-858-g865c50e1d279-1.g8764d18-vanilla (geeko@b
>   uildhost) (gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f
>   55b3d993b32e5c], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.34.0.20200325-1) #
>   1 SMP Wed Oct 14 04:00:11 UTC 2020 (8764d18)
>   [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-858-g865c50e1d279-1.
>   g8764d18-vanilla root=UUID=5304c03e-4d8a-4d67-873a-32a32e57cdeb console=ttyS0,11
>   5200 resume=/dev/disk/by-path/pci-0000:04:00.0-part4 mitigations=auto ignore_log
>   level crashkernel=192M,high crashkernel=72M,low ima_appraise=off
>   [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point regi
>   sters'
>   [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>   [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>   ....
>   ....
>   [    1.720309] ima: Secure boot enabled: ignoring ima_appraise=off option
>   [    1.720314] ima: No TPM chip found, activating TPM-bypass!
>   [    1.722129] ima: Allocated hash algorithm: sha256


Thank you for testing the options aren't being set in secure boot mode.
My main concern, however, is that IMA doesn't go into TPM-bypass mode. 
Does this system have a TPM?

Mimi

