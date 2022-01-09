Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5E488CBE
	for <lists+linux-efi@lfdr.de>; Sun,  9 Jan 2022 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiAIV5b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Jan 2022 16:57:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234756AbiAIV5a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 Jan 2022 16:57:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 209KbAl1005236;
        Sun, 9 Jan 2022 21:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=L3fKmgfU9ORlrY2FwPy6xnlArN1TwmZZ/E0/yc+J1+0=;
 b=XNH8jdFFrIoqNYXUO5woJtnbvncUoswoqZ2MrUx+fPW98Eosj7bW9qf5XbPAm2gJG9h2
 2xdDzuhjVLQBSyxaeTKQH8pS7Ef2TyGlIVqjj9USlUjY8PoOLKd2nMIsGQhLEmysdcSR
 lx85ndnMbQPJM/P7V2/d/W0XCS1P2y7R1o2Grw5WnE8mvR3D0YQbLvpGZPJFEytPIzxa
 f8o19bHEf5zsmWrC6Xo44LpxuRr4zssCCS9aL0MPP1NCpF4auuaJZdnxnvpFXQQdJl7W
 wwmDR/suhCIsA94iQI0t528g2zFNT4Eq6Mb4YGUN7X8obtOo588LcXknWqqGvrq0+v+8 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3v4vph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 21:57:16 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 209LvFe2032722;
        Sun, 9 Jan 2022 21:57:15 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3v4vnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 21:57:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 209LpsQB024890;
        Sun, 9 Jan 2022 21:57:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3df288pjr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 21:57:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 209LvAom47513988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jan 2022 21:57:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1097852050;
        Sun,  9 Jan 2022 21:57:10 +0000 (GMT)
Received: from sig-9-65-69-17.ibm.com (unknown [9.65.69.17])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 202795204E;
        Sun,  9 Jan 2022 21:57:08 +0000 (GMT)
Message-ID: <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
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
Date:   Sun, 09 Jan 2022 16:57:06 -0500
In-Reply-To: <20220105235012.2497118-3-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X7Ua14-XMGOndLkiXqxVi_WSFHppt9J4
X-Proofpoint-GUID: 42z3FCIrIyrz9lyEafzePYIc17mSaGXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-09_09,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201090156
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-01-05 at 18:50 -0500, Eric Snowberg wrote:
> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
> Boot DB and MOK keys to validate the next step in the boot chain.  The
> MOK facility can be used to import user generated keys.  These keys can
> be used to sign an end-users development kernel build.  When Linux
> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
> .platform keyring.
> 
> Define a new Linux keyring called machine.  This keyring shall contain just
> MOK CA keys and not the remaining keys in the platform keyring. This new
> machine keyring will be used in follow on patches.  Unlike keys in the
> platform keyring, keys contained in the machine keyring will be trusted
> within the kernel if the end-user has chosen to do so.

True, from an IMA perspective only the CA keys should be loaded onto
the .machine keyring, but this version (v9) of the patch set does not
enforce that.  The patch set and this paragraph are out of sync.

Jarkko, my concern is that once this version of the patch set is
upstreamed, would limiting which keys may be loaded onto the .machine
keyring be considered a regression?

thanks,

Mimi

> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v1: Initial version
> v2: Removed destory keyring code
> v3: Unmodified from v2
> v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
> v5: Rename to machine keyring
> v6: Depend on EFI in kconfig  (suggested by Mimi)
>     Test to see if ".platform" keyring is configured in
>       add_to_machine_keyring (suggested by Mimi)
> v7: Depend on LOAD_UEFI_KEYS instead EFI for mokvar code
> v8: Code unmodified from v7 added Mimi's Reviewed-by
> v9: Removed Reviewed-by. Prevent IMA from being able to
>      use the machine keyring since the CA restrictions
>      have been removed.

