Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA294549BB
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 16:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhKQPT4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 10:19:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232882AbhKQPTx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 10:19:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHF4I2F026628;
        Wed, 17 Nov 2021 15:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Pdz6EcI3HLQgoDL16do0wFLbHIcHaNdtEDqRgcx1CaA=;
 b=VOJsA9eOXos9wRlklVvDS+O8D30uzNDHYztddMM7qX83ne2QP/faD2zKmFgQdfl/eKio
 Nu3dwrcLIO8i/0XmbGruonIyHiV5dn+gkl33T5Lqo4soqEGL5G8Ru+Ttbe5rT5wH4QpO
 8aCn4gJytsqfCYQAYzw3j2aWMDVMBZe5jD9nL4k0Sv6PLhiUBF3G4j1y+Jqu4nDTfRPh
 R6bRi0+BiKb05vjI7WmuWOX+Hr3gznOO7n8VTk8xKXt6i32bY0zPpT7SZgzVU+GCGwAF
 RrCcSwNgHVLg3+BA1H9yKetqxEqaPSR68n7dylKSnxp0WNvTvA/Jq01SYVjAH9kRsayy 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2ed2ymn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 15:16:33 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHF6N1G006026;
        Wed, 17 Nov 2021 15:16:32 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd2ed2ykq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 15:16:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHEqsQJ005654;
        Wed, 17 Nov 2021 15:16:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3ca50cj1re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 15:16:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHFGPWT5177946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 15:16:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E564C05A;
        Wed, 17 Nov 2021 15:16:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B64B94C062;
        Wed, 17 Nov 2021 15:16:22 +0000 (GMT)
Received: from sig-9-65-64-222.ibm.com (unknown [9.65.64.222])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 15:16:22 +0000 (GMT)
Message-ID: <17ce63cca47d7cc146ab9c5012c7429b1eacf3b4.camel@linux.ibm.com>
Subject: Re: [PATCH v7 07/17] integrity: Fix warning about missing prototypes
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
Date:   Wed, 17 Nov 2021 10:16:22 -0500
In-Reply-To: <20211116001545.2639333-8-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-8-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HfmPQ5Ep0dKfngIGkYv3ffjaBYUliVec
X-Proofpoint-ORIG-GUID: RJG6mAjCvo3K2Ruc7rc7YsKIiHkDElo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170074
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> make W=1 generates the following warning in keyring_handler.c
> 
> security/integrity/platform_certs/keyring_handler.c:71:30: warning: no previous prototype for get_handler_for_db [-Wmissing-prototypes]
>  __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>                               ^~~~~~~~~~~~~~~~~~
> security/integrity/platform_certs/keyring_handler.c:82:30: warning: no previous prototype for get_handler_for_dbx [-Wmissing-prototypes]
>  __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *sig_type)
>                               ^~~~~~~~~~~~~~~~~~~
> Add the missing prototypes by including keyring_handler.h.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

These sorts of fixes, which aren't really dependent on the patch set,
could be moved to the begining of the patch set.

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

