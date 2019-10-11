Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238A2D40EB
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfJKNTS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 09:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbfJKNTS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 09:19:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9BD8hvU124590
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:19:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vjsjjtnkt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:19:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Oct 2019 14:19:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 14:19:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9BDJA9G54591628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:19:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 006F111C05C;
        Fri, 11 Oct 2019 13:19:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E15611C06F;
        Fri, 11 Oct 2019 13:19:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 13:19:07 +0000 (GMT)
Subject: Re: [PATCH v7 8/8] powerpc/ima: update ima arch policy to check for
 blacklist
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 11 Oct 2019 09:19:07 -0400
In-Reply-To: <1570497267-13672-9-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
         <1570497267-13672-9-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101113-0008-0000-0000-000003212F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101113-0009-0000-0000-00004A403C26
Message-Id: <1570799947.5250.80.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910110124
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
> This patch updates the arch specific policies for PowernV systems
> to add check against blacklisted binary hashes before doing the
> verification.

This sentence explains how you're doing something.  A simple tweak in
the wording provides the motivation.

^to make sure that the binary hash is not blacklisted.

> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  arch/powerpc/kernel/ima_arch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> index 88bfe4a1a9a5..4fa41537b846 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -25,9 +25,9 @@ bool arch_ima_get_secureboot(void)
>  static const char *const arch_rules[] = {
>  	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
>  	"measure func=MODULE_CHECK template=ima-modsig",
> -	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
>  #if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
> -	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
> +	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
>  #endif
>  	NULL
>  };

