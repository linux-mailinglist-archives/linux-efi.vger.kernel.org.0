Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483C4546D0
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhKQNFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 08:05:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237365AbhKQNFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 08:05:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHD1lkf002170;
        Wed, 17 Nov 2021 13:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZJ46jrL7Dh9eD0h1EgXfi1ge64zLWkn7F73z6rxHbr4=;
 b=dmgcFERfjB0grKlBrn9EoKNF1ztVUBKB2vo3/lNp+apYj4BMO7JVdJ+tVyBZSwwUdbQZ
 kcr+7NcXhkDprAIUE/P+yoccf71xjIxrx1mxZIbXdbwE4O8PsJbpCtFbeTcMxJZ24bU0
 Dlgs17TfzIXYU+z/Br0XCyiDBkjTUFbHZymLzcL9h3cuhdTrVFEE7nsMRE6wXUDWSgrE
 JbfNRgyie2n2JbD28r19DKpM8Pj5GU/MQYr/T+uBwuskCYHxsEjz3zUy/U8OXQ/4E4UF
 V84AK/B8yjjATdLTDM8wREZAm5bbINmYt38fqNr4mFGNmqI0a/glayGw3hoNv5CviCMf bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd1ycgchj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:02:07 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHCgIju011114;
        Wed, 17 Nov 2021 13:02:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd1ycgcgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:02:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHCwreK005675;
        Wed, 17 Nov 2021 13:02:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mk263y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:02:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHCt2oo57082356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 12:55:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 492535207B;
        Wed, 17 Nov 2021 13:01:56 +0000 (GMT)
Received: from sig-9-65-64-222.ibm.com (unknown [9.65.64.222])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8CFC95205F;
        Wed, 17 Nov 2021 13:01:53 +0000 (GMT)
Message-ID: <1414c90e48f78353f5b1da8718bae2f8390caba1.camel@linux.ibm.com>
Subject: Re: [PATCH v7 01/17] integrity: Introduce a Linux keyring called
 machine
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
Date:   Wed, 17 Nov 2021 08:01:53 -0500
In-Reply-To: <20211116001545.2639333-2-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wfaPjHvlHxVj6zy5YdjFD4qOr5kbs48V
X-Proofpoint-ORIG-GUID: 3VM_lmOas3mpBnZbQVew4xoLe8-djoRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170067
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-users development kernel build.  When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.

, which can be used to verify kexec'ed kernel images.

> Define a new Linux keyring called machine.  This keyring shall contain just
> MOK CA keys and not the remaining keys in the platform keyring. This new
> machine keyring will be used in follow on patches.  Unlike keys in the
> platform keyring, keys contained in the machine keyring will be trusted
> within the kernel if the end-user has chosen to do so.

 allowing, for example, keys to be loaded onto the trusted IMA keyring.

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Thank you for all the work!  Just letting you know I'm slowly making my
through the patch set.  With the previous patch re-organization, we
should be able to test everything up to the introduction of the MOK
variable support.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

