Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B6488CE6
	for <lists+linux-efi@lfdr.de>; Sun,  9 Jan 2022 23:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiAIWmv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Jan 2022 17:42:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235592AbiAIWmv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 Jan 2022 17:42:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 209K8jts009677;
        Sun, 9 Jan 2022 22:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=m7kkaOgprMhyZKpBAE0U3Rg3/s8DXxuGpFqmaEYLgXU=;
 b=eT8I4T0fENCfLrpQVlHHcpt2ffsZw4uqAgEX+7ZNnkm3q3Q0JnVAN5CHbGaJNDr5otUN
 9Zq/7Kq+GD2QW5PJ3Lc8xv8/nT5xFozv9477i6ie++BxEluCAk8hAB3wjRWmlxypbcJM
 DtWNXcl1YHhvhigBfHyYnr47r8vYDMeLCCdQzQ2wRE7sKyJjAiINonVKEH7vwFLxKK6x
 c57RFIFJ1xj4yanedbXhhAof+WbEPBANvIvSaYWAOCHgx3Ks0IT700k7+pH1gwbuQLhj
 Uu8/zbVoGquEKOQrnfuclNFxkmtTtgCmm38GEt/GyerM/a5Nn2G1AU6y1CQWSWS0h/K5 ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm9gcxnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 22:42:23 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 209MdbF2009477;
        Sun, 9 Jan 2022 22:42:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm9gcxnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 22:42:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 209MbeKd010915;
        Sun, 9 Jan 2022 22:42:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3df288y4kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 22:42:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 209MgIZg39453012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jan 2022 22:42:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C659A4060;
        Sun,  9 Jan 2022 22:42:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B21F5A4054;
        Sun,  9 Jan 2022 22:42:15 +0000 (GMT)
Received: from sig-9-65-69-17.ibm.com (unknown [9.65.69.17])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jan 2022 22:42:15 +0000 (GMT)
Message-ID: <4038761f32f97ab60802fc0bc9cfa65fa0ed4bca.camel@linux.ibm.com>
Subject: Re: [PATCH v9 5/8] KEYS: Introduce link restriction for machine keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Sun, 09 Jan 2022 17:42:09 -0500
In-Reply-To: <20220105235012.2497118-6-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-6-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XFDV990_tYuNDSKLB5cATkiEE0Peu3Uy
X-Proofpoint-GUID: CdvUNCdUM0lPSQe2GhWQs6fuoaDDNz3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-09_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201090163
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-01-05 at 18:50 -0500, Eric Snowberg wrote:
> Introduce a new link restriction that includes the trusted builtin,
> secondary and machine keys. The restriction is based on the key to be
> added being vouched for by a key in any of these three keyrings.
> 
> With the introduction of the machine keyring, the end-user may choose to
> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
> trust them, the .machine keyring will contain these keys.  If not, the
> machine keyring will always be empty.  Update the restriction check to
> allow the secondary trusted keyring and ima keyring to also trust
> machine keys.

As suggested the Kconfig in "[PATCH v9 2/8] integrity: Introduce a
Linux keyring called machine" only loads the platform keys onto the
.machine keyring, when
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not enabled.  The
last sentence needs to be updated to reflect v9.

thanks,

Mimi

