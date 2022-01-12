Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CE848CC33
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbiALToE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 14:44:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242012AbiALTmU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 14:42:20 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CIrYZh010590;
        Wed, 12 Jan 2022 19:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LoOm8uqxQR+nKIJB4PO8wiHFx1IfpcpGJzsbrjBhpVM=;
 b=YN5Jd0E0osKTQxFo/JC/cwhMPXEULt2HC/YfHK0lg+J/vYNLkYLuIkTazmH3/CO4tQkD
 PNoWqo4ElolYS5X27qoFyn9Mv9GTMQ2SUvAd+NZOA6VwXFzVw8BVIAbqPRL20fiAMMJe
 RZ99nmXJoIynUEq7vw7U7J+/aeqoP5gmV7c3PdIdJZLvGDTHTQYrYLdZ2xwarCK9B6tV
 8ALQu3HgpxsMaYjJaomt3CWWCC9lq1EiudzMkp2s5xnFJQeNCDp0y5Zq1ldQtDouoh7P
 2jmFXejHD9uU2gqqCzDHzlnhza6A3dECebpjPekhSvZzX3CYdenY+wyWiXNWji2PaGF6 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj22xmd2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 19:41:54 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20CJewR2011635;
        Wed, 12 Jan 2022 19:41:54 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj22xmd21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 19:41:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20CJMHig013108;
        Wed, 12 Jan 2022 19:41:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3df28acwnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 19:41:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20CJfnT335979524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 19:41:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C3752057;
        Wed, 12 Jan 2022 19:41:49 +0000 (GMT)
Received: from sig-9-65-71-51.ibm.com (unknown [9.65.71.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D651F52052;
        Wed, 12 Jan 2022 19:41:47 +0000 (GMT)
Message-ID: <2d681148b6ea57241f6a7c518dd331068a5f47b0.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/8] integrity: Introduce a Linux keyring called
 machine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Wed, 12 Jan 2022 14:41:47 -0500
In-Reply-To: <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
         <20220105235012.2497118-3-eric.snowberg@oracle.com>
         <883da244c04fcb07add9984859a09d7b1827880a.camel@linux.ibm.com>
         <100B070F-7EB4-4BF7-B2B9-E5AE78D3066A@oracle.com>
         <a384fcf8bdd9ff79456e9669fc61ab50ec4e1c55.camel@linux.ibm.com>
         <F1F41DB2-171A-4A6F-9AE7-E03C4D3B7DD0@oracle.com>
         <eece68eba2beceeb410748c1f9f32162793d2057.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yibQjF2rx3U1wwXi2TNxQ2B6RIqK-wK3
X-Proofpoint-ORIG-GUID: 3Rn-3sr2We5w9O-YqLkyNH-jBopmSzQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201120114
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2022-01-11 at 20:14 -0500, Mimi Zohar wrote:
> On Tue, 2022-01-11 at 21:26 +0000, Eric Snowberg wrote:
> > 
> > > On Jan 11, 2022, at 11:16 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > 
> > > On Mon, 2022-01-10 at 23:25 +0000, Eric Snowberg wrote:
> > >>> Jarkko, my concern is that once this version of the patch set is
> > >>> upstreamed, would limiting which keys may be loaded onto the .machine
> > >>> keyring be considered a regression?
> > >> 
> > >> 
> > >> Currently certificates built into the kernel do not have a CA restriction on them.  
> > >> IMA will trust anything in this keyring even if the CA bit is not set.  While it would 
> > >> be advisable for a kernel to be built with a CA, nothing currently enforces it. 
> > >> 
> > >> My thinking for the dropped CA restriction patches was to introduce a new Kconfig.  
> > >> This Kconfig would do the CA enforcement on the machine keyring.  However if the 
> > >> Kconfig option was not set for enforcement, it would work as it does in this series, 
> > >> plus it would allow IMA to work with non-CA keys.  This would be done by removing 
> > >> the restriction placed in this patch. Let me know your thoughts on whether this would 
> > >> be an appropriate solution.  I believe this would get around what you are identifying as 
> > >> a possible regression.
> > > 
> > > True the problem currently exists with the builtin keys, but there's a
> > > major difference between trusting the builtin keys and those being
> > > loading via MOK.  This is an integrity gap that needs to be closed and
> > > shouldn't be expanded to keys on the .machine keyring.
> > > 
> > > "plus it would allow IMA to work with non-CA keys" is unacceptable.
> > 
> > Ok, I’ll leave that part out.  Could you clarify the wording I should include in the future 
> > cover letter, which adds IMA support, on why it is unacceptable for the end-user to
> > make this decision?
> 
> The Kconfig IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> "help" is very clear:

[Reposting the text due to email formatting issues.]

help
  Keys may be added to the IMA or IMA blacklist keyrings, if the
  key is validly signed by a CA cert in the system built-in or
  secondary trusted keyrings.

  Intermediate keys between those the kernel has compiled in and the 
  IMA keys to be added may be added to the system secondary keyring,
  provided they are validly signed by a key already resident in the
  built-in or secondary trusted keyrings.


The first paragraph requires "validly signed by a CA cert in the system
built-in or secondary trusted keyrings" for keys to be loaded onto the
IMA keyring.  This Kconfig is limited to just the builtin and secondary
keyrings.  Changing this silently to include the ".machine" keyring
introduces integrity risks that previously did not exist.  A new IMA
Kconfig needs to be defined to allow all three keyrings - builtin,
machine, and secondary.

The second paragraph implies that only CA and intermediate CA keys are
on secondary keyring, or as in our case the ".machine" keyring linked
to the secondary keyring.

Mimi

