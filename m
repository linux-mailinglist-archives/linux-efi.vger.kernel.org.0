Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21768206C27
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgFXGGC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Jun 2020 02:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388307AbgFXGGC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Jun 2020 02:06:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O62O74155461;
        Wed, 24 Jun 2020 02:05:46 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31uwyxmkdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 02:05:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O5vWv1012808;
        Wed, 24 Jun 2020 06:05:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 31uusjg8d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 06:05:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05O65gC065011990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 06:05:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40F7AA405F;
        Wed, 24 Jun 2020 06:05:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256D0A4062;
        Wed, 24 Jun 2020 06:05:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.32.164])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Jun 2020 06:05:40 +0000 (GMT)
Date:   Wed, 24 Jun 2020 09:05:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, m.szyprowski@samsung.com
Subject: Re: [PATCH] ARM: mmu: fix crash in EFI calls due to p4d typo in
 create_mapping_late()
Message-ID: <20200624060538.GA2935909@linux.ibm.com>
References: <20200623165936.1545211-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623165936.1545211-1-ardb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_01:2020-06-23,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 clxscore=1011 bulkscore=0 cotscore=-2147483648 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240041
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 23, 2020 at 06:59:36PM +0200, Ard Biesheuvel wrote:
> Commit
> 
>   84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")
> 
> updated create_mapping_late() to take folded P4Ds into account when
> creating mappings, but inverted the p4d_alloc() failure test, resulting
> in no mapping to be created at all.
> 
> When the EFI rtc driver subsequently tries to invoke the EFI GetTime()
> service, the memory regions covering the EFI data structures are missing
> from the page tables, resulting in a crash like
> 
>   Unable to handle kernel paging request at virtual address 5ae0cf28
>   pgd = (ptrval)
>   [5ae0cf28] *pgd=80000040205003, *pmd=00000000
>   Internal error: Oops: 207 [#1] SMP THUMB2
>   Modules linked in:
>   CPU: 0 PID: 7 Comm: kworker/u32:0 Not tainted 5.7.0+ #92
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Workqueue: efi_rts_wq efi_call_rts
>   PC is at efi_call_rts+0x94/0x294
>   LR is at efi_call_rts+0x83/0x294
>   pc : [<c0b4f098>]    lr : [<c0b4f087>]    psr: 30000033
>   sp : e6219ef0  ip : 00000000  fp : ffffe000
>   r10: 00000000  r9 : 00000000  r8 : 30000013
>   r7 : e6201dd0  r6 : e6201ddc  r5 : 00000000  r4 : c181f264
>   r3 : 5ae0cf10  r2 : 00000001  r1 : e6201dd0  r0 : e6201ddc
>   Flags: nzCV  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
>   Control: 70c5383d  Table: 661cc840  DAC: 00000001
>   Process kworker/u32:0 (pid: 7, stack limit = 0x(ptrval))
>   ...
>   [<c0b4f098>] (efi_call_rts) from [<c0448219>] (process_one_work+0x16d/0x3d8)
>   [<c0448219>] (process_one_work) from [<c0448581>] (worker_thread+0xfd/0x408)
>   [<c0448581>] (worker_thread) from [<c044ca7b>] (kthread+0x103/0x104)
>   ...
> 
> Fixes: 84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 628028bfbb92..bcd82614c25d 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -966,7 +966,7 @@ void __init create_mapping_late(struct mm_struct *mm, struct map_desc *md,
>  	pud_t *pud;
>  
>  	p4d = p4d_alloc(mm, pgd_offset(mm, md->virtual), md->virtual);
> -	if (!WARN_ON(!p4d))
> +	if (WARN_ON(!p4d))

It must have been cosmic radiation :)

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

>  		return;
>  	pud = pud_alloc(mm, p4d, md->virtual);
>  	if (WARN_ON(!pud))
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
