Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6838CA8D
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEUQFF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 12:05:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229586AbhEUQFF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 May 2021 12:05:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LG3TJf048686;
        Fri, 21 May 2021 12:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=NWkg5whIEVwVMkgRIGlgWyJUA+SgTZHOp0Nbt8P//bY=;
 b=PufsNEtPfEYnffaoQw0CxtuYA55Asl5kkuO4LJ5flhZZdwkSXfDXhn8uDIgxdemVARps
 focxG9bcHx/vDM0HUP2iDcoPHAtke1YlNC+W9y0gNsDr9TPrFni4cejBLhtWdldVdAdc
 +oN+MDctjCUQQ0ut6KIdfnSF1S+Aj2Rw8sHfpLx0Ob0LO+77w5cn29cxge97S2phowfn
 GRfc7+r+eE6ymTrJR4J6uXDQk9h1f+XLvLlHeQzuqLmxaqwvipccyJlAXsGmE8WfO2xD
 PpWE5+2C3c6ptwubaG4qmDq3lczIavaRL5cEaZfOCRm1oze5E/Cuj2tyeegp+3nsuvMd rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38pfar1avs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 12:03:32 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LG3VVL048913;
        Fri, 21 May 2021 12:03:31 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38pfar1avh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 12:03:31 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LFtE6s024491;
        Fri, 21 May 2021 16:03:30 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 38j7tbrbe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 16:03:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LG3Two10551732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 16:03:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4B9878063;
        Fri, 21 May 2021 16:03:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E085D78066;
        Fri, 21 May 2021 16:03:24 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 16:03:24 +0000 (GMT)
Message-ID: <d6b991603d79cfbaf05c93f8b662860b865d861b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 May 2021 09:03:23 -0700
In-Reply-To: <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
         <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
         <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
         <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J3eWov5232J_lTh8NNUvrd0Rb9wuA-eT
X-Proofpoint-ORIG-GUID: mAG4Un5fk-XPLIHybX4tnpxaPXgowfWu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_07:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210084
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2021-05-21 at 10:56 -0500, Brijesh Singh wrote:
[...]
> In case of the SEV-SNP and TDX, the guest OS participates during the
> attestation flow; the driver working on the behalf of userspace and
> does not have access to the secret, so it cannot populate the file
> with the secrets in it.

OK, so for a simple encrypted VM using root on luks, how in SNP does
the boot loader obtain the disk passphrase?

In the non SNP case, it's already upstream: OVMF finds the secret page
and converts it to an EFI config table, which is passed into grub. 
It's starting to sound like we'll need a new grub module for SNP which
will do an active attestation and receive the passphrase over some
channel secure against the cloud provider.  Could you give us an
example of how you think this flow will work?

Thanks,

James


