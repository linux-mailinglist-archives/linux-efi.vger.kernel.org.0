Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3BDDE7C
	for <lists+linux-efi@lfdr.de>; Sun, 20 Oct 2019 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJTMtM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Oct 2019 08:49:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbfJTMtM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Oct 2019 08:49:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9KCW3ke192581
        for <linux-efi@vger.kernel.org>; Sun, 20 Oct 2019 08:49:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vrg53214p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sun, 20 Oct 2019 08:49:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Oct 2019 13:49:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Oct 2019 13:49:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9KCn1i542270820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 12:49:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 583E4A405B;
        Sun, 20 Oct 2019 12:49:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F40D0A4054;
        Sun, 20 Oct 2019 12:48:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.180.10])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Oct 2019 12:48:58 +0000 (GMT)
Subject: Re: [PATCH v8 3/8] powerpc: detect the trusted boot state of the
 system
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Sun, 20 Oct 2019 08:48:58 -0400
In-Reply-To: <1571508377-23603-4-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
         <1571508377-23603-4-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102012-0020-0000-0000-0000037B7AD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102012-0021-0000-0000-000021D1ADE1
Message-Id: <1571575738.5342.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910200126
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2019-10-19 at 14:06 -0400, Nayna Jain wrote:
> While secure boot permits only properly verified signed kernels to be
> booted, trusted boot takes a measurement of the kernel image prior to
> boot that can be subsequently compared against good known values via
> attestation services.
> 

Instead of "takes a measurement", either "stores a measurement" or
"calculates the file hash of the kernel image and stores the
measurement prior to boot, that".

> This patch reads the trusted boot state of a PowerNV system. The state
> is used to conditionally enable additional measurement rules in the IMA
> arch-specific policies.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/secure_boot.h |  6 ++++++
>  arch/powerpc/kernel/secure_boot.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
> index 07d0fe0ca81f..a2ff556916c6 100644
> --- a/arch/powerpc/include/asm/secure_boot.h
> +++ b/arch/powerpc/include/asm/secure_boot.h
> 
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> index 99bba7915629..9753470ab08a 100644
> --- a/arch/powerpc/kernel/secure_boot.c
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -7,6 +7,17 @@
>  #include <linux/of.h>
>  #include <asm/secure_boot.h>
>  
> +static struct device_node *get_ppc_fw_sb_node(void)
> +{
> +	static const struct of_device_id ids[] = {
> +		{ .compatible = "ibm,secureboot-v1", },
> +		{ .compatible = "ibm,secureboot-v2", },
> +		{},
> +	};
> +

scripts/checkpatch.pl is complaining that secureboot-v1, secureboot-v2 
are not documented in the device tree bindings.

Mimi

