Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B74566D1
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 01:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhKSAJY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 19:09:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59526 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231176AbhKSAJY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 19:09:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AINMsf1009468;
        Fri, 19 Nov 2021 00:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SFTrCDUlq/eLPPnNvJ0sfZFy+WwHVeIyOeS1AcNhDRE=;
 b=Q8WUqyAnWcOvZtBn4obJLuspEqgIUDeGCsMIreqBLF5l4aIqKEXOGYzOJ5XjNhevZ6ar
 mNMFPIn8J/dgnHYLdGXuC6rcj1FUWuvRzfyYKV+iXt4Bems6wRUOOHOalP+DsR2JqTq8
 DwAohyNkzu4ds+QE3yoa39Vq84lsXIXOdeLCkvhKhnKGbet/1j4Lg8yoMH/qlwBopkfJ
 LUGSqn4u3WwGMAwGBj7++AJEIJpqy0mmvSokQU+KXiqtwF9Six1hQRM24/pC7uGY0xsm
 0MCZqdGhRVpXcFqenR/8tIpcDsrL5LtJTyZsdCatYxJk85Ytqyj1PqpuSeiv/LvbbXJG Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce0f011mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:05:56 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AINv07i008032;
        Fri, 19 Nov 2021 00:05:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ce0f011kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:05:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ040Mm032308;
        Fri, 19 Nov 2021 00:05:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50bu7rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:05:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ05o799568752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 00:05:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B8A252057;
        Fri, 19 Nov 2021 00:05:50 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4583152050;
        Fri, 19 Nov 2021 00:05:47 +0000 (GMT)
Message-ID: <282e550948d21b7d1ee316ad73b288c302121bb2.camel@linux.ibm.com>
Subject: Re: [PATCH v7 08/17] integrity: add new keyring handler for mok keys
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
Date:   Thu, 18 Nov 2021 19:05:46 -0500
In-Reply-To: <20211116001545.2639333-9-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: szs-S0QTh63CN6gxnqubgoUdLHVXBzt1
X-Proofpoint-ORIG-GUID: 25_TMygxCv07mUz0fQcphSkqn80GXbD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180122
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Currently both Secure Boot DB and Machine Owner Keys (MOK) go through
> the same keyring handler (get_handler_for_db). With the addition of the
> new machine keyring, the end-user may choose to trust MOK keys.
> 
> Introduce a new keyring handler specific for MOK keys.  If MOK keys are
> trusted by the end-user, use the new keyring handler instead.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

