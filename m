Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC4D40BD
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfJKNNM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 09:13:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728404AbfJKNNL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 09:13:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9BD8Y0Q094757
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:13:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vjqj97c3e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 09:13:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Oct 2019 14:13:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Oct 2019 14:13:04 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9BDD2OD50135232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:13:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54091A4053;
        Fri, 11 Oct 2019 13:13:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7CF1A4040;
        Fri, 11 Oct 2019 13:12:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.57])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 13:12:59 +0000 (GMT)
Subject: Re: [PATCH v7 2/8] powerpc: add support to initialize ima policy
 rules
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
Date:   Fri, 11 Oct 2019 09:12:59 -0400
In-Reply-To: <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
         <1570497267-13672-3-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101113-0008-0000-0000-000003212EDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101113-0009-0000-0000-00004A403B8F
Message-Id: <1570799579.5250.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910110124
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2019-10-07 at 21:14 -0400, Nayna Jain wrote:
> PowerNV systems uses kernel based bootloader, thus its secure boot
> implementation uses kernel IMA security subsystem to verify the kernel
> before kexec. 

^use a Linux based bootloader, which rely on the IMA subsystem to
enforce different secure boot modes.

> Since the verification policy might differ based on the
> secure boot mode of the system, the policies are defined at runtime.

^the policies need to be defined at runtime.
> 
> This patch implements the arch-specific support to define the IMA policy
> rules based on the runtime secure boot mode of the system.
> 
> This patch provides arch-specific IMA policies if PPC_SECURE_BOOT
> config is enabled.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig           |  2 ++
>  arch/powerpc/kernel/Makefile   |  2 +-
>  arch/powerpc/kernel/ima_arch.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/ima.h            |  3 ++-
>  4 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kernel/ima_arch.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b4a221886fcf..deb19ec6ba3d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -938,6 +938,8 @@ config PPC_SECURE_BOOT
>  	prompt "Enable secure boot support"
>  	bool
>  	depends on PPC_POWERNV
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY

As IMA_ARCH_POLICY is dependent on IMA, I don't see a need for
depending on both IMA and IMA_ARCH_POLICY.

Mimi

