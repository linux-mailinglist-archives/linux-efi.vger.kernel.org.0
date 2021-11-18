Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA94E455B8D
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 13:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbhKRMgB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 07:36:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242412AbhKRMf6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 07:35:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AICBYkC002211;
        Thu, 18 Nov 2021 12:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/kvOeSOOTZygMRJ8VpjcjEDUTMlQ9VeW4mzGdb3efG8=;
 b=jKengn854irDoJWdI194ngsJ/6TTQ4LGsxu9mwtBH3vw6Vr/5G8pIZxgXc6u0CrtnJzS
 S34KqUYqUFMvxMOfY6cb+rBht5clhgcbBF7ezCSn/4qTpwyRipfusYWbxCyDnybN6YLY
 /79JN/ZZOP+teatRxkNPNlgx+cohpOwifu5SsUrGoSemhs6xWk9PY+m47Irxn/j5VTXu
 sBxASAHzJniKRXzWq+nXRVcqvLRHQp7Yv6QTrelyXbiw47j39BVwAS1LVaZpRkIaKUhi
 kHXtRqAxQtRe+eyrPFsuHqXjRfTga5FTnECz6HeSgCE0i6ESfl4EVr4RHuL9dwR2EwUw VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdpm9rgs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 12:32:41 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AICBr8x003102;
        Thu, 18 Nov 2021 12:32:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdpm9rgqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 12:32:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AICHUXG011356;
        Thu, 18 Nov 2021 12:32:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca50anhbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 12:32:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AICWZm94129378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 12:32:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FE6F11C06C;
        Thu, 18 Nov 2021 12:32:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AD8811C058;
        Thu, 18 Nov 2021 12:32:32 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 12:32:31 +0000 (GMT)
Message-ID: <e0e704761d5929f73e5e53ac99cd4935ea268cc5.camel@linux.ibm.com>
Subject: Re: [PATCH v7 13/17] KEYS: link secondary_trusted_keys to machine
 trusted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 18 Nov 2021 07:32:31 -0500
In-Reply-To: <20211116001545.2639333-14-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-14-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zH7RcI7km63Zba6YA6wZKy5T8JBqoELH
X-Proofpoint-ORIG-GUID: -SNCk1tKuH50dAgR1QIAbaIj4ZZ9mBeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180073
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

Is the subject line left over from the original patch?   Shouldn't it
be "link machine trusted keys to secondary_trusted_keys".

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Allow the .machine keyring to be linked to the secondary_trusted_keys.
> After the link is created, keys contained in the .machine keyring will
> automatically be searched when searching secondary_trusted_keys.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v3: Initial version
> v4: Unmodified from v3
> v5: Rename to machine keyring
> v7: Unmodified from v5
> ---
>  certs/system_keyring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index ba732856ebd0..2a2dc70b126c 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -101,6 +101,9 @@ static __init struct key_restriction *get_secondary_restriction(void)
>  void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
> +
> +	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
> +		panic("Can't link (machine) trusted keyrings\n");
>  }
>  
>  /**

In general is the ordering of the patches "bisect safe"[1]?  Only in
the next patch is machine_trusted_keys set.   In this case, either
merge the two patches or reverse their order.

thanks,

Mimi

[1] Refer to the section "Separate your changes" in
Documentation/process/submitting-patches.rst.

