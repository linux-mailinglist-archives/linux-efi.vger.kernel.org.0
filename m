Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9973B454751
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 14:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhKQNfy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 08:35:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36298 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237648AbhKQNfk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 08:35:40 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHChfa3034787;
        Wed, 17 Nov 2021 13:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VzH4qPKu1Oeh5t7NtP/OJWZAE9e9Esa62qK8Re5fv/I=;
 b=dwNbQfMDzhAwhtKgtnqOcJuNjMe5yZnX7fLB2eM1SGs12aS1nu9dX2uYEP9AHr49POKt
 0QkvL/80kf7u46YJgbcrZPAbhE3I+8yY3gW8ifQ5kJ+cIjiLxk9h9j9EGlrpqHrjsMJG
 9rTtWCH9yLpQrSxpY0Mlq3royNjZYWD5s1GzDUPqC9/1ZzTGu1YqUMJy+auD7MPGa+QV
 QDBVgUoYF0AiJ6mQTwEWSLH8E9Atn+EBJnZ16R4YNB0SmdeGBiXnAOSg1eHXNXXC7xhf
 WVyIQWZiDEQGRXUiXBnANp3kD07PCGcBUFp7L9XkQ2bRxUJ1lXG038Sc1GbT7db0ACLS 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd20d0wym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:32:19 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHD5qpV020013;
        Wed, 17 Nov 2021 13:32:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cd20d0wxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:32:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHDRA57023033;
        Wed, 17 Nov 2021 13:32:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mk2f15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:32:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHDWEsD63308086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 13:32:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA77BAE051;
        Wed, 17 Nov 2021 13:32:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D119DAE053;
        Wed, 17 Nov 2021 13:32:11 +0000 (GMT)
Received: from sig-9-65-64-222.ibm.com (unknown [9.65.64.222])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 13:32:11 +0000 (GMT)
Message-ID: <b9cdbbe6004eac0a7b2881bf6cf03f29f07dcf79.camel@linux.ibm.com>
Subject: Re: [PATCH v7 03/17] KEYS: Create static version of
 public_key_verify_signature
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
Date:   Wed, 17 Nov 2021 08:32:11 -0500
In-Reply-To: <20211116001545.2639333-4-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3sKVs0rFEm74q8hkjh-OmOk77gYeA-8
X-Proofpoint-ORIG-GUID: Umo4YgYpJZVIN0cUvY7uwx2KZTOE7tQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170069
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> The kernel test robot reports undefined reference to
> public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
> not defined. Create a static version in this case and return -EINVAL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

