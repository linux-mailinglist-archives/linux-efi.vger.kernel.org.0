Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1F2A4F53
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgKCStX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 13:49:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgKCStX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 13:49:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3IVInp076108;
        Tue, 3 Nov 2020 13:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XbU6z4LdrYfUhGMmjonRce3KkZEv6u0ng4kVFEKxkqg=;
 b=Oogk72Up/WJecFnZF65tJk6ABaa75uNw1rpMZrP4SLkQJnuMQ7eTwCR/tZGvLR0bR5lW
 nDRiCWjcnCMEBoawWD4CV2mYERs6P3xvkuRRljAcxDTV5NyZca7idApOatqaYEmPoxkd
 lKemYUoKnPVnFT/+Ovu7CgSz4V5aqQw9XODfDXtYfkQxRzUREsVt5jG+qeJYoJmuAfNa
 x1Wef4dqptLs9N1udtBBiCzbrdgOjfvWt+2BcSWseD46k1R2I7akfTV9dVQXxSWBCaZ2
 XdOZTGg0OyyRuZNnVw3ZgUVjwz+N6h/2F0mq6dINonBIicKDg2FoOBeongYELmlvs3GC ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jwj1nts6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 13:49:06 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3IepPM127117;
        Tue, 3 Nov 2020 13:49:06 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jwj1ntr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 13:49:05 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Il7DA008820;
        Tue, 3 Nov 2020 18:49:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 34j6j41222-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 18:49:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3In1du19792288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 18:49:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5B742049;
        Tue,  3 Nov 2020 18:49:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5845542041;
        Tue,  3 Nov 2020 18:48:58 +0000 (GMT)
Received: from sig-9-65-255-16.ibm.com (unknown [9.65.255.16])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 18:48:58 +0000 (GMT)
Message-ID: <93e614b138c9f047612db304ca5ebe8a7b21c941.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] efi: generalize efi_get_secureboot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, clin@suse.com,
        x86@kernel.org, jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Nov 2020 13:48:56 -0500
In-Reply-To: <20201102223800.12181-2-ardb@kernel.org>
References: <20201102223800.12181-1-ardb@kernel.org>
         <20201102223800.12181-2-ardb@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=3
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030123
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> From: Chester Lin <clin@suse.com>
> 
> Generalize the efi_get_secureboot() function so not only efistub but also
> other subsystems can use it.
> 
> Note that the MokSbState handling is not factored out: the variable is
> boot time only, and so it cannot be parameterized as easily. Also, the
> IMA code will switch to this version in a future patch, and it does not
> incorporate the MokSbState exception in the first place.
> 
> Note that the new efi_get_secureboot_mode() helper treats any failures
> to read SetupMode as setup mode being disabled.
> 
> Co-developed-by: Chester Lin <clin@suse.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks, Ard.  Other than one minor thing inline below, the patch looks
good.  I haven't done any testing yet.

> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index bd9d83a94173..79b2d4de62e0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1082,7 +1082,28 @@ enum efi_secureboot_mode {
>  	efi_secureboot_mode_disabled,
>  	efi_secureboot_mode_enabled,
>  };
> -enum efi_secureboot_mode efi_get_secureboot(void);
> +
> +static inline
> +enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)

get_var() should be defined as "efi_status_t".   If this is being
upstreamed via integrity, I can make the change.

thanks,

Mimi

