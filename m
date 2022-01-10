Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9514488D75
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiAJANI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Jan 2022 19:13:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6468 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbiAJANI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 Jan 2022 19:13:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 209N5ax6000673;
        Mon, 10 Jan 2022 00:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rG8ML9KQhv5y20UZSlBRknsJ00Kb1nBEBBi6BEtBVb8=;
 b=YbYAaYy/Dh+7tfJQDz/sJsRD1lK/yWOVoiXqN677Mw06gsxRDH7P7TmpGb35S2epwmkd
 lQiUUdHqMKD3DjR00bB6VD0ty1QExqjoX02I3IxPLLpTYM0XMRSOwcRJ8XIDUrlI1llM
 JgGEZbGMBXyg4kTdCK5Roa4s4icc9KKBqnpUYEv1B/QzwPfvO3OglIBVBR5JmlXwlBty
 LxUrCFxY9KLuRjcn0M1l5gKpAolx54cGou4duoqjqbK/GIAP9OjmbU+bdatxQYERiHgL
 hv/Inoz3MNg3kf4vyxIiGjemdna4Mh1ysatrTKeiG4KuDWoxdo9x13pRKMH3puz/8cji cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm8j60ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 00:12:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20A0A3wM026229;
        Mon, 10 Jan 2022 00:12:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm8j60hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 00:12:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20A0BwwN006081;
        Mon, 10 Jan 2022 00:12:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3df1vhxyrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 00:12:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20A0Clpv40305030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 00:12:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42BA1A404D;
        Mon, 10 Jan 2022 00:12:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17982A4040;
        Mon, 10 Jan 2022 00:12:45 +0000 (GMT)
Received: from sig-9-65-69-17.ibm.com (unknown [9.65.69.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 00:12:44 +0000 (GMT)
Message-ID: <099cdb4d6d8f74247d57f9d48472968e57c9e5c2.camel@linux.ibm.com>
Subject: Re: [PATCH v9 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Sun, 09 Jan 2022 19:12:44 -0500
In-Reply-To: <2aa9e4b290424c869afe983ed63b5a0c4d12df36.camel@linux.ibm.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-9-eric.snowberg@oracle.com>
         <YdoQbKD/jJompy6I@iki.fi>
         <2aa9e4b290424c869afe983ed63b5a0c4d12df36.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2gzQuLNV6iTXCxW_fTNC6JpCPH608Cx4
X-Proofpoint-GUID: _kkCGc8jWagn5jo-EgZaU6wNm0i8gAxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-09_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201090174
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2022-01-08 at 20:47 -0500, Mimi Zohar wrote:
> On Sun, 2022-01-09 at 00:30 +0200, Jarkko Sakkinen wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Mimi, have you tested these patches already?
> 
> Sorry, not yet this version this of the patch set.  Planning to test
> shortly.

I've only tested v9 1/8 - 6/8 patches on top of Takashi Iwai and Joey
Lee's patches, which are queued to be upstreamed.

92ad19559ea9 integrity: Do not load MOK and MOKx when secure boot be
disabled
54bf7fa3efd0 ima: Fix undefined arch_ima_get_secureboot() and co

With secure boot enabled and
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY disabled,  all of
the MOK keys are loaded onto the .machine keyring.  With secure boot
disabled, none of the MOK keys are loaded onto either the .platform or
.machine keyrings, irrespective of
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

This patch set is working as expected, but the v9 2/8 & 5/8 patch
descriptions haven't been updated, nor have the related comments been
updated.  Please note that the subsequent patch set will limit the MOK
keys being loaded onto the .machine keyring to only the MOK CA keys.

thanks,

Mimi

